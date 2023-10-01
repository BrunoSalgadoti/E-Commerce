import 'dart:io';

import 'package:brn_ecommerce/models/categories_of_products/product_category.dart';
import 'package:brn_ecommerce/models/product.dart';
import 'package:brn_ecommerce/models/product_manager.dart';
import 'package:flutter/material.dart';

class UtilsForCategory {
  UtilsForCategory(this.productManager, this.productCategory);

  final ProductManager productManager;
  final ProductCategory productCategory;

  // Function to load recent products
  List<Product> loadRecentProducts() {
    List<Product> sortedProducts = productManager.allProducts
        .where((p) =>
            p.isValid! &&
            p.hasStock &&
            p.categoryOfProduct == productCategory.categoryID)
        .take(10)
        .toList();

    sortedProducts
        .sort((a, b) => b.insertionDate!.compareTo(a.insertionDate!));

    return sortedProducts;
  }

  // Load all products from the specific category
  List<Product> loadCategoryProducts() {
    List<Product> allCategoryProducts = productManager.allProducts
        .where((p) =>
            p.isValid! &&
            p.hasStock &&
            p.categoryOfProduct == productCategory.categoryID)
        .toList();

    return allCategoryProducts;
  }

  // Build and verify category main image based on type
  Widget buildCategoryImage(bool isSmallScreen, bool isMediumScreen) {
    if (productCategory.categoryImg != null &&
        productCategory.categoryImg != "") {
      if (productCategory.categoryImg is File) {
        return Image.file(
          productCategory.categoryImg as File,
          width: double.infinity,
          height: isSmallScreen
              ? 250
              : isMediumScreen
                  ? 260
                  : 350,
          fit: BoxFit.fill,
        );
      } else {
        return Image.network(
          productCategory.categoryImg!,
          width: double.infinity,
          height: isSmallScreen
              ? 250
              : isMediumScreen
                  ? 260
                  : 350,
          fit: BoxFit.fill,
        );
      }
    } else {
      return Image.asset(
        'assets/images/CategoriesBackground.jpg',
        width: double.infinity,
        height: isSmallScreen
            ? 250
            : isMediumScreen
                ? 260
                : 350,
        fit: BoxFit.fill,
      );
    }
  }
}
