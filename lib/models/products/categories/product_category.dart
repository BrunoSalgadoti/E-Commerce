import 'dart:convert';
import 'dart:io';

import 'package:brn_ecommerce/common/functions/common_functions.dart';
import 'package:brn_ecommerce/models/products/categories/product_sub_category.dart';
import 'package:brn_ecommerce/services/development_monitoring/firebase_performance.dart';
import 'package:brn_ecommerce/services/development_monitoring/monitoring_logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// #Products Categories classes (Folder: models/products/product_category)
/// ## ProductCategory Class
///
/// Represents a product category with detailed information such as ID, title, color,
/// image, activation status, and sub-categories.
///
/// This class includes methods for mapping data to and from Firestore documents,
/// updating category images, and exporting sub-categories.
class ProductCategory extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  String? categoryID;
  String? categoryTitle;
  String? categoryColor;
  bool? categoryActivated;
  dynamic categoryImg;
  Color? categoryRealColor;
  List<SubCategory>? subCategoryList;

  //Constructor

  /// Creates a [ProductCategory] object with the specified parameters.
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

  /// Creates a [ProductCategory] object from a Firestore document snapshot.
  ProductCategory.fromDocument(DocumentSnapshot document) {
    // Performance monitoring and logging...
    PerformanceMonitoring().startTrace('categoryFromMap', shouldStart: true);
    if (kDebugMode) {
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

  /// Converts the [ProductCategory] object to a map for serialization.
  ///
  /// Returns a map containing the category attributes as key-value pairs.
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

  DocumentReference get firestoreRef => firestore.doc("categories/$categoryID");

  Reference get storageRef => storage.ref().child("categories").child("$categoryID!");

  /// ## Method: exportSubCategories
  /// Converts the list of sub-categories into a list of maps.
  ///
  /// This method is used to export the sub-categories of a product category into a list of maps,
  /// which can then be serialized or stored in a database.
  ///
  /// Returns a list of maps containing the attributes of each sub-category.
  ///
  /// ```dart
  /// List<Map<String, dynamic>>? exportSubCategories() {
  ///   return subCategoryList?.map((sub) => sub.toMap()).toList();
  /// }
  /// ```
  List<Map<String, dynamic>>? exportSubCategories() {
    return subCategoryList?.map((sub) => sub.toMap()).toList();
  }

  /// ## Method: updateCategoryImage
  /// Updates the image of the product category.
  ///
  /// This method is used to update the image of a product category. It handles different scenarios
  /// based on the platform (web or mobile) and the type of image input (base64 string or file).
  /// If the category already has an image, the old image is deleted before uploading the new one.
  ///
  /// The method performs base64 decoding for web platforms and directly uploads files for mobile platforms.
  /// After updating the image, it triggers a database update and notifies listeners about the change.
  ///
  /// Parameters:
  /// - `image`: The new image to be set for the category.
  ///
  // ignore: unintended_html_in_doc_comment
  /// Returns: Future<void>
  ///
  /// ```dart
  Future<void> updateCategoryImage(dynamic image) async {
    PerformanceMonitoring().startTrace('update-category-image', shouldStart: true);
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
      final trimmedString = base64String?.replaceAll(RegExp("[^$validCharacters]"), "");
      if (base64String is String && base64String.isNotEmpty && base64String.length % 4 == 0) {
        try {
          final List<int> bytes = base64.decode(trimmedString!);
          final Uint8List uint8ListBytes = Uint8List.fromList(bytes);
          final metadata = SettableMetadata(contentType: "image/jpeg");
          final task = storageRef.child("$categoryID!").putData(uint8ListBytes, metadata);
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
