import 'dart:io';

import 'package:brn_ecommerce/common/images/root_assets.dart';
import 'package:brn_ecommerce/models/products/categories/product_category.dart';
import 'package:brn_ecommerce/models/products/product.dart';
import 'package:brn_ecommerce/models/products/product_manager.dart';
import 'package:flutter/material.dart';

class UtilsForCategory {
  UtilsForCategory(this.productManager, this.productCategory);

  final ProductManager productManager;
  final ProductCategory productCategory;

  // Load all products from the specific category
  List<Product> loadCategoryProducts() {
    List<Product> allCategoryProducts = productManager.filteredProducts
    //TODO: Implementar uma função categoryHasProduct
        .where((p) => p.categoryOfProduct == productCategory.categoryID)
        .toList();

    return allCategoryProducts;
  }

  // Build and verify category main image based on type
  Widget buildCategoryImage() {
    if (productCategory.categoryImg != null && productCategory.categoryImg != "") {
      if (productCategory.categoryImg is File) {
        return Image.file(
          productCategory.categoryImg as File,
          width: double.infinity,
          height: 270,
          fit: BoxFit.cover,
        );
      } else {
        return Image.network(
          productCategory.categoryImg!,
          width: double.infinity,
          height: 270,
          fit: BoxFit.cover,
        );
      }
    } else {
      return Image.asset(
        RootAssets.imageForEmptyBackgroundsJpg,
        width: double.infinity,
        height: 270,
        fit: BoxFit.cover,
      );
    }
  }
}
