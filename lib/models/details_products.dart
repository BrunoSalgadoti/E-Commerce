import 'package:brn_ecommerce/models/colors_products.dart';
import 'package:flutter/material.dart';

class DetailsProducts extends ChangeNotifier {
  DetailsProducts({
    this.size,
    this.price,
    required this.stock,
    this.colorProducts,
  }) {
    colorProducts = colorProducts ?? [];
  }

  DetailsProducts.fromMap(Map<String, dynamic> map) {
    size = map['size'] as String;
    price = map['price'] as num;
    stock = map['stock'] as int;
    colorProducts = (map['colors'] as List<dynamic>)
        .map((d) => ColorsProducts.fromMap(d as Map<String, dynamic>))
        .toList();
  }

  String? size;
  num? price;
  int stock = 0;
  List<ColorsProducts>? colorProducts;

  bool get hasStock => stock > 0;

  ColorsProducts? _selectedColors;

  ColorsProducts? get selectedColors => _selectedColors;

  set selectedColors(ColorsProducts? value) {
    _selectedColors = value;
    notifyListeners();
  }

  Map<String, dynamic> toMap() {
    return {
      'size': size,
      'price': price,
      'stock': stock,
      'colors': colorProducts!.map((colors) => colors.toMap()).toList(),
    };
  }

  DetailsProducts clone() {
    return DetailsProducts(
      size: size,
      price: price,
      stock: stock,
      colorProducts: colorProducts?.map((colors) => colors.clone()).toList(),
    );
  }

  @override
  String toString() {
    return 'DetailsProducts{size: $size, colorProducts: $colorProducts, '
        'price: $price, stock: $stock}';
  }
}
