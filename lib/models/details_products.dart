import 'package:brn_ecommerce/models/colors_products.dart';
import 'package:brn_ecommerce/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    size = map["size"] as String;
    price = map["price"] as num;
    stock = map["stock"] as int;
    colorProducts = (map["colors"] as List<dynamic>)
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
      return true; // Se a lista de tamanhos estiver vazia, retorna verdadeiro
    }

    for (final details in product.itemProducts!) {
      if (details.colorProducts!.isEmpty) {
        return true; // Se a lista de cores estiver vazia, retorna verdadeiro
      }

      if (details.colorProducts!.any((colors) => colors.color != "")) {
        return false; // Se encontrar alguma cor não vazia, retorna falso
      }
    }

    return true; // Se todas as cores forem vazias, retorna verdadeiro
  }

  String get totalColors {
    String color = "";
    for (final colors in colorProducts!) {
      color += colors.color!;
    }
    return color;
  }

  Map<String, dynamic> toMap() {
    return {
      "size": size,
      "price": price,
      "stock": stock,
      "colors": colorProducts!.map((colors) => colors.toMap()).toList(),
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

  Future<void> ifTheProductIsDeleted(
      String? productId, List<DetailsProducts>? itemProducts) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final DocumentReference productRef = firestore.doc("products/$productId");

    final List<Map<String, dynamic>> updatedColorProducts = colorProducts!
        .map((colors) => {
              ...colors.toMap(),
              "amount": 0,
            })
        .toList();

    final List<Map<String, dynamic>> updatedDetailsList = itemProducts!
        .map((details) => {
              ...details.toMap(),
              "colors": updatedColorProducts,
            })
        .toList();

    await productRef.update({"details": updatedDetailsList});
  }

  @override
  String toString() {
    return 'DetailsProducts{size: $size, colorProducts: $colorProducts, '
        'price: $price, stock: $stock}';
  }
}
