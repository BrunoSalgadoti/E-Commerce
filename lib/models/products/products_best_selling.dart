import 'package:brn_ecommerce/models/products/product.dart';
import 'package:flutter/foundation.dart';

/// # Products Best Selling (Folder: models/products)
///
/// A class responsible for managing the list of best-selling products and related operations.
///
/// This class handles the management of best-selling products, including methods to retrieve, ...
/// update, and compare the list of top-selling products.
class ProductsBestSelling extends ChangeNotifier {
  // Properties

  final List<Product> allProducts;
  final int salesThreshold; // Sales margin for upgrade
  List<Product> _bestSellingProducts = [];

  // Constructor

  /// Initializes an instance of [ProductsBestSelling] with the specified parameters.
  ///
  /// The [allProducts] parameter represents the list of all available products,
  /// and the optional [salesThreshold] parameter sets the minimum sales margin for a product to be considered best-selling.
  ProductsBestSelling({
    required this.allProducts,
    this.salesThreshold = 10,
  });

  // Getters

  /// Returns the list of best-selling products.
  List<Product> get bestSellingProducts => _bestSellingProducts;

  // Methods

  /// Retrieves the specified number of best-selling products.
  ///
  /// The [count] parameter determines the number of best-selling products to retrieve.
  List<Product> getBestSellingProducts(int count) {
    final sortedProducts = allProducts.toList()
      ..sort((a, b) => b.totalSellers.compareTo(a.totalSellers));

    return sortedProducts.take(count).toList();
  }

  /// Checks and updates the list of best-selling products if needed.
  ///
  /// Call this method periodically to ensure the list of best-selling products is up to date.
  void updateBestSellingProductsIfNeeded() {
    final updatedProducts = getBestSellingProducts(allProducts.length);

    if (!_areListsEqual(updatedProducts, bestSellingProducts)) {
      _bestSellingProducts = updatedProducts;
      notifyListeners();
    }
  }

  // Helper Methods

  /// Checks whether two lists of products are equal.
  ///
  /// The [list1] and [list2] parameters represent the lists of products to compare.
  /// Returns true if the lists are equal, false otherwise.
  bool _areListsEqual(List<Product> list1, List<Product> list2) {
    if (list1.length != list2.length) {
      return false;
    }

    for (int i = 0; i < list1.length; i++) {
      if (list1[i].id != list2[i].id) {
        return false;
      }
    }
    return true;
  }
}
