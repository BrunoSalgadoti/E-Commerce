import 'package:brn_ecommerce/common/cards/flexible_product_card.dart';
import 'package:brn_ecommerce/common/drawer/custom_drawer.dart';
import 'package:brn_ecommerce/common/miscellaneous/empty_page_indicator.dart';
import 'package:brn_ecommerce/common/search/search_products.dart';
import 'package:brn_ecommerce/common/sliding_up_panel/components/controller.dart';
import 'package:brn_ecommerce/common/sliding_up_panel/components/filters_result.dart';
import 'package:brn_ecommerce/common/sliding_up_panel/components/sliding_filters_products.dart';
import 'package:brn_ecommerce/common/sliding_up_panel/custom_sliding_up_painel.dart';
import 'package:brn_ecommerce/helpers/breakpoints.dart';
import 'package:brn_ecommerce/helpers/routes_navigator.dart';
import 'package:brn_ecommerce/models/products/product_manager.dart';
import 'package:brn_ecommerce/models/users/users_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final Set<StatusOfProducts> selectedStatus = <StatusOfProducts>{};

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      final productManager = Provider.of<ProductManager>(context, listen: false);
      productManager.disableFilter();
      ControlsSlidingPanel.panelController.close();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: searchProducts(context: context),
      body: Consumer<ProductManager>(builder: (_, productManager, __) {
        final filteredProducts = productManager.filteredProducts;
        return Align(
          alignment: Alignment.center,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: tabletBreakpoint),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                customSlidingUpPainel(
                  slidingTitleColor: primaryColor,
                  textOfSlidingUpPanel: null,
                  context: context,
                  childrenOfPainel: SlidingFiltersProducts(
                    selectedStatus: selectedStatus,
                  ),
                  body: null,
                ),
                if (productManager.filtersOn == true) filtersResult(),
                Expanded(
                  child: Stack(
                    children: [
                      if (filteredProducts.isEmpty)
                        productManager.filtersOn == true || productManager.search.isNotEmpty
                            ? const EmptyPageIndicator(
                                title: 'Pesquisa não encontrada...',
                                iconData: Icons.search_off,
                                image: null,
                                duration: null,
                              )
                            : const EmptyPageIndicator(
                                title: "Carregando Produtos...",
                                image: "assets/images/await.gif",
                                iconData: null,
                              )
                      else
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 30, 15, 40),
                          child: GridView.builder(
                            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 260,
                              mainAxisExtent: 318,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: filteredProducts.length,
                            itemBuilder: (_, index) {
                              return FlexibleProductCard(
                                product: productManager.filtersOn == true
                                    ? filteredProducts.toList()[index]
                                    : filteredProducts.reversed.toList()[index],
                                isVertical: true,
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
      floatingActionButton: Consumer<UserManager>(builder: (_, userManager, __) {
        return FloatingActionButton(
          backgroundColor: Colors.white,
          foregroundColor: Theme.of(context).primaryColor,
          onPressed: () {
            if (userManager.isLoggedIn) {
              Navigator.pushNamed(context, RoutesNavigator.cartScreen);
            } else {
              Navigator.pushNamed(context, RoutesNavigator.loginScreen);
            }
          },
          child: userManager.isLoggedIn
              ? const Icon(Icons.shopping_cart)
              : const Icon(Icons.account_circle),
        );
      }),
    );
  }

  @override
  void dispose() {
    Future.delayed(Duration.zero, () {
      if (mounted) {
        final productManager = Provider.of<ProductManager>(context, listen: false);
        productManager.disableFilter();
        ControlsSlidingPanel.panelController.close();
      }
    });
    super.dispose();
  }
}
