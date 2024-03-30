import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:brn_ecommerce/models/details_products.dart';
import 'package:brn_ecommerce/services/development_monitoring/firebase_performance.dart';
import 'package:brn_ecommerce/services/development_monitoring/monitoring_logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart' show ChangeNotifier, kIsWeb, kReleaseMode;
import 'package:uuid/uuid.dart';

class Product extends ChangeNotifier {
  Product({
    this.id,
    this.name,
    this.description,
    this.images,
    this.itemProducts,
    this.deleted = false,
    this.advertising = false,
    this.isValid,
    this.errorMessage,
    this.details,
    this.brand = "",
    this.freight,
    this.categoryOfProduct = "",
    this.insertionDate,
  }) {
    images = images ?? [];
    itemProducts = itemProducts ?? [];
    details = details ?? DetailsProducts(stock: 0);
  }

  Product.fromDocument(DocumentSnapshot document) {
    PerformanceMonitoring().startTrace('product-document', shouldStart: true);

    if (!kReleaseMode) {
      MonitoringLogger().logInfo('Debug message: Instance Product.fromDocument');
    }

    id = document.id;
    name = document["name"] as String? ?? "";
    description = document["description"] as String? ?? "";
    images = List<String>.from(document["images"] as List<dynamic>);
    deleted = (document["deleted"] ?? false) as bool;
    advertising = (document["advertising"] ?? false) as bool;
    isValid = (document["isvalid"] ?? true) as bool;
    brand = document["brand"] as String? ?? "";
    freight = document["freight"] as bool;
    insertionDate = (document["insertionDate"] ?? Timestamp.now()) as Timestamp;
    categoryOfProduct = document["categoryOfProduct"] as String? ?? "";
    itemProducts = (document["details"] as List<dynamic>)
        .map((d) => DetailsProducts.fromMap(d as Map<String, dynamic>))
        .toList();

    PerformanceMonitoring().stopTrace('product-document');
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  DocumentReference get firestoreRef => firestore.doc("products/$id");

  Reference get storageRef => storage.ref().child("products").child(id!);

  String? id;
  String? name;
  String? description;
  String? errorMessage;
  String brand = "";
  bool? freight;
  bool deleted = false;
  bool advertising = false;
  bool? isValid;
  String? categoryOfProduct;
  Timestamp? insertionDate;
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

  int get totalSellers {
    int sellers = 0;
    for (final item in itemProducts!) {
      sellers += item.sellers;
    }
    return sellers;
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

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "brand": brand,
      "freight": freight ?? true,
      "description": description,
      "details": exportDetailsList(),
      "deleted": deleted,
      "advertising": advertising,
      "isvalid": isValid,
      "categoryOfProduct": categoryOfProduct,
      "insertionDate": Timestamp.now(),
    };
  }

  List<Map<String, dynamic>>? exportDetailsList() {
    return itemProducts!.map((details) => details.toMap()).toList();
  }

  Future<void> saveProduct() async {
    PerformanceMonitoring().startTrace('save_product', shouldStart: true);
    if (!kReleaseMode) {
      MonitoringLogger().logDebug('Debug message: Instance starting saveProduct');
    }

    loading = true;

    if (id == null) {
      final doc = await firestore.collection("products").add(toMap());
      id = doc.id;
    } else {
      await firestoreRef.update(toMap());
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
          final task = storageRef.child(const Uuid().v4()).putData(uint8ListBytes, metadata);
          final snapshot = await task.whenComplete(() {});
          final url = await snapshot.ref.getDownloadURL();
          updateImages.add(url);
        } else {
          final UploadTask task = storageRef.child(const Uuid().v4()).putFile(newImage as File);
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

    PerformanceMonitoring().stopTrace('save_product');
    if (!kReleaseMode) {
      MonitoringLogger().logDebug('Debug message: Instance ending saveProduct');
    }
  }

  Future<void> deleteProductWithZeroStockOneImage() async {
    for (final details in itemProducts!) {
      // Zero stock in every detail
      details.stock = 0;

      // Zeros the amount of colors in each detail
      if (details.colorProducts != null) {
        for (final color in details.colorProducts!) {
          color.amount = 0;
        }
      }
    }

    final List<Map<String, dynamic>> updatedDetailsList =
        itemProducts!.map((details) => details.toMap()).toList();
    await firestoreRef.update({"details": updatedDetailsList});

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
    images = [imageUrls.first]; // Mantém apenas a primeira imagem

    // Updates the product in the database with a single image [0]
    await firestoreRef.update({
      "images": images,
    });
    await firestoreRef.update(toMap());
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
      brand: brand,
      freight: freight ?? true,
      description: description,
      images: List.from(images!),
      itemProducts: itemProducts?.map((items) => items.clone()).toList(),
      deleted: deleted,
      advertising: advertising,
      isValid: isValid,
      categoryOfProduct: categoryOfProduct,
    );
  }

  Future<void> checkAmountsAndStocksConsistency(
      String productId, List<DetailsProducts> detailsProducts) async {
    isValid = true; // Assume initially that it is valid

    for (final stock in detailsProducts) {
      final matchingDetails = detailsProducts.firstWhere((details) => details.size == stock.size);

      final int totalAmount = matchingDetails.colorProducts!.fold(0, (a, b) => a + b.amount);

      if (totalAmount != stock.stock) {
        isValid = false; // Inconsistency found

        final DocumentReference productRef =
            FirebaseFirestore.instance.collection("products").doc(productId);

        await productRef.update({"isvalid": false});

        errorMessage = 'A Qtd. de ESTOQUE está diferente da de Cores!!!\n'
            'Favor revisar o ESTOQUE e a Qtd. de CORES equivalentes ao Tamanho!\n'
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
