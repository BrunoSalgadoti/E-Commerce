import 'package:brn_ecommerce/models/product_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/formated_fields/format_values.dart';

class SelectProductScreen extends StatelessWidget {
  const SelectProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vincular Produto'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Consumer<ProductManager>(
        builder: (_, productManager, __) {
          return ListView.builder(
              itemCount: productManager.allProducts.length,
              itemBuilder: (_, index) {
                final product =
                    productManager.allProducts.reversed.toList()[index];
                return Card(
                  child: ListTile(
                    leading: Image.network(product.images!.first),
                    title: Text(product.name!),
                    subtitle: Text(formattedRealText(product.basePrice)),
                    onTap: () {
                      Navigator.of(context).pop(product);
                    },
                  ),
                );
              });
        },
      ),
    );
  }
}
