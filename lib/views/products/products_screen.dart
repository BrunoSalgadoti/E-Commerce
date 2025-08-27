import 'package:brn_ecommerce/common/app_bar/custom_app_bar.dart';
import 'package:brn_ecommerce/common/buttons/custom_icon_button.dart';
import 'package:brn_ecommerce/common/cards/flexible_product_card.dart';
import 'package:brn_ecommerce/common/drawer/custom_drawer.dart';
import 'package:brn_ecommerce/common/images/root_assets.dart';
import 'package:brn_ecommerce/common/miscellaneous/empty_page_indicator.dart';
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
      appBar: CustomAppBar(
        showSearchButton: true,
        title: 'Todos os Produtos',
        showDrawerIcon: true,
        actions: [
          Consumer<UserManager>(
            builder: (_, userManager, __) {
              if (userManager.adminEnable) {
                return CustomIconButton(
                  iconData: Icons.add,
                  size: 30,
                  semanticLabel: '',
                  onTap: () => Navigator.pushNamed(context, RoutesNavigator.editProductScreen),
                );
              } else {
                return Container();
              }
            },
          )
        ],
      ),
      body: Stack(
        children: [
          Consumer<ProductManager>(builder: (_, productManager, __) {
            final filteredProducts = productManager.filteredProducts;
            return Align(
              alignment: Alignment.center,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: tabletBreakpoint),
                child: Column(
                  children: [
                    if (productManager.filtersOn == true)
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Center(child: filtersResult()),
                      ),
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
                                    image: RootAssets.cartAwaitGif,
                                    iconData: null,
                                  )
                          else
                            Padding(
                              padding: productManager.filtersOn == true
                                  ? const EdgeInsets.fromLTRB(15, 5, 15, 30)
                                  : const EdgeInsets.fromLTRB(15, 45, 15, 30),
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
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: mobileBreakpoint),
                child: customSlidingUpPainel(
                  slidingTitleColor: primaryColor,
                  textOfSlidingUpPanel: null,
                  context: context,
                  childrenOfPainel: SlidingFiltersProducts(
                    selectedStatus: selectedStatus,
                  ),
                  body: null,
                ),
              ),
            ),
          ),
        ],
      ),
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
