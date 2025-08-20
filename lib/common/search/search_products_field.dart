import 'package:brn_ecommerce/common/search/components/show_search_overlay.dart'
    show showSearchOverlay;
import 'package:brn_ecommerce/helpers/breakpoints.dart';
import 'package:brn_ecommerce/models/products/product_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchProductsField extends StatefulWidget {
  const SearchProductsField({super.key});

  @override
  State<SearchProductsField> createState() => _SearchProductsFieldState();
}

class _SearchProductsFieldState extends State<SearchProductsField> {
  bool _showOverlay = false;
  final TextEditingController _controller = TextEditingController();
  OverlayEntry? _overlayEntry;

  void _toggleOverlay(BuildContext context) {
    if (_showOverlay) {
      _overlayEntry?.remove();
      _overlayEntry = null;
      setState(() => _showOverlay = false);
    } else {
      _overlayEntry = _createOverlay(context);
      Overlay.of(context).insert(_overlayEntry!);
      setState(() => _showOverlay = true);
    }
  }

  OverlayEntry _createOverlay(BuildContext context) {
    final productManager = Provider.of<ProductManager>(context, listen: false);

    return OverlayEntry(
      builder: (context) => Positioned(
        top: 60, // below the AppBar
        left: 16,
        right: 16,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [BoxShadow(blurRadius: 8, color: Colors.black26)],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    autofocus: true,
                    onChanged: (query) {
                      showSearchOverlay(context, query, () {
                        productManager.search = '';
                        _controller.clear();
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: 'Buscar produtos...',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    showSearchOverlay(context, _controller.text, () {
                      productManager.search = '';
                      _controller.clear();
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    _overlayEntry?.remove();
                    _overlayEntry = null;
                    _controller.clear();
                    setState(() => _showOverlay = false);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isWeb = MediaQuery.of(context).size.width > mobileBreakpoint;

    if (isWeb) {
      // fixed web/tablet version
      return Flexible(
        fit: FlexFit.loose,
        child: SearchBox(
          controller: _controller,
          autofocus: false,
          onSearch: (query) {
            final productManager = Provider.of<ProductManager>(context, listen: false);
            showSearchOverlay(context, query, () {
              productManager.search = '';
              _controller.clear();
            });
          },
        ),
      );
    }

    // mobile version (overlay)
    return IconButton(
      icon: const Icon(Icons.search, color: Colors.grey),
      onPressed: () => _toggleOverlay(context),
    );
  }
}

// ---------------------------
// Generic web search box
// ---------------------------
class SearchBox extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final ValueChanged<String>? onSearch;
  final bool autofocus;

  const SearchBox({
    super.key,
    required this.controller,
    this.hintText = "Buscar produtos...",
    this.onSearch,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    void submit() {
      final q = controller.text.trim();
      if (q.isEmpty) return;
      onSearch?.call(q);
      controller.clear();
    }

    return SizedBox(
      height: 50,
      child: TextField(
        controller: controller,
        autofocus: autofocus,
        onSubmitted: (_) => submit(),
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          suffixIcon: SizedBox(
            width: 88,
            child: FittedBox(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    tooltip: 'Buscar',
                    icon: const Icon(Icons.search),
                    onPressed: submit,
                  ),
                  IconButton(
                    tooltip: 'Ir',
                    icon: const Icon(Icons.arrow_forward_ios),
                    onPressed: submit,
                  ),
                ],
              ),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white.withAlpha(90),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        ),
      ),
    );
  }
}
