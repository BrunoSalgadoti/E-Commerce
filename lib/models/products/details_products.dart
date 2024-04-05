import 'package:brn_ecommerce/models/products/colors_products.dart';
import 'package:brn_ecommerce/models/products/product.dart';
import 'package:flutter/material.dart';

/// # Details Products Model (Folder: models/products)
/// ## DetailsProducts
/// A class representing product details such as size, price, stock, and available color variations.
///
/// This class manages the details of a product variant, including its size, price, stock availability,
/// available color variations, and related functionalities. It provides methods for finding color
/// variations by color name, checking stock availability, and creating a deep copy of the object.
class DetailsProducts extends ChangeNotifier {
  String? size;
  num? price;
  int stock = 0;
  int sellers = 0;
  List<ColorsProducts>? colorProducts;
  ColorsProducts? _selectedColors;

  // Constructors

  /// Creates a [DetailsProducts] object with the specified parameters.
  ///
  /// The [size] parameter represents the size of the product variant.
  /// The [price] parameter represents the price of the product variant.
  /// The [stock] parameter represents the available quantity in stock.
  /// The [colorProducts] parameter represents the available color variations.
  /// The [sellers] parameter represents the number of sellers offering this variant.
  DetailsProducts({
    this.size,
    this.price,
    required this.stock,
    this.colorProducts,
    this.sellers = 0,
  }) {
    colorProducts = colorProducts ?? [];
  }

  /// Creates a [DetailsProducts] object from a map.
  ///
  /// This constructor is used when converting a map to a [DetailsProducts] object.
  DetailsProducts.fromMap(Map<String, dynamic> map) {
    size = map["size"] as String;
    price = map["price"] as num;
    stock = map["stock"] as int;
    sellers = map["sellers"] as int? ?? 0;
    colorProducts = (map["colors"] as List<dynamic>)
        .map((d) => ColorsProducts.fromMap(d as Map<String, dynamic>))
        .toList();
  }

  // Methods

  /// Converts the [DetailsProducts] object to a map for storage or transmission.
  ///
  /// This method is used when preparing the object for storage in Firestore or transmission over the network.
  Map<String, dynamic> toMap() {
    return {
      "size": size,
      "price": price,
      "stock": stock,
      "sellers": sellers,
      "colors": colorProducts!.map((colors) => colors.toMap()).toList(),
    };
  }

  /// Finds the color variant by color name.
  ///
  /// The [color] parameter represents the color name to search for.
  /// Returns the [ColorsProducts] object corresponding to the provided color name, if found; otherwise, returns null.
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

  /// Checks if all color variations for a product are empty.
  ///
  /// The [product] parameter represents the product object to check for empty color variations.
  /// Returns true if all color variations are empty or if the product has no variations; otherwise, returns false.
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

  /// Creates a deep copy (clone) of the [DetailsProducts] object.
  ///
  /// This method is used to create a separate instance of the product variant object with the same properties.
  DetailsProducts clone() {
    return DetailsProducts(
      size: size,
      price: price,
      stock: stock,
      sellers: sellers,
      colorProducts: colorProducts?.map((colors) => colors.clone()).toList(),
    );
  }

  // Properties (getters and setters)

  /// Checks if the product variant has available stock.
  bool get hasStock => stock > 0;

  /// Gets the currently selected color variant.
  ColorsProducts? get selectedColors => _selectedColors;

  /// Sets the currently selected color variant.
  set selectedColors(ColorsProducts? value) {
    _selectedColors = value;
    notifyListeners();
  }

  @override
  String toString() {
    return 'DetailsProducts{size: $size, colorProducts: $colorProducts, '
        'price: $price, stock: $stock}';
  }
}
