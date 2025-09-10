import 'dart:async';

import 'package:brn_ecommerce/models/products/components/products_best_selling.dart';
import 'package:brn_ecommerce/models/products/components/products_recently_added.dart';
import 'package:brn_ecommerce/models/products/product.dart';
import 'package:brn_ecommerce/services/development_monitoring/firebase_performance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../services/development_monitoring/monitoring_logger.dart';

/// # Product Manager (Folder: models/products)
/// ## StatusOfProducts
/// An enum to represent different states of products.
///
/// This enum defines the possible product states that can be used to filter products.
enum StatusOfProducts {
  bestSellers,
  recentlyAdded,
  lowestPrice,
  brand,
  freight,
  sortedAZ,
  sortedZA,
}

/// ## ProductManager
/// A class responsible for managing the list of products and their related operations.
///
/// This class handles product list management, including operations such as filtering, searching, updating and deleting.
class ProductManager extends ChangeNotifier {
  // Properties

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? activeFilterName;
  String _search = '';
  bool filtersOn = false;
  List<StatusOfProducts> statusFilter = [];
  List<StatusOfProducts> selectedFiltersByUser = [];
  List<Product> allProducts = [];
  StatusOfProducts? status;
  ProductsBestSelling? bestSellingProductsManager;
  ProductsRecentlyAdded? recentlyAddedProducts;
  StreamSubscription<dynamic>? _subscription;

  // Constructor

  /// Initialize an instance of [Product Manager] and start listening for products.
  ProductManager() {
    _listenToProducts();

    bestSellingProductsManager = ProductsBestSelling(
      allProducts: allProducts,
      salesThreshold: 10, // Set the appropriate sales margin
    );

    recentlyAddedProducts = ProductsRecentlyAdded(
      allProducts: allProducts,
    );
  }

  // Getters and Setters

  /// Returns the state of the selected product.
  StatusOfProducts? get selectedStatus => status;

  /// Returns only products marked as featured
  List<Product> get highlightedProducts {
    return allProducts
        .where((p) => (p.highlight ?? false) && !p.deleted && p.isValid == true && p.hasStock)
        .toList();
  }

  /// Sets the search query and notifies listeners.
  set search(String value) {
    _search = value;
    notifyListeners();
  }

  /// Returns the current search query.
  String get search => _search;

  /// Returns the filtered products based on the applied filters.
  List<Product> get filteredProducts {
    List<Product> filteredProducts = List.from(allProducts);

    if (search.isNotEmpty) {
      String searchQuery = search.toLowerCase();
      filteredProducts =
          filteredProducts.where((p) => p.name!.toLowerCase().contains(searchQuery)).toList();
    }

    if (statusFilter.contains(StatusOfProducts.bestSellers)) {
      List<Product> bestSellingProducts = bestSellingProductsManager!.getBestSellingProducts(15);
      filteredProducts =
          filteredProducts.where((product) => bestSellingProducts.contains(product)).toList();
    }

    if (statusFilter.contains(StatusOfProducts.recentlyAdded)) {
      List<Product> recentlyAdded = recentlyAddedProducts!.getRecentProducts(productCategory: null);
      filteredProducts =
          filteredProducts.where((product) => recentlyAdded.contains(product)).toList();
    }

    if (statusFilter.contains(StatusOfProducts.lowestPrice)) {
      filteredProducts = filteredProducts.where((product) => product.basePrice > 0).toList()
        ..sort((a, b) => a.basePrice.compareTo(b.basePrice));
    }

    if (statusFilter.contains(StatusOfProducts.brand)) {
      filteredProducts = filteredProducts.where((product) => product.brand.trim() != "").toList()
        ..sort((a, b) => a.brand.compareTo(b.brand));
    }

    if (statusFilter.contains(StatusOfProducts.freight)) {
      filteredProducts = filteredProducts.where((product) => !product.freight!).toList();
    }

    if (statusFilter.contains(StatusOfProducts.sortedAZ)) {
      filteredProducts.sort((a, b) => a.name!.compareTo(b.name!));
    }

    if (statusFilter.contains(StatusOfProducts.sortedZA)) {
      filteredProducts.sort((a, b) => b.name!.compareTo(a.name!));
    }

    return filteredProducts;
  }

