import 'dart:async';
import 'package:brn_ecommerce/common/cards/components/animated_highlight_title.dart' show AnimatedHighlightTitle;
import 'package:flutter/material.dart';

class HighlightProductCard extends StatefulWidget {
  final List<String> images;
  final String name;
  final double price;
  final VoidCallback? onTap;

  const HighlightProductCard({
    super.key,
    required this.images,
    required this.name,
    required this.price,
    this.onTap,
  });

  @override
  State<HighlightProductCard> createState() => _HighlightProductCardState();
}

class _HighlightProductCardState extends State<HighlightProductCard> {
  late PageController _pageController;
  late Timer _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    _pageController = PageController();
    if (widget.images.length > 1) {
      _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
        if (_currentPage < widget.images.length - 1 && _currentPage < 2) {
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
    if (widget.images.length > 1) {
      _timer.cancel();
    }
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
                  widget.name,
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
                borderRadius:
                const BorderRadius.vertical(bottom: Radius.circular(12)),
                child: SizedBox(
                  height: 160 * 1.07,
                  width: double.infinity,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount:
                    widget.images.length > 3 ? 3 : widget.images.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Image.network(
                        widget.images[index],
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
                  'R\$ ${widget.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Colors.orange,
                    fontSize: 14,
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
