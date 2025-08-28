// First we declare the animated version
import 'dart:async';

import 'package:brn_ecommerce/helpers/breakpoints.dart';
import 'package:brn_ecommerce/models/products/product.dart';
import 'package:flutter/material.dart';

class RecentlyAddedProductsAnimated extends StatefulWidget {
  final List<Product> products;

  const RecentlyAddedProductsAnimated({super.key, required this.products});

  @override
  State<RecentlyAddedProductsAnimated> createState() => _RecentlyAddedProductsAnimatedState();
}

class _RecentlyAddedProductsAnimatedState extends State<RecentlyAddedProductsAnimated> {
  late PageController _pageController;
  int _currentPage = 0;
  bool _fadeIn = false;
  Timer? _timer;
  Timer? _fadeTimer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() => _fadeIn = true);
    });

    _timer = Timer.periodic(
      const Duration(seconds: 5),
      (_) {
        if (_currentPage < _numPages(context) - 1) {
          _currentPage++;
        } else {
          _currentPage = 0;
        }

        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(seconds: 4),
          curve: Curves.easeInOut,
        );

        setState(() => _fadeIn = false);

        // cancels any previous fade timer
        _fadeTimer?.cancel();
        _fadeTimer = Timer(
          const Duration(seconds: 2),
          () {
            if (mounted) setState(() => _fadeIn = true);
          },
        );
      },
    );
  }

  int _itemsPerPage(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth >= 870
        ? 3
        : screenWidth <= mobileBreakpoint
            ? 3
            : 2;
  }

  int _numPages(BuildContext context) => (widget.products.length / _itemsPerPage(context)).ceil();

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    _fadeTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: mobileBreakpoint),
        child: SizedBox(
          height: 150,
          width: double.infinity,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _numPages(context),
            itemBuilder: (context, pageIndex) {
              final startIndex = pageIndex * _itemsPerPage(context);
              final endIndex =
                  (startIndex + _itemsPerPage(context)).clamp(0, widget.products.length);
              final pageProducts = widget.products.sublist(startIndex, endIndex);

              return AnimatedOpacity(
                opacity: _fadeIn ? 1.0 : 0.0,
                duration: const Duration(seconds: 2),
                child: FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: pageProducts.map((product) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            '/productDetailsScreen',
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
