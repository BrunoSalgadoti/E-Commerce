import 'package:brn_ecommerce/models/product_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/formated_fields/format_values.dart';

class SelectProductScreen extends StatelessWidget {
  const SelectProductScreen({Key? key}) : super(key: key);

  //TODO: Continuar Ajustes...

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
                  clipBehavior: Clip.antiAlias,
                  elevation: 7,
                  margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    visualDensity: VisualDensity.comfortable,
                    // isThreeLine: true, // Allow title and subtitle to expand vertically
                    leading: SizedBox(
                      width: 80,
                      height: double.infinity,
                      child: Image.network(
                        product.images!.first,
                        fit: BoxFit.fill,
                      ),
                    ),
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(product.name!),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: product.hasStock
                          ? Text(formattedRealText(product.basePrice))
                          : const Text(
                        'Fora de estoque',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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






// import 'package:brn_ecommerce/models/product_manager.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../common/formated_fields/format_values.dart';
//
// class SelectProductScreen extends StatelessWidget {
//   const SelectProductScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Vincular Produto'),
//         centerTitle: true,
//       ),
//       backgroundColor: Colors.white,
//       body: Consumer<ProductManager>(
//         builder: (_, productManager, __) {
//           return ListView.builder(
//               itemCount: productManager.allProducts.length,
//               itemBuilder: (_, index) {
//                 final product =
//                     productManager.allProducts.reversed.toList()[index];
//                 return Card(
//                   clipBehavior: Clip.antiAlias,
//                   elevation: 7,
//
//                   margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
//                   child: ListTile(
//                     leading: Image.network(
//                         product.images!.first,
//                         width: 80,
//                         height: 80,
//                         fit: BoxFit.cover,
//                       ),
//
//                     title: Text(product.name!),
//                     subtitle: product.hasStock
//                         ? Text(formattedRealText(product.basePrice))
//                         : const Text(
//                             'Fora de estoque',
//                             style: TextStyle(
//                               fontSize: 15,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                     onTap: () {
//                       Navigator.of(context).pop(product);
//                     },
//                   ),
//                 );
//               });
//         },
//       ),
//     );
//   }
// }
