import 'package:brn_ecommerce/common/cards/components/recently_added_products_animeted.dart';
import 'package:brn_ecommerce/common/functions/common_functions.dart';
import 'package:brn_ecommerce/helpers/breakpoints.dart';
import 'package:brn_ecommerce/models/products/categories/product_category.dart';
import 'package:brn_ecommerce/models/products/components/products_recently_added.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Then we declare the main class
class RecentlyAddedProducts extends StatelessWidget {
  final bool carrossel;
  final ProductCategory? productCategory;

  const RecentlyAddedProducts({
    super.key,
    required this.carrossel,
    this.productCategory,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductsRecentlyAdded>(
      builder: (_, productsRecentlyAdded, __) {
        final recentProducts = productsRecentlyAdded.getRecentProducts(
          productCategory: productCategory,
        );

        if (recentProducts.isEmpty) return const SizedBox.shrink();

        if (carrossel) {
          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: tabletBreakpoint),
              child: SizedBox(
                height: 150,
                child: carouselForProducts(
                  context: context,
                  productsForCarousel: recentProducts,
                ),
              ),
            ),
          );
        } else {
          return ConstrainedBox(
            constraints: BoxConstraints(maxWidth: mobileBreakpoint),
            child: RecentlyAddedProductsAnimated(products: recentProducts),
          );
        }
      },
    );
  }
}
