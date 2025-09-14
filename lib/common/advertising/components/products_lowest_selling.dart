import 'package:brn_ecommerce/models/products/product.dart';
import 'package:flutter/foundation.dart';

/// Classe responsável por produtos menos vendidos
class ProductsLowestSelling extends ChangeNotifier {
  final List<Product> allProducts;
  final int minimumSellers; // opcional, margem mínima de vendas

  ProductsLowestSelling({required this.allProducts, this.minimumSellers = 0});

  /// Retorna os produtos elegíveis menos vendidos
  List<Product> getLowestSellingProducts({int count = 15}) {
    final now = DateTime.now();
    final twoWeeksAgo = now.subtract(const Duration(days: 14));

    final eligibleProducts = allProducts.where((p) {
      final insertion = p.insertionDate?.toDate() ?? now;
      return p.isValid! &&
          p.hasStock &&
          !p.deleted &&
          insertion.isBefore(twoWeeksAgo) &&
          p.totalSellers >= minimumSellers;
    }).toList();

    // Ordena pelos menos vendidos primeiro
    eligibleProducts.sort((a, b) => a.totalSellers.compareTo(b.totalSellers));

    return eligibleProducts.take(count).toList();
  }
}
