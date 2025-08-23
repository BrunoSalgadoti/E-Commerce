import 'dart:async';
import 'package:brn_ecommerce/common/functions/common_functions.dart';
import 'package:brn_ecommerce/helpers/breakpoints.dart';
import 'package:brn_ecommerce/helpers/routes_navigator.dart';
import 'package:brn_ecommerce/models/products/categories/product_category.dart';
import 'package:brn_ecommerce/models/products/product.dart';
import 'package:brn_ecommerce/models/products/products_recently_added.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// ## RecentlyAddedProducts
/// Widget to display recent products with two options:
/// - Carousel (`carousel: true`) using `fan_carousel_image_slider` with cards
/// - Animated horizontal page effect (`carousel: false`) showing 3 products at a time
class RecentlyAddedProducts extends StatelessWidget {
  final bool carrossel;
  final ProductCategory? productCategory;

  const RecentlyAddedProducts({
    super.key,
    required this.carrossel,
    required this.productCategory,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductsRecentlyAdded>(
      builder: (_, productsRecentlyAdded, __) {
        final recentProducts =
            productsRecentlyAdded.getRecentProducts(productCategory: productCategory);

        if (recentProducts.isEmpty) return const SizedBox.shrink();

        if (carrossel == true) {
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
          // Animated effect showing 3 products side by side
          return RecentlyAddedProductsAnimated(products: recentProducts);
        }
      },
    );
  }
}

/// Animated version of recent products on * / * pages
class RecentlyAddedProductsAnimated extends StatefulWidget {
  final List<Product> products;

  const RecentlyAddedProductsAnimated({super.key, required this.products});

  @override
  State<RecentlyAddedProductsAnimated> createState() => _RecentlyAddedProductsAnimatedState();
}

class _RecentlyAddedProductsAnimatedState extends State<RecentlyAddedProductsAnimated> {
  late final PageController _pageController;
  int _currentPage = 0;
  bool _fadeIn = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    // Starts fadeIn on first load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() => _fadeIn = true);
    });

    // Timer to advance pages automatically
    _timer = Timer.periodic(const Duration(seconds: 7), (timer) {
      if (_currentPage < _numPages - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(seconds: 2),
        curve: Curves.easeInOut,
      );

      // Reset fadeIn
      setState(() => _fadeIn = false);
      Future.delayed(const Duration(milliseconds: 50), () {
        if (mounted) setState(() => _fadeIn = true);
      });
    });
  }

  int get _numPages => (widget.products.length / 4).ceil();

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: tabletBreakpoint),
        child: SizedBox(
          height: 150,
          width: double.infinity,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _numPages,
            itemBuilder: (context, pageIndex) {
              final startIndex = pageIndex * (kIsWeb ? 3 : 4);
              final endIndex = (startIndex + (kIsWeb ? 4 : 3)).clamp(0, widget.products.length);
              final pageProducts = widget.products.sublist(startIndex, endIndex);

              return AnimatedOpacity(
                opacity: _fadeIn ? 1.0 : 0.0,
                duration: const Duration(seconds: 3),
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: pageProducts.map((product) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            RoutesNavigator.productDetailsScreen,
                            arguments: product,
                          );
                        },
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              product.images!.first,
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
