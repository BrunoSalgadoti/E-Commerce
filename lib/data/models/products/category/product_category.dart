import 'dart:convert';
import 'dart:io';

import 'package:brn_ecommerce/core/firestore_service.dart';
import 'package:brn_ecommerce/core/getters/core_getters_service.dart';
import 'package:brn_ecommerce/core/monitoring/monitoring_logger.dart';
import 'package:brn_ecommerce/core/storage_service.dart';
import 'package:brn_ecommerce/models/products/categories/product_sub_category.dart';
import 'package:brn_ecommerce/services/development_monitoring/firebase_performance.dart';
import 'package:brn_ecommerce/shared/utils/colors/color_parsers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProductCategory extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService.instance;

  final StorageService _storageService = StorageService.instance;

  final CoreGettersService _getters = CoreGettersService.instance;

  String? categoryID;
  String? categoryTitle;
  String? categoryColor;
  bool? categoryActivated;
  dynamic categoryImg;
  Color? categoryRealColor;
  List<SubCategory>? subCategoryList;

  ProductCategory({
    this.categoryID,
    this.categoryTitle,
    this.categoryRealColor,
    this.categoryImg,
    this.categoryActivated,
    this.subCategoryList,
    this.categoryColor,
  }) {
    subCategoryList = subCategoryList ?? [];
  }

  ProductCategory.fromDocument(
    DocumentSnapshot document,
  ) {
    PerformanceMonitoring().startTrace(
      'categoryFromMap',
      shouldStart: true,
    );

    if (kDebugMode) {
      MonitoringLogger().logInfo(
        'Message: CategoryFromMap',
      );
    }

    categoryID = document["categoryID"] as String;

    categoryTitle = document["categoryTitle"] as String? ?? "";

    categoryColor = document["categoryColor"] as String? ?? "";

    categoryRealColor = getColorFromString(categoryColor ?? "");

    categoryImg = document["categoryImg"] as String? ?? "";

    categoryActivated = (document["categoryActivated"] ?? false) as bool;

    subCategoryList = (document["subCategoryList"] as List<dynamic>)
        .map(
          (d) => SubCategory.fromMap(
            d as Map<String, dynamic>,
          ),
        )
        .toList();

    PerformanceMonitoring().stopTrace(
      'categoryFromMap',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "categoryID": categoryID,
      "categoryTitle": categoryTitle,
      "categoryColor": getHexColor(
        categoryRealColor ?? Colors.blueGrey,
      ),
      "categoryImg": categoryImg,
      "categoryActivated": categoryActivated,
      "subCategoryList": exportSubCategories() ?? [],
    };
  }

  DocumentReference<Map<String, dynamic>> get firestoreRef {
    return _getters.getDocumentRef(
      collection: "categories",
      docId: categoryID!,
    );
  }

  Reference get storageRef {
    return _getters.getStorageRef(
      path: "categories/$categoryID!",
    );
  }

  List<Map<String, dynamic>>? exportSubCategories() {
    return subCategoryList?.map((sub) => sub.toMap()).toList();
  }

  Future<void> updateCategoryImage(
    dynamic image,
  ) async {
    PerformanceMonitoring().startTrace(
      'update-category-image',
      shouldStart: true,
    );

    if (!kReleaseMode) {
      MonitoringLogger().logInfo(
        'Starting file upload Category',
      );
    }

    if (categoryImg != null && categoryImg != "") {
      await _storageService.deleteByUrl(
        categoryImg as String,
      );
    }

    if (kIsWeb) {
      final base64String = image?.split(',').last;

      const String validCharacters =
          "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789+/=";

      final trimmedString = base64String?.replaceAll(
        RegExp("[^$validCharacters]"),
        "",
      );

      if (base64String is String && base64String.isNotEmpty && base64String.length % 4 == 0) {
        try {
          final List<int> bytes = base64.decode(trimmedString!);

          final Uint8List uint8ListBytes = Uint8List.fromList(bytes);

          final String url = await _storageService.uploadData(
            path: "categories/$categoryID!/$categoryID!",
            data: uint8ListBytes,
            contentType: "image/jpeg",
          );

          image = url;
        } catch (e) {
          if (kDebugMode) {
            print(
              'Erro ao decodificar o base64String: $e',
            );
          }
        }
      }
    } else if (image is File) {
      final String url = await _storageService.uploadFile(
        path: "categories/$categoryID!/$categoryID!",
        file: image,
      );

      image = url;
    }

    await _firestoreService.updateDocument(
      collection: "categories",
      docId: categoryID!,
      data: {
        "categoryImg": image,
      },
    );

    categoryImg = image;

    notifyListeners();

    PerformanceMonitoring().stopTrace(
      'update-category-image',
    );
  }

  @override
  String toString() {
    return 'ProductCategory{categoryID: $categoryID, '
        'categoryTitle: $categoryTitle, '
        'categoryColor: $categoryColor, '
        'categoryImg: $categoryImg, '
        'categoryActivated: $categoryActivated}';
  }

// TODO(BRN): ProductCategory ainda concentra
// upload de imagem + persistência.
// Futuramente mover fluxo para repository/service.
}
