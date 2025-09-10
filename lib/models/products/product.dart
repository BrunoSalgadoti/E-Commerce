import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:brn_ecommerce/models/products/details_products.dart';
import 'package:brn_ecommerce/services/development_monitoring/firebase_performance.dart';
import 'package:brn_ecommerce/services/development_monitoring/monitoring_logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart' show ChangeNotifier, kDebugMode, kIsWeb;
import 'package:uuid/uuid.dart';

/// # Product (Folder: models/products)
///
/// A class representing a product with various properties and methods for managing product data.
///
/// This class handles the management of product information such as name, description, images, stock, pricing details, and more.
class Product extends ChangeNotifier {
  // Properties

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  String? id;
  String? name;
  String? description;
  String? stockErrorMessage;
  String brand = "";
  String? categoryOfProduct;
  bool? freight;
  bool deleted = false;
  bool advertising = false;
  bool _loading = false;
  bool? isValid;
  bool? highlight;
  List<String>? images;
  List<dynamic>? newImages;
  Timestamp? insertionDate;


  /// If you need to use only one detail (selected variation, for example)
  DetailsProducts? details;

  /// List of variations/product details (colors, sizes, etc.)
  List<DetailsProducts>? itemProducts;

  // Constructor

  /// Initializes an instance of [Product] with the specified parameters.
  ///
  /// The constructor allows setting various properties of the product.
  Product({
    this.id,
    this.name,
    this.description,
    this.images,
    this.itemProducts,
    this.deleted = false,
    this.advertising = false,
    this.isValid,
    this.stockErrorMessage,
    this.details,
    this.brand = "",
    this.freight,
    this.categoryOfProduct = "",
    this.insertionDate,
    this.highlight = false,
  }) {
    images = images ?? [];
    itemProducts = itemProducts ?? [];
    details = details ?? DetailsProducts(stock: 0);
  }

  /// Creates a [Product] instance from a Firestore document snapshot.
  ///
  /// Constructor creates a product instance based on the data retrieved from a Firestore document snapshot.
  Product.fromDocument(DocumentSnapshot document) {
    PerformanceMonitoring().startTrace('product-document', shouldStart: true);

    if (kDebugMode) {
      MonitoringLogger().logInfo('Debug message: Instance Product.fromDocument');
    }

    id = document.id;
    name = document["name"] as String? ?? "";
    description = document["description"] as String? ?? "";
    images = List<String>.from(document["images"] as List<dynamic>);
    deleted = (document["deleted"] ?? false) as bool;
    advertising = (document["advertising"] ?? false) as bool;
    isValid = (document["isvalid"] ?? true) as bool;
    highlight = (document["highlight"] ?? false) as bool;
    brand = document["brand"] as String? ?? "";
    freight = document["freight"] as bool;
    insertionDate = (document["insertionDate"] ?? Timestamp.now()) as Timestamp;
    categoryOfProduct = document["categoryOfProduct"] as String? ?? "";
    itemProducts = (document["details"] as List<dynamic>)
        .map((d) => DetailsProducts.fromMap(d as Map<String, dynamic>))
        .toList();

    PerformanceMonitoring().stopTrace('product-document');
  }

  // Methods

  /// Converts the product data to a map for Firestore storage.
  ///
  /// This method converts the product properties into a map format suitable for storing in Firestore.
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
      "highlight" : highlight,
      "categoryOfProduct": categoryOfProduct,
      "insertionDate": Timestamp.now(),
    };
  }

  /// Returns the Firestore reference for the product document.
  DocumentReference get firestoreRef => firestore.doc("products/$id");

  /// Returns the storage reference for the product images.
  Reference get storageRef => storage.ref().child("products").child(id!);

  // Getters and Setters

  /// Indicates if the product is currently loading data.
  bool get loading => _loading;

  /// Sets the loading state of the product.
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  /// Returns the selected details of the product.
  DetailsProducts? get selectedDetails => details;

  /// Sets the selected details of the product.
  set selectedDetails(DetailsProducts? value) {
    details = value;
    notifyListeners();
  }

  /// Calculates and returns the total stock of the product.
  int get totalStock {
    int stock = 0;
    for (final item in itemProducts!) {
      stock += item.stock;
    }
    return stock;
  }

  /// Calculates and returns the total number of sellers for the product.
  int get totalSellers {
    int sellers = 0;
    for (final item in itemProducts!) {
      sellers += item.sellers;
    }
    return sellers;
  }

  /// Indicates if the product has available stock.
  bool get hasStock {
    return totalStock > 0 && !deleted && isValid!;
  }

  /// Calculates and returns the base price of the product.
  num get basePrice {
    num lowest = double.infinity;
    for (final details in itemProducts!) {
      if (details.price! < lowest && details.hasStock) {
        lowest = details.price!;
      }
    }
    return lowest;
  }

  /// Finds and returns details related to a specific size.
  DetailsProducts? findSize(String name) {
    try {
      return itemProducts?.firstWhere((s) => s.size == name);
    } catch (error) {
      return null;
    }
  }

  /// Exports the details of the product to a list of maps.
  List<Map<String, dynamic>>? exportDetailsList() {
    return itemProducts!.map((details) => details.toMap()).toList();
  }

  /// Saves the product data to Firestore.
  Future<void> saveProduct() async {
    PerformanceMonitoring().startTrace('save_product', shouldStart: true);
    if (kDebugMode) {
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
    if (kDebugMode) {
      MonitoringLogger().logDebug('Debug message: Instance ending saveProduct');
    }
  }

  /// Deletes the product from Firestore and associated images.
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

  /// Deletes the product from Firestore and associated images.
  void deleteProduct() async {
    // Call method to update inventory to zero and one image
    await deleteProductWithZeroStockOneImage();

    // Set the product as deleted
    await firestoreRef.update({"deleted": true});
    notifyListeners();
  }

  /// Checks the consistency of amounts and stocks for the product.
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

        stockErrorMessage = 'A Qtd. de ESTOQUE está diferente da de Cores!!!\n'
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
      }
      notifyListeners();
    }
  }

  /// Clones the current product instance.
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
      highlight: highlight,
      insertionDate: Timestamp.now(),
      categoryOfProduct: categoryOfProduct,
    );
  }
}
