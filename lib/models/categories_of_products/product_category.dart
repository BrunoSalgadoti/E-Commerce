import 'dart:convert';
import 'dart:io';

import 'package:brn_ecommerce/common/functions/common_functions.dart';
import 'package:brn_ecommerce/models/categories_of_products/product_sub_category.dart';
import 'package:brn_ecommerce/services/development_monitoring/firebase_performance.dart';
import 'package:brn_ecommerce/services/development_monitoring/monitoring_logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProductCategory extends ChangeNotifier {
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

  ProductCategory.fromDocument(DocumentSnapshot document) {
    PerformanceMonitoring().startTrace('categoryFromMap', shouldStart: true);

    if (!kReleaseMode) {
      MonitoringLogger().logInfo('Message: CategoryFromMap');
    }

    categoryID = document["categoryID"] as String;
    categoryTitle = document["categoryTitle"] as String? ?? "";
    categoryColor = document["categoryColor"] as String? ?? "";
    categoryRealColor = getColorFromString(categoryColor ?? "");
    categoryImg = document["categoryImg"] as String? ?? "";
    categoryActivated = (document["categoryActivated"] ?? false) as bool;
    subCategoryList = (document["subCategoryList"] as List<dynamic>)
        .map((d) => SubCategory.fromMap(d as Map<String, dynamic>))
        .toList();

    PerformanceMonitoring().stopTrace('categoryFromMap');
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  DocumentReference get firestoreRef =>
      firestore.doc("categories/$categoryID");

  Reference get storageRef =>
      storage.ref().child("categories").child("$categoryID!");

  String? categoryID;
  String? categoryTitle;
  Color? categoryRealColor;
  String? categoryColor;
  dynamic categoryImg;
  bool? categoryActivated;
  List<SubCategory>? subCategoryList;

  //TODO: Implementação em verificação

  // Future<List<ProductCategory>> fetchCategories() async {
  //   final categoriesQuery = await firestore.collection("categories").get();
  //   final categories = categoriesQuery.docs.map((doc) {
  //     final categoryData = doc.data() as Map<String, dynamic>;
  //     final subCategoriesData = categoryData["subCategoryList"] as List<dynamic>;
  //
  //     // Mapeie os dados da categoria para um objeto ProductCategory
  //     final productCategory = ProductCategory.fromDocument(doc);
  //
  //     // Preencha a lista de subcategorias com base nos dados obtidos
  //     productCategory.subCategoryList = subCategoriesData
  //         .map((subCatData) => SubCategory.fromMap(subCatData))
  //         .toList();
  //
  //     return productCategory;
  //   }).toList();
  //
  //   return categories;
  // }

  //TODO: implementar na interface para verificação

  // bool verifySubCategoriesIsNotEmpty() {
  //   if (subCategoryList == [] || subCategoryList == null) return true;
  //   return false;
  // }

  List<Map<String, dynamic>>? exportSubCategories() {
    return subCategoryList?.map((sub) => sub.toMap()).toList();
  }

  Map<String, dynamic> toMap() {
    return {
      "categoryID": categoryID,
      "categoryTitle": categoryTitle,
      "categoryColor": getHexColor(categoryRealColor ?? Colors.blueGrey),
      "categoryImg": categoryImg,
      "categoryActivated": categoryActivated,
      "subCategoryList": exportSubCategories() ?? [],
    };
  }

  Future<void> updateCategoryImage(dynamic image) async {
    PerformanceMonitoring()
        .startTrace('update-category-image', shouldStart: true);
    if (!kReleaseMode) {
      MonitoringLogger().logInfo('Starting file upload Category');
    }

    if (categoryImg != null && categoryImg != "") {
      final oldImageRef = storage.refFromURL(categoryImg);
      await oldImageRef.delete();
    }

    if (kIsWeb) {
      final base64String = image?.split(',').last;
      const String validCharacters =
          "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789+/=";
      final trimmedString =
          base64String?.replaceAll(RegExp("[^$validCharacters]"), "");
      if (base64String is String &&
          base64String.isNotEmpty &&
          base64String.length % 4 == 0) {
        try {
          final List<int> bytes = base64.decode(trimmedString!);
          final Uint8List uint8ListBytes = Uint8List.fromList(bytes);
          final metadata = SettableMetadata(contentType: "image/jpeg");
          final task = storageRef
              .child("$categoryID!")
              .putData(uint8ListBytes, metadata);
          final snapshot = await task.whenComplete(() {});
          final url = await snapshot.ref.getDownloadURL();
          image = url;
        } catch (e) {
          if (kDebugMode) {
            print('Erro ao decodificar o base64String: $e');
          }
        }
      }
    } else if (image is File) {
      final UploadTask task = storageRef.child("$categoryID!").putFile(image);
      final TaskSnapshot snapshot = await task.whenComplete(() {});
      final String url = await snapshot.ref.getDownloadURL();
      image = url;
    }

    await firestoreRef.update({"categoryImg": image});

    categoryImg = image;
    notifyListeners();

    PerformanceMonitoring().stopTrace('update-category-image');
  }

  @override
  String toString() {
    return 'ProductCategory{categoryID: $categoryID, '
        'categoryTitle: $categoryTitle, categoryColor: $categoryColor, '
        'categoryImg: $categoryImg, categoryActivated: $categoryActivated}';
  }
}
