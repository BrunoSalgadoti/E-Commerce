import 'package:auto_size_text/auto_size_text.dart';
import 'package:brn_ecommerce/common/buttons/custom_text_button.dart';
import 'package:brn_ecommerce/common/functions/common_functions.dart' show navigateToPageWithDrawer;
import 'package:brn_ecommerce/common/images/root_assets.dart';
import 'package:brn_ecommerce/helpers/routes_navigator.dart';
import 'package:brn_ecommerce/models/products/categories/product_category_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SalesSuggestionWidget extends StatefulWidget {
  const SalesSuggestionWidget({super.key});

  @override
  State<SalesSuggestionWidget> createState() => _SalesSuggestionWidgetState();
}

class _SalesSuggestionWidgetState extends State<SalesSuggestionWidget> {
  final int itemsPerPage = 10;
  int currentPage = 0;
  PageController pageControllerSuggest = PageController();

  @override
  void initState() {
    pageControllerSuggest = PageController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductCategoryManager>().loadSuggestions(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final suggestionProducts = context.watch<ProductCategoryManager>().suggestionProducts;
    final totalItems = suggestionProducts.length;
    final totalPages = (totalItems / itemsPerPage).ceil();

    return Container(
      width: double.infinity,
      color: Colors.white.withAlpha(792),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Text(
            'Continue comprando...',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
            overflow: TextOverflow.fade,
          ),
          Container(
            width: double.infinity,
            height: 200,
            color: const Color.fromRGBO(200, 200, 200, 40),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: PageView.builder(
                controller: pageControllerSuggest,
                padEnds: false,
                restorationId: 'vcp',
                itemCount: totalPages,
                onPageChanged: (page) {
                  setState(() {
                    currentPage = page;
                  });
                },
                itemBuilder: (context, pageIndex) {
                  final startIndex = pageIndex * itemsPerPage;
                  final endIndex = (startIndex + itemsPerPage).clamp(0, totalItems);
                  final pageItems = suggestionProducts.sublist(startIndex, endIndex);

                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: pageItems.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 0.2),
                    itemBuilder: (context, index) {
                      final product = pageItems[index];

                      return TweenAnimationBuilder<double>(
                          tween: Tween(begin: 50, end: 0), // deslocamento inicial (px)
                          duration: const Duration(seconds: 3),
                          curve: Curves.easeOutCubic,
                          builder: (context, value, child) {
                            return Opacity(
                              opacity: (50 - value) / 50, // fade-in proporcional
                              child: Transform.translate(
                                offset: Offset(value, 0), // move da direita para a posição final
                                child: child,
                              ),
                            );
                          },
                          child: Card(
                            elevation: 2,
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: SizedBox(
                              width: 150,
                              height: double.infinity,
                              child: Stack(
                                children: [
                                  InkWell(
                                    child: (product.images == null || product.images!.isEmpty)
                                        ? Image.asset(RootAssets.noImagePng)
                                        : Image.network(product.images!.first),
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, RoutesNavigator.productDetailsScreen,
                                          arguments: product);
                                    },
                                  ),
                                  Positioned(
                                    bottom: 5,
                                    left: 5,
                                    child: Text(
                                      product.name ?? 'Nome do Produto',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ));
                    },
                  );
                },
              ),
            ),
          ),
          AutoSizeText(
            'Seu pedido foi realizado, agradecemos a preferência, acompanhe o status do seu pedidos em:\n',
            maxFontSize: 25,
            minFontSize: 12,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
            overflow: TextOverflow.fade,
          ),
          CustomTextButton(
              text: 'Meus Pedidos',
              fontColor: Colors.lightGreen,
              fontWeight: FontWeight.w900,
              fontSize: 20,
              onPressed: () => navigateToPageWithDrawer(context, 3)) // Página de Minhas Compras
        ],
      ),
    );
  }

  @override
  void dispose() {
    pageControllerSuggest.dispose();
    super.dispose();
  }
}
