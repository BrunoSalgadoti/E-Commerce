import 'package:brn_ecommerce/helpers/breakpoints.dart';
import 'package:brn_ecommerce/models/products/product.dart';
import 'package:flutter/material.dart';
import 'package:brn_ecommerce/common/cards/highlight_product_card.dart';

class HighlightProductsBlock extends StatefulWidget {
  final List<Product> products; // products already filtered with highlight and stock
  final bool isSilver;

  const HighlightProductsBlock({
    super.key,
    required this.products,
    this.isSilver = false,
  });

  @override
  State<HighlightProductsBlock> createState() => _HighlightProductsBlockState();
}

class _HighlightProductsBlockState extends State<HighlightProductsBlock> {
  final ScrollController _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.products.isEmpty) return const SizedBox.shrink();

    return LayoutBuilder(
      builder: (context, constraints) {
        double spacing = constraints.maxWidth < mobileBreakpoint
            ? 10
            : constraints.maxWidth < staggeredBreakpoint
            ? 20
            : constraints.maxWidth < tabletBreakpoint
            ? 24
            : 30;

        int visibleCards = (constraints.maxWidth / 180).floor();
        double cardWidth =
            (constraints.maxWidth - spacing * (visibleCards + 1)) / visibleCards;

        return SizedBox(
          height: 320,
          child: Stack(
            children: [
              ListView.separated(
                controller: _controller,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: spacing),
                itemCount: widget.products.length,
                separatorBuilder: (_, __) => SizedBox(width: spacing),
                itemBuilder: (context, index) {
                  final product = widget.products[index];
                  return HighlightProductCard(product: product);
                },
              ),

              // Web back arrow
              if (constraints.maxWidth >= 300)
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      _controller.animateTo(
                        _controller.offset - cardWidth - spacing,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                ),

              // Web forward arrow
              if (constraints.maxWidth >= 300)
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_forward_ios),
                    onPressed: () {
                      _controller.animateTo(
                        _controller.offset + cardWidth + spacing,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
