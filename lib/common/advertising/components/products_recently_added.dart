import 'package:brn_ecommerce/models/products/categories/product_category.dart';
import 'package:brn_ecommerce/models/products/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

/// # Products Recently Added (Folder: models/products)
///
/// A class responsible for managing the list of recently added products
/// and related operations.
///
/// This class handles the management of recently added products,
/// including methods to retrieve, update, and compare the list of products.
class ProductsRecentlyAdded extends ChangeNotifier {
  // Properties

  final List<Product> allProducts;
  List<Product> _recentProducts = [];

  // Constructor

  /// Initializes an instance of [ProductsRecentlyAdded] with the specified parameters.
  ///
  /// The [allProducts] parameter represents the list of all available products.
  ProductsRecentlyAdded({required this.allProducts});

  // Getters

  /// Returns the list of recently added products.
  List<Product> get recentProducts => _recentProducts;

  // Methods

  /// Retrieves the specified number of recently added products.
  ///
  /// If [withCategory] is true, filters by [productCategory].
  List<Product> getRecentProducts({int count = 10, required ProductCategory? productCategory}) {
    List<Product> sortedProducts;

    if (productCategory != null && productCategory.categoryID != null) {
      sortedProducts = allProducts
          .where(
              (p) => p.isValid! && p.hasStock && p.categoryOfProduct == productCategory.categoryID)
          .take(10)
          .toList();
    } else {
      sortedProducts = allProducts.where((p) => p.isValid! && p.hasStock).toList();
    }

    // Ordena pela data de inserção, mais recentes primeiro
    sortedProducts.sort((a, b) {
      final aInsertion = a.insertionDate ?? Timestamp.now();
      final bInsertion = b.insertionDate ?? Timestamp.now();
      return bInsertion.compareTo(aInsertion);
    });

    return sortedProducts.take(10).toList();
  }

  /// Updates the internal list of recently added products and notifies listeners if changed.
  ///
  /// Optional parameters [withCategory] and [productCategory] filter by category if needed.
  void updateRecentProducts({
    int count = 10,
    ProductCategory? productCategory,
  }) {
    final updatedProducts = getRecentProducts(
      count: count,
      productCategory: productCategory,
    );

    if (!_areListsEqual(updatedProducts, _recentProducts)) {
      _recentProducts = updatedProducts;
      notifyListeners();
    }
  }

  // Helper Methods

  /// Checks whether two lists of products are equal by comparing their IDs.
  bool _areListsEqual(List<Product> list1, List<Product> list2) {
    if (list1.length != list2.length) return false;

    for (int i = 0; i < list1.length; i++) {
      if (list1[i].id != list2[i].id) return false;
    }
    return true;
  }
}
