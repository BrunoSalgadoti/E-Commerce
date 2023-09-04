import 'dart:async';

import 'package:brn_ecommerce/models/product.dart';
import 'package:brn_ecommerce/models/products_best_selling.dart';
import 'package:brn_ecommerce/services/development_monitoring/firebase_performance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../services/development_monitoring/monitoring_logger.dart';

enum StatusOfProducts {
  bestSellers,
  lowestPrice,
  brand,
  freight,
  sortedAZ,
  sortedZA,
}

class ProductManager extends ChangeNotifier {
  ProductManager() {
    _listenToProducts();

    bestSellingProductsManager = ProductsBestSelling(
      allProducts: allProducts,
      salesThreshold: 10, // Set the appropriate sales margin
    );
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  StreamSubscription<dynamic>? _subscription;

  ProductsBestSelling? bestSellingProductsManager;

  List<Product> allProducts = [];
  StatusOfProducts? status;
  String? selectedBrand;
  String? activeFilterName = "";
  bool filtersOn = false;
  List<StatusOfProducts> statusFilter = [];

  get selectedStatus => status;

  String _filtered = '';

  String get filtered => _filtered;

  set filtered(String value) {
    _filtered = value;
    notifyListeners();
  }

  String _search = '';

  String get search => _search;

  set search(String value) {
    _search = value;
    notifyListeners();
  }

  List<Product> get filteredProducts {
    final List<Product> filteredProducts = [];

    if (filtered.isEmpty) {
      filteredProducts.addAll(allProducts);
    }
    if (search.isNotEmpty) {
      filteredProducts.clear();
      filteredProducts.addAll(allProducts
          .where((p) => p.name!.toLowerCase().contains(search.toLowerCase())));
    }
    if (statusFilter.contains(StatusOfProducts.bestSellers)) {
      filteredProducts.clear();
      statusFilter = [];
      List<Product> bestSellingProducts =
          bestSellingProductsManager!.getBestSellingProducts(15);
      filteredProducts.addAll(bestSellingProducts);
    }

    if (statusFilter.contains(StatusOfProducts.lowestPrice)) {
      filteredProducts.clear();
      statusFilter = [];
      filteredProducts.addAll(
          allProducts.where((product) => product.basePrice > 0).toList()
            ..sort((a, b) => a.basePrice.compareTo(b.basePrice)));
    }

    if (statusFilter.contains(StatusOfProducts.brand)) {
      filteredProducts.clear();
      statusFilter = [];
      filteredProducts
          .addAll(allProducts.where((product) => product.brand.trim() != ""));
      filteredProducts.sort((a, b) => a.brand.compareTo(b.brand));
    }

    if (statusFilter.contains(StatusOfProducts.freight)) {
      filteredProducts.clear();
      statusFilter = [];
      filteredProducts
          .addAll(allProducts.where((product) => !product.freight!));
    }

    if (statusFilter.contains(StatusOfProducts.sortedAZ)) {
      filteredProducts.clear();
      statusFilter = [];
      filteredProducts.addAll(allProducts);
      filteredProducts.sort((a, b) => a.name!.compareTo(b.name!));
    }

    if (statusFilter.contains(StatusOfProducts.sortedZA)) {
      filteredProducts.clear();
      statusFilter = [];
      filteredProducts.addAll(allProducts);
      filteredProducts.sort((a, b) => b.name!.compareTo(a.name!));
    }

    return filteredProducts;
  }

  void _listenToProducts() async {
    PerformanceMonitoring().startTrace('listen_products', shouldStart: true);
    if (!kReleaseMode) {
      MonitoringLogger().logInfo('Starting listen products');
    }

    _subscription = firestore
        .collection("products")
        .where("deleted", isEqualTo: false)
        .snapshots()
        .listen((event) {
      allProducts.clear();
      for (final product in event.docs) {
        // Make sure the document is complete before creating a Product instance
        if (product.data().containsKey("name") &&
            product.data().containsKey("deleted") &&
            product.data().containsKey("isvalid") &&
            product.data().containsKey("brand") &&
            product.data().containsKey("freight") &&
            product.data().containsKey("description") &&
            product.data().containsKey("images") &&
            product.data().containsKey("details")) {
          allProducts.add(Product.fromDocument(product));
        }
      }
      notifyListeners();
    });
    PerformanceMonitoring().stopTrace('listen_products');
  }

  Product? findProductById(String id) {
    try {
      return allProducts.firstWhere((p) => p.id == id);
    } catch (error) {
      return null;
    }
  }

  void updateProducts(Product product) {
    allProducts.removeWhere((p) => p.id == product.id);
    allProducts.add(product);
    notifyListeners();
  }

  void requestDelete(Product product) {
    product.deleteProduct();
    allProducts.removeWhere((p) => p.id == product.id);
    notifyListeners();
  }

  void disableFilter() {
    filtersOn = false;
    statusFilter = [];
    filteredProducts.clear();
    notifyListeners();
  }

  void setActiveFilterName(String name) {
    activeFilterName = name;
    notifyListeners();
  }

  void setStatusFilter({StatusOfProducts? status, bool? enabled}) {
    if (enabled!) {
      filtersOn = true;
      statusFilter.add(status!);
      setActiveFilterName(getStatusText(status));
    } else {
      statusFilter.remove(status);
      setActiveFilterName("");
      filtersOn = false;
    }
    notifyListeners();
  }

  String? get statusText => getStatusText(status!);

  static String getStatusText(StatusOfProducts status) {
    switch (status) {
      case StatusOfProducts.bestSellers:
        return 'Mais Vendidos';
      case StatusOfProducts.lowestPrice:
        return 'Menor Preço';
      case StatusOfProducts.brand:
        return 'Por Marca';
      case StatusOfProducts.freight:
        return 'Frete Gratis';
      case StatusOfProducts.sortedAZ:
        return 'De A-Z';
      case StatusOfProducts.sortedZA:
        return 'De Z-A';
      default:
        return '';
    }
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
  }
}
