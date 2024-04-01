import 'package:brn_ecommerce/models/products/colors_products.dart';
import 'package:brn_ecommerce/models/products/product.dart';
import 'package:flutter/material.dart';

class DetailsProducts extends ChangeNotifier {
  DetailsProducts({
    this.size,
    this.price,
    required this.stock,
    this.colorProducts,
    this.sellers = 0,
  }) {
    colorProducts = colorProducts ?? [];
  }

  DetailsProducts.fromMap(Map<String, dynamic> map) {
    size = map["size"] as String;
    price = map["price"] as num;
    stock = map["stock"] as int;
    sellers = map["sellers"] as int? ?? 0;
    colorProducts = (map["colors"] as List<dynamic>)
        .map((d) => ColorsProducts.fromMap(d as Map<String, dynamic>))
        .toList();
  }

  String? size;
  num? price;
  int stock = 0;
  int sellers = 0;
  List<ColorsProducts>? colorProducts;

  bool get hasStock => stock > 0;

  ColorsProducts? _selectedColors;

  ColorsProducts? get selectedColors => _selectedColors;

  set selectedColors(ColorsProducts? value) {
    _selectedColors = value;
    notifyListeners();
  }

  ColorsProducts? findAmountByColor(String? color) {
    if (color == null || colorProducts == null) {
      return null;
    }

    try {
      return colorProducts!.firstWhere((a) => a.color == color);
    } catch (error) {
      return null;
    }
  }

  bool areAllColorsEmpty(Product? product) {
    if (product!.itemProducts!.isEmpty) {
      return true; // If the list of sizes is empty, returns true
    }

    for (final details in product.itemProducts!) {
      if (details.colorProducts!.isEmpty) {
        return true; // If color list is empty, returns true
      }

      if (details.colorProducts!.any((colors) => colors.color != "")) {
        return false; // If it finds any non-empty color, it returns false
      }
    }

    return true; // If all colors are empty, returns true
  }

  Map<String, dynamic> toMap() {
    return {
      "size": size,
      "price": price,
      "stock": stock,
      "sellers": sellers,
      "colors": colorProducts!.map((colors) => colors.toMap()).toList(),
    };
  }

  DetailsProducts clone() {
    return DetailsProducts(
      size: size,
      price: price,
      stock: stock,
      sellers: sellers,
      colorProducts: colorProducts?.map((colors) => colors.clone()).toList(),
    );
  }

  @override
  String toString() {
    return 'DetailsProducts{size: $size, colorProducts: $colorProducts, '
        'price: $price, stock: $stock}';
  }
}