  // Methods

  /// Starts listening for products in Firestore.
  void _listenToProducts() async {
    PerformanceMonitoring().startTrace('listen_products', shouldStart: true);
    if (kDebugMode) {
      MonitoringLogger().logInfo('Starting listen products');
    }
    _subscription = firestore
        .collection("products")
        .where("deleted", isEqualTo: false)
        .where("isvalid", isEqualTo: true)
        .snapshots()
        .listen((event) {
      allProducts.clear();
      for (final product in event.docs) {
        // Make sure the document is complete before creating a Product instance
        if (product.data().containsKey("name") &&
            product.data().containsKey("deleted") &&
            product.data().containsKey("advertising") &&
            product.data().containsKey("isvalid") &&
            product.data().containsKey("brand") &&
            product.data().containsKey("freight") &&
            product.data().containsKey("description") &&
            product.data().containsKey("images") &&
            product.data().containsKey("categoryOfProduct") &&
            product.data().containsKey("insertionDate") &&
            product.data().containsKey("highlight") &&
            product.data().containsKey("details")) {
          allProducts.add(Product.fromDocument(product));
        }
      }
      notifyListeners();
    });
    PerformanceMonitoring().stopTrace('listen_products');
  }

  /// Search for a product by its ID.
  Product? findProductById(String id) {
    try {
      return allProducts.firstWhere((p) => p.id == id);
    } catch (error) {
      return null;
    }
  }

  /// Updates the product list with an updated product.
  void updateProducts(Product product) {
    allProducts.removeWhere((p) => p.id == product.id);
    allProducts.add(product);
    notifyListeners();
  }

  /// Requests the deletion of a product.
  void requestDelete(Product product) {
    product.deleteProduct();
    allProducts.removeWhere((p) => p.id == product.id);
    notifyListeners();
  }

  /// Disables all filters.
  void disableFilter() {
    filtersOn = false;
    statusFilter.clear();
    selectedFiltersByUser.clear();
    filteredProducts.clear();
    notifyListeners();
  }

  /// Sets the products state filter and notifies listeners.
  void setStatusFilter({StatusOfProducts? status, bool? enabled}) {
    if (enabled!) {
      selectedFiltersByUser.add(status!);
      filtersOn = true;
      statusFilter.add(status);
      setActiveFilterName(getStatusText(selectedFiltersByUser[0]));
      notifyListeners();
    } else {
      statusFilter.remove(status);
      setActiveFilterName("");
      selectedFiltersByUser.clear();
      filtersOn = false;
      notifyListeners();
    }
    notifyListeners();
  }

  /// Defines the name of the currently active filter.
  void setActiveFilterName(String name) {
    activeFilterName = name;
    notifyListeners();
  }

  /// Returns the text corresponding to the product state.
  String? get statusText => getStatusText(status!);

  /// Returns the text corresponding to a given product state.
  static String getStatusText(StatusOfProducts status) {
    switch (status) {
      case StatusOfProducts.bestSellers:
        return 'Mais Vendidos';
      case StatusOfProducts.lowestPrice:
        return 'Menor Preço';
      case StatusOfProducts.recentlyAdded:
        return 'Adicionados recentemente';
      case StatusOfProducts.brand:
        return 'Por Marca';
      case StatusOfProducts.freight:
        return 'Frete Gratis';
      case StatusOfProducts.sortedAZ:
        return 'De A-Z';
      case StatusOfProducts.sortedZA:
        return 'De Z-A';
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    filteredProducts.clear();
    selectedFiltersByUser.clear();
    disableFilter();
    super.dispose();
  }
}
