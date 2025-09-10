import 'dart:async';
import 'package:brn_ecommerce/helpers/breakpoints.dart';
import 'package:brn_ecommerce/models/products/product.dart';
import 'package:flutter/material.dart';
import 'animated_highlight_title.dart';

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
          height: 300,
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
                  return ConstrainedBox(
                    constraints: const BoxConstraints(
                      minWidth: 180,
                      maxWidth: 200,
                      minHeight: 250,
                      maxHeight: 294,
                    ),
                    child: _HighlightProductCardAnimated(product: product),
                  );
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

class _HighlightProductCardAnimated extends StatefulWidget {
  final Product product;

  const _HighlightProductCardAnimated({required this.product});

  @override
  State<_HighlightProductCardAnimated> createState() =>
      _HighlightProductCardAnimatedState();
}

class _HighlightProductCardAnimatedState
    extends State<_HighlightProductCardAnimated> {
  late PageController _pageController;
  late Timer _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    if (widget.product.images != null && widget.product.images!.length > 1) {
      _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
        if (_currentPage <
            (widget.product.images!.length > 3
                ? 2
                : widget.product.images!.length - 1)) {
          _currentPage++;
        } else {
          _currentPage = 0;
        }
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  @override
  void dispose() {
    if (widget.product.images != null && widget.product.images!.length > 1) {
      _timer.cancel();
    }
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Animated Title
          const AnimatedHighlightTitle(),

          // Product name
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.product.name ?? "",
              style:
              const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // Image carousel
          ClipRRect(
            borderRadius:
            const BorderRadius.vertical(bottom: Radius.circular(12)),
            child: SizedBox(
              height: 140 * 1.07,
              width: double.infinity,
              child: PageView.builder(
                controller: _pageController,
                itemCount: widget.product.images!.length > 3
                    ? 3
                    : widget.product.images!.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Image.network(
                    widget.product.images![index],
                    fit: BoxFit.fitHeight,
                  );
                },
              ),
            ),
          ),

          // Price
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'R\$ ${widget.product.basePrice.toStringAsFixed(2)}',
              style: const TextStyle(color: Colors.orange, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
