import 'package:brn_ecommerce/common/advertising/components/purchase_model.dart';
import 'package:brn_ecommerce/common/formatted_fields/format_values.dart';
import 'package:brn_ecommerce/common/functions/common_functions.dart';
import 'package:brn_ecommerce/helpers/breakpoints.dart';
import 'package:brn_ecommerce/helpers/routes_navigator.dart';
import 'package:brn_ecommerce/models/products/product.dart';
import 'package:brn_ecommerce/models/products/product_manager.dart';
import 'package:brn_ecommerce/models/users/users_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PurchaseSuggestionsWidget extends StatefulWidget {
  const PurchaseSuggestionsWidget({super.key});

  @override
  State<PurchaseSuggestionsWidget> createState() => _PurchaseSuggestionsWidgetState();
}

class _PurchaseSuggestionsWidgetState extends State<PurchaseSuggestionsWidget> {
  List<Product> suggestedProducts = [];
  bool loading = true;

  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _loadSuggestions();
  }

  Future<void> _loadSuggestions() async {
    final allProducts = context.read<ProductManager>().allProducts;
    final userId = context.read<UserManager>().users?.id;

    if (userId == null) {
      setState(() => loading = false);
      return;
    }

    final recs = await PurchaseModel.getPurchaseSuggestions(
      userId: userId,
      allProducts: allProducts,
      suggestionCount: 24, // maximum PRODUCTS 24
    );

    if (mounted) {
      setState(() {
        suggestedProducts = recs;
        loading = false;
      });
    }
  }

  List<Product> getCurrentPageProducts(int perPage) {
    final start = currentPage * perPage;
    final end =
        (start + perPage) > suggestedProducts.length ? suggestedProducts.length : start + perPage;
    return suggestedProducts.sublist(start, end);
  }

  void nextPage(int perPage) {
    if ((currentPage + 1) * perPage < suggestedProducts.length) {
      setState(() => currentPage++);
    }
  }

  void previousPage() {
    if (currentPage > 0) {
      setState(() => currentPage--);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) return const Center(child: CircularProgressIndicator());
    if (suggestedProducts.isEmpty) return const SizedBox.shrink();

    final screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount;
    int perPage;

    if (screenWidth <= mobileBreakpoint) {
      crossAxisCount = 2; // mobile → 2x2
      perPage = 4;
    } else if (screenWidth < staggeredBreakpoint) {
      crossAxisCount = 4; // tablet → 4x4
      perPage = 8;
    } else {
      crossAxisCount = 6; // desktop → 6x6
      perPage = 12;
    }

    // Calculate total pages
    final totalPages = ((suggestedProducts.length - 1) ~/ perPage) + 1;

    // Ensure currentPage is within range to prevent RangeError
    if (currentPage >= totalPages) currentPage = totalPages - 1;
    if (currentPage < 0) currentPage = 0;

    final currentProducts = getCurrentPageProducts(perPage);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        textForGoogleDecorations(
            titleForDecorations: 'Quem comprou este produto, também levaram estes...',
            fontSize: 18,
            fontWeight: FontWeight.normal),
        const SizedBox(height: 12),

        // Page navigation (whenever there is more than one page)
        if (suggestedProducts.length > perPage)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: previousPage,
              ),
              Text("${currentPage + 1} / $totalPages"),
              IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () => nextPage(perPage),
              ),
            ],
          ),

        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            childAspectRatio: 400 / 440,
          ),
          itemCount: currentProducts.length,
          itemBuilder: (context, index) {
            final product = currentProducts[index];
            return ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 80, // max card height
              ),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RoutesNavigator.productDetailsScreen,
                      arguments: product,
                    );
                  },
                  child: Stack(
                    children: [
                      // Background image
                      Positioned.fill(
                        child: Image.network(
                          product.images?.first ?? "",
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              const Icon(Icons.image_not_supported, size: 40),
                        ),
                      ),

                      // Subtle gradient to improve contrast
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.center,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.6),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Information at the bottom
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                product.name ?? "Sem nome",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 2,
                                      color: Colors.black,
                                      offset: Offset(0.5, 0.5),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'A partir: ${formattedRealText(product.basePrice)}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.greenAccent,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 2,
                                      color: Colors.black,
                                      offset: Offset(0.5, 0.5),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
