import 'package:brn_ecommerce/common/search/components/show_search_overlay.dart'
    show showSearchOverlay;
import 'package:brn_ecommerce/helpers/breakpoints.dart';
import 'package:brn_ecommerce/models/products/product_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Provider;

class SearchProductsField extends StatelessWidget {
  const SearchProductsField({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 2,
      child: SearchBox(
        hintText: "Buscar produtos...",
        onSearch: (query) => showSearchOverlay(context, query, () {
          final productManager = Provider.of<ProductManager>(context, listen: false);
          productManager.search = '';
        }),
      ),
    );
  }
}

// ---------------------------------------------------
// SearchBox Genérico para ComplementHomeAppBar
// ---------------------------------------------------

class SearchBox extends StatelessWidget {
  final String hintText;
  final String? initialText;
  final ValueChanged<String>? onSearch;

  const SearchBox({
    super.key,
    this.hintText = "Pesquise...",
    this.initialText,
    this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width > tabletBreakpoint;

    return SizedBox(
      height: isTablet ? 50 : 45,
      child: TextField(
        controller: TextEditingController(text: initialText),
        onSubmitted: onSearch,
        style: TextStyle(fontSize: kIsWeb ? 18 : 15, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
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
