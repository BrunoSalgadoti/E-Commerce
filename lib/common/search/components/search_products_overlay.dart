import 'package:brn_ecommerce/common/cards/flexible_product_card.dart';
import 'package:brn_ecommerce/common/miscellaneous/empty_page_indicator.dart';
import 'package:brn_ecommerce/helpers/breakpoints.dart';
import 'package:brn_ecommerce/helpers/routes_navigator.dart';
import 'package:brn_ecommerce/models/products/product.dart';
import 'package:flutter/material.dart';

OverlayEntry? _currentOverlayEntry; // global overlay reference

void searchProductsOverlay({
  required BuildContext context,
  required List<Product> products,
  required String query,
  required VoidCallback clearSearch, // clears the search field
}) {
  // Remove previous overlay if exists
  _currentOverlayEntry?.remove();
  _currentOverlayEntry = null;

  final filteredProducts =
      products.where((p) => p.name!.toLowerCase().contains(query.toLowerCase())).toList();

  final overlay = Overlay.of(context);
  late OverlayEntry overlayEntry;

  void closeOverlay(VoidCallback? clearSearch, OverlayEntry overlayEntry) {
    overlayEntry.remove(); // closes overlay
    clearSearch?.call(); // clean field
    _currentOverlayEntry = null;
  }

  overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: 100,
      left: 20,
      right: 20,
      child: Material(
        color: Colors.transparent,
        child: Center(
          child: Stack(
            children: [
              Container(
                constraints: const BoxConstraints(maxHeight: 600, maxWidth: tabletBreakpoint),
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(90),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black26)],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: filteredProducts.isEmpty
                      ? const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: EmptyPageIndicator(
                              title: 'Nenhum produto encontrado...',
                              iconData: Icons.search_off,
                              image: null,
                            ),
                          ),
                        )
                      : GridView.builder(
                          padding: const EdgeInsets.all(8),
                          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 260,
                            mainAxisExtent: 318,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: filteredProducts.length,
                          itemBuilder: (_, index) {
                            final product = filteredProducts[index];
                            return FlexibleProductCard(
                              product: product,
                              isVertical: true,
                              onTap: () {
                                closeOverlay(clearSearch, overlayEntry);
                                Navigator.pushNamed(
                                  context,
                                  RoutesNavigator.productDetailsScreen,
                                  arguments: product,
                                );
                              },
                            );
                          },
                        ),
                ),
              ),

              // X button in the upper right corner
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () {
                    closeOverlay(clearSearch, overlayEntry);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(6),
                    child: const Icon(Icons.close, size: 25, color: Colors.black87),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);
  _currentOverlayEntry = overlayEntry; // updates global reference
}
