import 'package:brn_ecommerce/common/search/components/search_products_overlay.dart'
    show searchProductsOverlay;
import 'package:brn_ecommerce/models/products/product_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void showSearchOverlay(BuildContext context, String query, VoidCallback clearSearch) {
  final productManager = Provider.of<ProductManager>(context, listen: false);
  searchProductsOverlay(
    context: context,
    products: productManager.allProducts,
    query: query,
    clearSearch: () {
      productManager.search = '';
      clearSearch();
    },
  );
}
