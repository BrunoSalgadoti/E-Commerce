import 'package:ecommerce/common/custom_drawer/custom_drawer.dart';
import 'package:ecommerce/models/product_manager.dart';
import 'package:ecommerce/screens/products/components/product_list_tile.dart';
import 'package:ecommerce/screens/products/components/search_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: Consumer<ProductManager>(
          builder: (_, productManager, __) {
            if (productManager.search.isEmpty) {
              return const Text('Produtos');
            } else {
              return LayoutBuilder(
                  builder: (_, constraints){
                    return GestureDetector(
                      onTap: () async {
                        final search = await showDialog<String>(context: context,
                            builder: (_) =>  SearchDialog(
                                initialText: productManager.search
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
                              fontSize: 23,
                              fontWeight: FontWeight.bold
                            ),
                          )
                      ) ,
                    );
                  }
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
                            initialText: productManager.search
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
          )
        ],
      ),
      body: Consumer<ProductManager>(
        builder: (_, productManager, __) {
          final filteredProducts = productManager.filteredProducts;
          return ListView.builder(
              padding: const EdgeInsets.all(5),
              itemCount: filteredProducts.length,
              itemBuilder: (_, index) {
                return ProductListTile(product: filteredProducts[index]);
              });
        },
      ),
    );
  }
}
