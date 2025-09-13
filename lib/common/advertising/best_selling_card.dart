import 'package:brn_ecommerce/common/advertising/components/products_best_selling.dart';
import 'package:brn_ecommerce/common/functions/common_functions.dart';
import 'package:brn_ecommerce/helpers/breakpoints.dart';
import 'package:brn_ecommerce/helpers/routes_navigator.dart';
import 'package:brn_ecommerce/views/home/components/item_tile.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Card to display Best Sellers
class BestSellingCard extends StatefulWidget {
  const BestSellingCard({super.key});

  @override
  State<BestSellingCard> createState() => _BestSellingCardState();
}

class _BestSellingCardState extends State<BestSellingCard> {
  final ScrollController _scrollController = ScrollController();

  void _scrollLeft() {
    _scrollController.animateTo(
      _scrollController.offset - 200,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void _scrollRight() {
    _scrollController.animateTo(
      _scrollController.offset + 200,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final productAmountSelling = context.read<ProductsBestSelling>();
    final bestSellingProducts = productAmountSelling.getBestSellingProducts(15);

    if (bestSellingProducts.isEmpty) return const SizedBox.shrink();

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: tabletBreakpoint,
        ),
        child: Card(
          color: Colors.amber[200],
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 4,
          shadowColor: Colors.amber[700]?.withAlpha((0.6 * 255).toInt()), // 🔥 darker shade
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textForGoogleDecorations(titleForDecorations: 'Mais Vendidos'),
                const SizedBox(height: 12),
                SizedBox(
                  height: 200,
                  child: Stack(
                    children: [
                      ListView.separated(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        itemCount: bestSellingProducts.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 3),
                        itemBuilder: (_, index) {
                          final product = bestSellingProducts[index];
                          return _HoverableProductCard(product: product);
                        },
                      ),

                      // Arrows only on the Web
                      if (kIsWeb) ...[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back_ios_new),
                            color: Colors.amber.shade800,
                            onPressed: _scrollLeft,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_forward_ios),
                            color: Colors.amber.shade800,
                            onPressed: _scrollRight,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Product card that increases elevation on hover (Web) without affecting neighbors
class _HoverableProductCard extends StatefulWidget {
  final dynamic product;

  const _HoverableProductCard({required this.product});

  @override
  State<_HoverableProductCard> createState() => _HoverableProductCardState();
}

class _HoverableProductCardState extends State<_HoverableProductCard> {
  bool _hovering = false;

  static const double width = 140;
  static const double height = 180;
  static const double hoverScale = 1.7; //  grows 70%

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutBack,
        width: width * (_hovering ? hoverScale : 1),
        height: height * (_hovering ? hoverScale : 1),
        margin: const EdgeInsets.symmetric(horizontal: 1),
        child: Card(
          elevation: _hovering ? 12 : 4,
          color: Colors.amber[100],
          shadowColor: Colors.amber[400]?.withAlpha((0.6 * 255).toInt()),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          clipBehavior: Clip.antiAlias,
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                RoutesNavigator.productDetailsScreen,
                arguments: widget.product,
              );
            },
            child: ItemTile(product: widget.product), // image remains normal
          ),
        ),
      ),
    );
  }
}
