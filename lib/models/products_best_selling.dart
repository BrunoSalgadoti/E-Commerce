import 'package:brn_ecommerce/models/product.dart';
import 'package:flutter/foundation.dart';

class ProductsBestSelling extends ChangeNotifier {
  final List<Product> allProducts;
  final int salesThreshold; // Sales margin for upgrade

  ProductsBestSelling({
    required this.allProducts,
    this.salesThreshold = 10,
  });

  List<Product> getBestSellingProducts(int count) {
    final sortedProducts = allProducts.toList()
      ..sort((a, b) => b.totalSellers.compareTo(a.totalSellers));

    return sortedProducts.take(count).toList();
  }

  // Call this method to check and update top selling products
  void updateBestSellingProductsIfNeeded() {
    final updatedProducts = getBestSellingProducts(allProducts.length);

    if (!_areListsEqual(updatedProducts, bestSellingProducts)) {
      _bestSellingProducts = updatedProducts;
      notifyListeners();
    }
  }

  // Helper method to check whether two product lists are equal
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

  List<Product> _bestSellingProducts = [];

  List<Product> get bestSellingProducts => _bestSellingProducts;
}
