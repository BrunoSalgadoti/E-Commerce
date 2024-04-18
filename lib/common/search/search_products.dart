import 'package:brn_ecommerce/common/search/components/search_dialog.dart';
import 'package:brn_ecommerce/helpers/routes_navigator.dart';
import 'package:brn_ecommerce/models/products/product_manager.dart';
import 'package:brn_ecommerce/models/users/users_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

PreferredSizeWidget searchProducts({
  required BuildContext context,
}) {
  return AppBar(
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
                          hintText: "Pesquise o produto desejado...",
                        ));
                if (search != null) {
                  productManager.search = search;
                }
              },
              icon: const Icon(Icons.search),
            );
          } else {
            return IconButton(
              onPressed: () async => productManager.search = '',
              icon: const Icon(Icons.close),
            );
          }
        },
      ),
      Consumer<UserManager>(
        builder: (_, userManager, __) {
          if (userManager.adminEnable) {
            return IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => Navigator.pushNamed(context, routesNavigator.editProductScreen),
            );
          } else {
            return Container();
          }
        },
      )
    ],
  );
}
