import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:brn_ecommerce/models/details_products.dart';
import 'package:brn_ecommerce/services/development_monitoring/firebase_performance.dart';
import 'package:brn_ecommerce/services/development_monitoring/monitoring_logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart' show ChangeNotifier, kIsWeb;
import 'package:uuid/uuid.dart';

class Product extends ChangeNotifier {
  final logger = LoggerService();

  Product({
    this.id,
    this.name,
    this.description,
    this.images,
    this.itemProducts,
    this.deleted = false,
    this.isValid,
    this.errorMessage,
    this.details,
  }) {
    images = images ?? [];
    itemProducts = itemProducts ?? [];
    details = details ?? DetailsProducts(stock: 0);
  }

  Product.fromDocument(DocumentSnapshot document) {
    PerformanceMonitoring()
        .startTrace('product-from-document', shouldStart: true);
    logger.logInfo('Debug message: Instance Product.fromDocument');

    id = document.id;
    name = document["name"] as String? ?? "";
    description = document["description"] as String? ?? "";
    images = List<String>.from(document["images"] as List<dynamic>);
    deleted = (document["deleted"] ?? false) as bool;
    isValid = (document["isvalid"] ?? true) as bool;
    itemProducts = (document["details"] as List<dynamic>)
        .map((d) => DetailsProducts.fromMap(d as Map<String, dynamic>))
        .toList();

    PerformanceMonitoring().stopTrace('product-from-document');
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  DocumentReference get firestoreRef => firestore.doc("products/$id");

  Reference get storageRef => storage.ref().child("products").child(id!);

  String? id;
  String? name;
  String? description;
  String? errorMessage;
  bool deleted = false;
  bool? isValid;
  List<String>? images;
  List<dynamic>? newImages;
  List<DetailsProducts>? itemProducts;

  bool _loading = false;

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  DetailsProducts? details;

  DetailsProducts? get selectedDetails => details;

  set selectedDetails(DetailsProducts? value) {
    details = value;
    notifyListeners();
  }

  int get totalStock {
    int stock = 0;
    for (final item in itemProducts!) {
      stock += item.stock;
    }
    return stock;
  }

  bool get hasStock {
    return totalStock > 0 && !deleted && isValid!;
  }

  num get basePrice {
    num lowest = double.infinity;
    for (final details in itemProducts!) {
      if (details.price! < lowest && details.hasStock) {
        lowest = details.price!;
      }
    }
    return lowest;
  }

  DetailsProducts? findSize(String name) {
    try {
      return itemProducts?.firstWhere((s) => s.size == name);
    } catch (error) {
      return null;
    }
  }

  List<Map<String, dynamic>>? exportDetailsList() {
    return itemProducts!.map((details) => details.toMap()).toList();
  }

  Future<void> saveProduct() async {
    PerformanceMonitoring().startTrace('saveProduct', shouldStart: true);
    logger.logDebug('Debug message: Instance starting saveProduct');

    loading = true;

    final Map<String, dynamic> data = {
      "name": name,
      "description": description,
      "details": exportDetailsList(),
      "deleted": deleted,
      "isvalid": isValid,
    };

    if (id == null) {
      final doc = await firestore.collection("products").add(data);
      id = doc.id;
    } else {
      await firestoreRef.update(data);
    }

    final List<String> updateImages = [];
    for (final newImage in newImages!) {
      if (images!.contains(newImage)) {
        updateImages.add(newImage as String);
      } else {
        if (kIsWeb) {
          final List<int> bytes = base64.decode(newImage.split(',').last);
          final Uint8List uint8ListBytes = Uint8List.fromList(bytes);
          final metadata = SettableMetadata(contentType: "image/jpeg");
          final task = storageRef
              .child(const Uuid().v4())
              .putData(uint8ListBytes, metadata);
          final snapshot = await task.whenComplete(() {});
          final url = await snapshot.ref.getDownloadURL();
          updateImages.add(url);
        } else {
          final UploadTask task =
              storageRef.child(const Uuid().v4()).putFile(newImage as File);
          final TaskSnapshot snapshot = await task.whenComplete(() {});
          final String url = await snapshot.ref.getDownloadURL();
          updateImages.add(url);
        }
      }
    }

    for (final image in images!) {
      try {
        if (!newImages!.contains(image) && image.contains("firebase")) {
          final ref = storage.refFromURL(image);
          await ref.delete();
        }
      } catch (error) {
        return;
      }
    }

    await firestoreRef.update({"images": updateImages});

    images = updateImages;

    loading = false;

    PerformanceMonitoring().stopTrace('saveProduct');
    logger.logDebug('Debug message: Instance ending saveProduct');
  }

  Future<void> deleteProductWithZeroStockOneImage() async {
    // Reset color stock keeping other details unchanged
    List<Map<String, dynamic>> exportDetailsList() {
      final List<Map<String, dynamic>> detailsList = [];

      for (final details in itemProducts!) {
        final Map<String, dynamic> detailsData = {
          ...details.toMap(),
          "stock": 0,
          "colors": details.colorProducts
              ?.map((color) => {
                    ...color.toMap(),
                    "amount": 0,
                  })
              .toList(),
        };
        detailsList.add(detailsData);
      }
      return detailsList;
    }

    final Map<String, dynamic> data = {
      "name": name,
      "description": description,
      "details": exportDetailsList(),
      "deleted": deleted,
      "isvalid": isValid,
    };

    // Deletes all images except the first one if there is more than one image
    if (images!.length > 1) {
      for (int i = 1; i < images!.length; i++) {
        final image = images![i];
        if (image.contains("firebase")) {
          try {
            final ref = storage.refFromURL(image);
            await ref.delete();
          } catch (error) {
            return;
          }
        }
      }
    }

    // Remove images from Firebase Storage
    final List<String> imageUrls = List<String>.from(images!);
    images = [imageUrls.first]; // Keeps only the first image

    // Updates the product in the database with the updated images
    await firestoreRef.update({
      "images": images,
    });

    await firestoreRef.update(data);
    await firestoreRef.update({"isvalid": false});
    notifyListeners();
  }

  void deleteProduct() async {
    // Call method to update inventory to zero and one image
    await deleteProductWithZeroStockOneImage();

    // Set the product as deleted
    await firestoreRef.update({"deleted": true});
    notifyListeners();
  }

  Product cloneProduct() {
    return Product(
      id: id,
      name: name,
      description: description,
      images: List.from(images!),
      itemProducts: itemProducts?.map((items) => items.clone()).toList(),
      deleted: deleted,
      isValid: isValid,
    );
  }

  Future<void> checkAmountsAndStocksConsistency(
      String productId, List<DetailsProducts> detailsProducts) async {
    isValid = true; // Assume inicialmente que é válido

    for (final stock in detailsProducts) {
      final matchingDetails =
          detailsProducts.firstWhere((details) => details.size == stock.size);

      final int totalAmount =
          matchingDetails.colorProducts!.fold(0, (a, b) => a + b.amount);

      if (totalAmount != stock.stock) {
        isValid = false; // Inconsistency found

        final DocumentReference productRef =
            FirebaseFirestore.instance.collection("products").doc(productId);

        await productRef.update({"isvalid": false});

        errorMessage = 'A quant. de ESTOQUE está diferente da de Cores!!!\n'
            'Favor revisar o ESTOQUE e a quat. de CORES equivalentes ao Tamanho!\n'
            'Tamanho: ${stock.size}, Estoque: ${stock.stock},'
            ' Total Cores: $totalAmount';

        break;
      }
      if (isValid!) {
        isValid = true;
        final DocumentReference productRef =
            FirebaseFirestore.instance.collection("products").doc(productId);

        await productRef.update({"isvalid": true});
        notifyListeners();
      }
      notifyListeners();
    }
  }
}
