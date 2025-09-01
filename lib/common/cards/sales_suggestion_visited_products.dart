import 'dart:async';

import 'package:brn_ecommerce/common/functions/common_functions.dart' show textForGoogleDecorations;
import 'package:brn_ecommerce/common/images/root_assets.dart';
import 'package:brn_ecommerce/helpers/routes_navigator.dart';
import 'package:brn_ecommerce/models/products/categories/product_category_manager.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SalesSuggestionVisitedProducts extends StatefulWidget {
  const SalesSuggestionVisitedProducts({super.key});

  @override
  State<SalesSuggestionVisitedProducts> createState() => _SalesSuggestionVisitedProductsState();
}

class _SalesSuggestionVisitedProductsState extends State<SalesSuggestionVisitedProducts> {
  late ScrollController scrollController;
  Timer? autoScrollTimer;

  final double itemWidth = 150.0;
  final double itemSpacing = 16.0;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductCategoryManager>().loadSuggestionsBasedOnVisitGalleryProducts(context);
    });

    // Auto scroll a cada 3s
    autoScrollTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!mounted || !scrollController.hasClients) return;
      final maxScroll = scrollController.position.maxScrollExtent;
      double nextScroll = scrollController.offset + itemWidth + itemSpacing;

      if (nextScroll > maxScroll) {
        nextScroll = 0; // volta pro início
      }

      scrollController.animateTo(
        nextScroll,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    autoScrollTimer?.cancel();
    scrollController.dispose();
    super.dispose();
  }

  void scrollLeft() {
    if (!scrollController.hasClients) return;
    double newPos = (scrollController.offset - itemWidth - itemSpacing)
        .clamp(0.0, scrollController.position.maxScrollExtent);
    scrollController.animateTo(
      newPos,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void scrollRight() {
    if (!scrollController.hasClients) return;
    double newPos = (scrollController.offset + itemWidth + itemSpacing)
        .clamp(0.0, scrollController.position.maxScrollExtent);
    scrollController.animateTo(
      newPos,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final suggestionProducts = context.watch<ProductCategoryManager>().suggestionProducts;

    return Container(
      width: double.infinity,
      color: Colors.white.withAlpha(792),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textForGoogleDecorations(
            titleForDecorations: 'Você também pode gostar',
            fontSize: 18,
          ),
          SizedBox(
            height: 180,
            child: Stack(
              children: [
                ListView.separated(
                  controller: scrollController,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  itemCount: suggestionProducts.length,
                  separatorBuilder: (_, __) => SizedBox(width: itemSpacing),
                  itemBuilder: (context, index) {
                    final product = suggestionProducts[index];
                    return SizedBox(
                      width: itemWidth,
                      child: Card(
                        elevation: 2,
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: (product.images == null || product.images!.isEmpty)
                                  ? Image.asset(
                                      RootAssets.noImagePng,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      product.images!.first,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            Positioned(
                              bottom: 5,
                              left: 5,
                              right: 5,
                              child: textForGoogleDecorations(
                                titleForDecorations: product.name ?? 'Nome do Produto',
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Positioned.fill(
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      RoutesNavigator.productDetailsScreen,
                                      arguments: product,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                // Botões laterais apenas no Web
                if (kIsWeb)
                  Positioned.fill(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios),
                          color: Colors.black54,
                          onPressed: scrollLeft,
                        ),
                        IconButton(
                          icon: const Icon(Icons.arrow_forward_ios),
                          color: Colors.black54,
                          onPressed: scrollRight,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
