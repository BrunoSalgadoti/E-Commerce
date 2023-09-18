import 'package:brn_ecommerce/common/custom_drawer/custom_drawer.dart';
import 'package:brn_ecommerce/common/miscellaneous/empty_page_indicator.dart';
import 'package:brn_ecommerce/common/miscellaneous/search_dialog.dart';
import 'package:brn_ecommerce/common/sliding_up_panel/filters_sliding_up_panel.dart';
import 'package:brn_ecommerce/models/product_manager.dart';
import 'package:brn_ecommerce/models/users_manager.dart';
import 'package:brn_ecommerce/screens/products/components/product_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: Consumer<ProductManager>(
          builder: (_, productManager, __) {
            if (productManager.search.isEmpty) {
              return productManager.filtersOn == true
                  ? const Text("Filtro Ativo!")
                  : const Text("Todos os Produtos");
            } else {
              return LayoutBuilder(builder: (_, constraints) {
                return GestureDetector(
                  onTap: () async {
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
                  child: Container(
                      color: const Color.fromARGB(16, 255, 255, 255),
                      width: constraints.biggest.width,
                      child: Text(
                        productManager.search,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold),
                      )),
                );
              });
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

        return Column(
          children: [
            const FiltersSlidingUpPanel(),
            if (productManager.filtersOn == true)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [
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
                    productManager.filtersOn == true
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
                      padding: const EdgeInsets.only(top: 2, bottom: 10),
                      child: ListView.builder(
                        itemCount: filteredProducts.length,
                        itemBuilder: (_, index) {
                          return ProductListTile(
                            product: productManager.filtersOn == true
                                ? filteredProducts.toList()[index]
                                : filteredProducts.reversed.toList()[index],
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          ],
        );
      }),
      floatingActionButton:
          Consumer<UserManager>(builder: (_, userManager, __) {
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
