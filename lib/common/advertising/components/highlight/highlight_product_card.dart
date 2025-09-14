import 'dart:async';

import 'package:brn_ecommerce/common/advertising/components/highlight/animated_highlight_title.dart';
import 'package:brn_ecommerce/common/formatted_fields/format_values.dart';
import 'package:brn_ecommerce/models/products/product.dart';
import 'package:flutter/material.dart';

class HighlightProductCard extends StatefulWidget {
  final Product? product;
  final List<String>? images;
  final String? name;
  final double? price;
  final VoidCallback onTap;

  const HighlightProductCard({
    super.key,
    this.product,
    this.images,
    this.name,
    this.price,
    required this.onTap,
  });

  @override
  State<HighlightProductCard> createState() => _HighlightProductCardState();
}

class _HighlightProductCardState extends State<HighlightProductCard> {
  late PageController _pageController;
  Timer? _timer;
  int _currentPage = 0;

  List<String> get _images {
    if (widget.product != null) return widget.product!.images ?? [];
    return widget.images ?? [];
  }

  String get _name {
    if (widget.product != null) return widget.product!.name ?? "";
    return widget.name ?? "";
  }

  String get _priceText {
    if (widget.product != null) {
      return 'A partir: ${formattedRealText(widget.product!.basePrice)}';
    }
    if (widget.price != null) {
      return 'R\$ ${widget.price!.toStringAsFixed(2)}';
    }
    return '';
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    if (_images.length > 1) {
      _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
        if (_currentPage < (_images.length > 3 ? 2 : _images.length - 1)) {
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
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 180,
        maxWidth: 200,
        minHeight: 250,
        maxHeight: 294,
      ),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Card(
          color: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Animated Title
              const AnimatedHighlightTitle(),

              // Product name
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              // Product images carousel
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(12),
                ),
                child: SizedBox(
                  height: 160 * 1.07,
                  width: double.infinity,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _images.length > 3 ? 3 : _images.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Image.network(
                        _images[index],
                        fit: BoxFit.fitHeight,
                      );
                    },
                  ),
                ),
              ),

              // Price
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    _priceText,
                    style: const TextStyle(
                      color: Colors.redAccent,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
