import 'package:brn_ecommerce/common/functions/common_functions.dart';
import 'package:brn_ecommerce/models/product_sub_category.dart';
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
      MonitoringLogger().logInfo('Message: CategoryFromMap.fromDocument');
    }

    categoryID = document[categoryID ?? ""] as String;
    categoryTitle = document["categoryTitle"] as String? ?? "";
    categoryColor = document["categoryColor"] as String? ?? "";
    categoryRealColor = getColorFromString(categoryColor!);
    categoryImg = document["categoryImg"] as String? ?? "";
    categoryActivated = (document["categoryActivated"] ?? false) as bool;
    // subCategoryList = (document["details"] as List<dynamic>)
    //     .map((d) => SubCategory.fromMap(d as Map<String, dynamic>))
    //     .toList();

    PerformanceMonitoring().stopTrace('categoryFromMap');
  }

  String? categoryID;
  String? categoryTitle;
  Color? categoryRealColor;
  String? categoryColor;
  String? categoryImg;
  bool? categoryActivated;
  List<SubCategory>? subCategoryList;

  bool _loading = false;

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  DocumentReference get firestoreRef => firestore.doc("categories/$categoryID");

  Reference get storageRef =>
      storage.ref().child("categories").child(categoryID!);

  List<Map<String, dynamic>>? exportSubCategories() {
    return subCategoryList!.map((sub) => sub.toMap()).toList();
  }

  Map<String, dynamic> toMap() {
    return {
      "categoryID": categoryID,
      "categoryTitle": categoryTitle,
      "categoryColor": getHexColor(categoryRealColor ?? Colors.blueGrey),
      "categoryImg": categoryImg,
      "categoryActivated": categoryActivated,
      "subCategoryList": exportSubCategories(),
    };
  }

  Future<void> saveCategories() async {
    PerformanceMonitoring().startTrace('save_categories', shouldStart: true);
    if (!kReleaseMode) {
      MonitoringLogger().logDebug('Message: SAVE Categories');
    }

    loading = true;

    final Map<String, dynamic> data = {
      "categoryColor": categoryColor,
      "categoryImg": categoryImg,
      "categoryActivated": categoryActivated,
      "details": exportSubCategories(),
    };

    await firestoreRef.update(data);

    // final List<String> updateImages = [];
    // for (final newImage in newImages!) {
    //   if (images!.contains(newImage)) {
    //     updateImages.add(newImage as String);
    //   } else {
    //     if (kIsWeb) {
    //       final List<int> bytes = base64.decode(newImage.split(',').last);
    //       final Uint8List uint8ListBytes = Uint8List.fromList(bytes);
    //       final metadata = SettableMetadata(contentType: "image/jpeg");
    //       final task = storageRef
    //           .child(const Uuid().v4())
    //           .putData(uint8ListBytes, metadata);
    //       final snapshot = await task.whenComplete(() {});
    //       final url = await snapshot.ref.getDownloadURL();
    //       updateImages.add(url);
    //     } else {
    //       final UploadTask task =
    //       storageRef.child(const Uuid().v4()).putFile(newImage as File);
    //       final TaskSnapshot snapshot = await task.whenComplete(() {});
    //       final String url = await snapshot.ref.getDownloadURL();
    //       updateImages.add(url);
    //     }
    //   }
    // }
    //
    // for (final image in images!) {
    //   try {
    //     if (!newImages!.contains(image) && image.contains("firebase")) {
    //       final ref = storage.refFromURL(image);
    //       await ref.delete();
    //     }
    //   } catch (error) {
    //     return;
    //   }
    // }
    //
    // await firestoreRef.update({"images": updateImages});
    //
    // images = updateImages;

    loading = false;

    PerformanceMonitoring().stopTrace('save_categories');
  }

  ProductCategory cloneCategory() {
    return ProductCategory(
      categoryID: categoryID ?? "",
      categoryTitle: categoryTitle ?? "",
      categoryRealColor: categoryRealColor ?? Colors.transparent,
      categoryImg: categoryImg ?? "",
      categoryActivated: categoryActivated ?? false,
      subCategoryList:
          subCategoryList?.map((items) => items.cloneSubCategory()).toList() ??
              [],
    );
  }
}
