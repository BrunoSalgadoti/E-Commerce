// import 'package:brn_ecommerce/models/product.dart';
// import 'package:brn_ecommerce/models/products_best_selling.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter/material.dart';
//
// class BestSellingProductsScreen extends StatelessWidget {
//   final List<Product> allProducts;
//   final int salesThreshold;
//
//   const BestSellingProductsScreen({super.key,
//     required this.allProducts,
//     this.salesThreshold = 10,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => ProductsBestSelling(
//         allProducts: allProducts,
//         salesThreshold: salesThreshold,
//       ),
//       child: Consumer<ProductsBestSelling>(
//         builder: (_, manager, __) {
//           // Chame o método para atualizar os produtos mais vendidos conforme necessário
//           manager.updateBestSellingProductsIfNeeded();
//
//           // Use manager.bestSellingProducts onde você precisar exibir os produtos mais vendidos
//           // Por exemplo, manager.bestSellingProducts.map((product) => ...)
//
//           return const SizedBox.shrink();
//         },
//       ),
//     );
//   }
// }
