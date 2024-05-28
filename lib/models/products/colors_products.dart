import 'package:brn_ecommerce/common/functions/common_functions.dart';
import 'package:flutter/material.dart';

/// # Colors Products Model (Folder: models/products)
/// ## ColorsProducts
/// A class representing color variations and their quantities for a product.
///
/// This class manages the details of colors available for a product, including the color name,
/// the quantity available in stock, and the actual color representation. It provides methods for
/// cloning the color object and checking if there is available stock for the color.
class ColorsProducts extends ChangeNotifier {
  String? color;
  int amount = 0;
  Color? realColor;

  // Constructors

  /// Creates a [ColorsProducts] object with the specified parameters.
  ///
  /// The [color] parameter represents the color name.
  /// The [amount] parameter represents the quantity available in stock.
  /// The [realColor] parameter represents the actual color representation.
  ColorsProducts({
    this.color,
    required this.amount,
    this.realColor,
  });

  /// Creates a [ColorsProducts] object from a map.
  ///
  /// This constructor is used when converting a map to a [ColorsProducts] object.
  ColorsProducts.fromMap(Map<String, dynamic> map) {
    color = map["color"] as String;
    amount = map["amount"] as int;
    realColor = getColorFromString(color!);
    notifyListeners();
  }

  // Methods

  /// Converts the [ColorsProducts] object to a map for storage or transmission.
  ///
  /// This method is used when preparing the object for storage in Firestore or transmission over the network.
  Map<String, dynamic> toMap() {
    return {
      "color": color ?? "",
      "amount": amount,
    };
  }

  /// Creates a deep copy (clone) of the [ColorsProducts] object.
  ///
  /// This method is used to create a separate instance of the color object with the same properties.
  ColorsProducts clone() {
    return ColorsProducts(
      realColor: realColor,
      color: color,
      amount: amount,
    );
  }

  // Properties (getters and setters)

  /// Checks if the color has available stock.
  bool get hasAmount => amount > 0;

  // Override Methods
  @override
  String toString() {
    return 'ColorsProducts{color: $color, amount: $amount, '
        'realColor: $realColor}';
  }
}
