import 'package:brn_ecommerce/models/products/details_products.dart';
import 'package:brn_ecommerce/models/products/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../common/functions/common_functions.dart';

/// # Cart Product Model (Folder: models/products)
/// ## CartProduct
/// A class representing a product in the user's shopping cart.
///
/// This class manages the details of a product added to the cart, including its ID, brand, size, color,
/// quantity, price, and freight information. It provides methods for incrementing and decrementing the quantity,
/// checking stock availability, and managing stackable sizes.
class CartProduct extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? id;
  String? productId;
  String? brand;
  String? size;
  String? color;
  int? quantity;
  num? fixedPrice;
  bool? _freight;
  Color? realColorFromCart;
  Product? _product;
  DetailsProducts? _detailsProducts;

  // Constructors

  /// Creates a [CartProduct] from an existing [Product] and [DetailsProducts].
  ///
  /// The [product] parameter represents the main product details.
  /// The [detailsProducts] parameter represents the details of the product, including size and color options.
  CartProduct.fromProduct(this._product, this._detailsProducts) {
    productId = product?.id;
    brand = product?.brand;
    freight = product?.freight;
    quantity = 1;
    size = product?.selectedDetails?.size;
    color = detailsProducts?.selectedColors?.color ?? "";
    realColorFromCart = getColorFromString(color!);
  }

  /// Creates a [CartProduct] from a Firestore document snapshot.
  ///
  /// This constructor is used when retrieving a cart product from Firestore.
  CartProduct.fromDocument(DocumentSnapshot document) {
    id = document.id;
    productId = document.get("pid") as String;
    brand = document.get("brand") as String? ?? "";
    freight = document.get("freight") as bool? ?? false;
    quantity = document.get("quantity") as int;
    size = document.get("size") as String;
    color = document.get("color") as String? ?? "";
    realColorFromCart = getColorFromString(color!);

    firestore.doc("products/$productId").get().then((doc) {
      product = Product.fromDocument(doc);
    });
  }

  /// Creates a [CartProduct] from a map.
  ///
  /// This constructor is used when converting a map to a cart product object.
  CartProduct.fromMap(Map<String, dynamic> map) {
    productId = map["pid"] as String;
    brand = map["brand"] as String? ?? "";
    freight = map["freight"] as bool? ?? false;
    quantity = map["quantity"] as int;
    size = map["size"] as String;
    fixedPrice = map["fixedPrice"] as num;
    color = map["color"] as String;
    realColorFromCart = getColorFromString(color!);

    firestore.doc("products/$productId").get().then((doc) {
      product = Product.fromDocument(doc);
    });
  }

  // Methods

  /// Converts the cart product to a map for cart item representation.
  ///
  /// This method is used when preparing cart items for storage or transmission.
  Map<String, dynamic> toCartItemMap() {
    return {
      "pid": productId,
      "quantity": quantity,
      "size": size,
      "color": color,
      "brand": brand,
      "freight": freight
    };
  }

  /// Converts the cart product to a map for order item representation.
  ///
  /// This method is used when preparing order items for storage or transmission.
  Map<String, dynamic> toOrderItemMap() {
    return {
      "pid": productId,
      "quantity": quantity,
      "size": size,
      "color": color,
      "brand": brand,
      "freight": freight,
      "fixedPrice": fixedPrice ?? unitPrice
    };
  }

  /// Checks if the cart product's stackable size matches the provided product's size and color.
  ///
  /// The [product] parameter represents the product to compare with.
  bool stackableSize(Product product) {
    return product.id == productId &&
        product.selectedDetails!.size == size &&
        detailsProducts!.selectedColors!.color == color;
  }

  /// Increases the quantity of the cart product by one unit.
  void increment() {
    dynamic count = quantity;
    count++;
    quantity = count;
    notifyListeners();
  }

  /// Decreases the quantity of the cart product by one unit.
  void decrement() {
    dynamic count = quantity;
    count--;
    quantity = count;
    notifyListeners();
  }

  // Properties (getters and setters)

  set product(Product? value) {
    _product = value;
    notifyListeners();
  }

  Product? get product => _product;

  set detailsProductsFindValues(DetailsProducts? value) {
    _detailsProducts = value;
    notifyListeners();
  }

  DetailsProducts? get detailsProducts => _detailsProducts;

  DetailsProducts? get detailsProductsFindValues {
    if (product == null) return null;
    return product?.findSize(size!);
  }

  num get unitPrice {
    if (product == null) return 0;
    return detailsProductsFindValues?.price ?? 0;
  }

  num get totalPrice => unitPrice * quantity!;

  int get unitQuantityAmount {
    if (product == null) return 0;
    return detailsProductsFindValues?.findAmountByColor(color)?.amount ?? 0;
  }

  int get unitQuantityStock {
    if (product == null) return 0;
    return detailsProductsFindValues?.stock ?? 0;
  }

  set freight(bool? value) {
    if (_freight != value) {
      _freight = value;
      notifyListeners();
    }
  }

  bool? get freight => _freight;

  bool get hasStock {
    if (product != null && product!.deleted) return false;
    final size = detailsProductsFindValues;
    if (size == null) return false;
    return size.stock >= quantity!;
  }

  bool get hasAmount {
    if (product != null && product!.deleted) return false;
    final amount = detailsProductsFindValues?.findAmountByColor(color)?.amount;
    if (amount == null) return false;
    return amount >= quantity!;
  }
}
