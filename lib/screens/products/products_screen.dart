import 'package:brn_ecommerce/common/cards/flexible_product_card.dart';
import 'package:brn_ecommerce/common/drawer/custom_drawer.dart';
import 'package:brn_ecommerce/common/messengers/search_dialog.dart';
import 'package:brn_ecommerce/common/miscellaneous/empty_page_indicator.dart';
import 'package:brn_ecommerce/common/sliding_up_panel/filters_sliding_up_panel.dart';
import 'package:brn_ecommerce/helpers/breakpoints.dart';
import 'package:brn_ecommerce/models/product_manager.dart';
import 'package:brn_ecommerce/models/users_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({
    super.key,
  });

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final PanelController panelController = PanelController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final productManager = Provider.of<ProductManager>(context, listen: false);
      productManager.filtersOn = false;
      productManager.search = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final Set<StatusOfProducts> selectedStatus = <StatusOfProducts>{};
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        toolbarHeight: 40,
        title: Consumer<ProductManager>(
          builder: (_, productManager, __) {
            if (productManager.search.isEmpty) {
              return productManager.filtersOn == true
                  ? const Text("Filtro Ativo!")
                  : const Text("Todos os Produtos");
            } else {
              return GestureDetector(
                onTap: () async {
                  final search = await showDialog<String>(
                      context: context,
                      builder: (_) => SearchDialog(
                            initialText: productManager.search,
                            hintText: "Pesquise o produto desejado...",
                          ));
                  if (search != null) {
                    productManager.search = search;
                  }
                },
                child: Container(
                    color: const Color.fromARGB(16, 255, 255, 255),
                    child: Text(
                      productManager.search,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
              );
            }
          },
        ),
        centerTitle: true,
        actions: [
          Consumer<ProductManager>(
            builder: (_, productManager, __) {
              if (productManager.search.isEmpty) {
                return IconButton(
                    onPressed: () async {
                      final search = await showDialog<String>(
                          context: context,
                          builder: (_) => SearchDialog(
                                initialText: productManager.search,
                                hintText: "Pesquise o produto desejado",
                              ));
                      if (search != null) {
                        productManager.search = search;
                      }
                    },
                    icon: const Icon(Icons.search));
              } else {
                return IconButton(
                    onPressed: () async {
                      productManager.search = '';
                    },
                    icon: const Icon(Icons.close));
              }
            },
          ),
          Consumer<UserManager>(
            builder: (_, userManager, __) {
              if (userManager.adminEnable) {
                return IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    Navigator.pushNamed(context, "/edit_product");
                  },
                );
              } else {
                return Container();
              }
            },
          )
        ],
      ),
      body: Consumer<ProductManager>(builder: (_, productManager, __) {
        final filteredProducts = productManager.filteredProducts;
        return Align(
          alignment: Alignment.center,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: tabletBreakpoint),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FiltersSlidingUpPanel(
                  textOfSlidingUpPanel: null,
                  panelController: panelController,
                  selectedStatus: selectedStatus,
                ),
                if (productManager.filtersOn == true)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //TODO: Envolver em um container opaco para decoração
                      const Text(
                        "Filtro Ativo:",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Colors.redAccent,
                        ),
                      ),
                      Text(
                        "${productManager.activeFilterName}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          productManager.disableFilter();
                        },
                      ),
                    ],
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
              Navigator.pushNamed(context, "/cart");
            } else {
              Navigator.pushNamed(context, "/login");
            }
          },
          child: userManager.isLoggedIn
              ? const Icon(Icons.shopping_cart)
              : const Icon(Icons.account_circle),
        );
      }),
    );
  }
}
