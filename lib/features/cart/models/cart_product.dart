import 'package:brn_ecommerce/models/products/details_products.dart';
import 'package:brn_ecommerce/models/products/product.dart';
import 'package:brn_ecommerce/shared/utils/colors/color_parsers.dart';
import 'package:flutter/material.dart';


class CartProduct extends ChangeNotifier {
// =========================
// 📦 DATA
// =========================
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

// =========================
// 🏗 CONSTRUCTORS
// =========================

  CartProduct.fromProduct(this._product, this._detailsProducts) {
    productId = product?.id;
    brand = product?.brand;
    freight = product?.freight;
    quantity = 1;
    size = product?.selectedDetails?.size;
    color = detailsProducts?.selectedColors?.color ?? "";
    realColorFromCart = getColorFromString(color!);
  }

  CartProduct.fromDocument(document) {
    id = document.id;
    productId = document.get("pid") as String;
    brand = document.get("brand") as String? ?? "";
    freight = document.get("freight") as bool? ?? false;
    quantity = document.get("quantity") as int;
    size = document.get("size") as String;
    color = document.get("color") as String? ?? "";
    realColorFromCart = getColorFromString(color!);

// 🔥 Product atualizado em tempo real via CartManager (controle centralizado pelo CORE)
  }

  CartProduct.fromMap(Map<String, dynamic> map) {
    productId = map["pid"] as String;
    brand = map["brand"] as String? ?? "";
    freight = map["freight"] as bool? ?? false;
    quantity = map["quantity"] as int;
    size = map["size"] as String;
    fixedPrice = map["fixedPrice"] as num;
    color = map["color"] as String;
    realColorFromCart = getColorFromString(color!);
  }

// =========================
// 🔁 MAPS (MANTIDOS)
// =========================

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

// =========================
// 🧠 LOGIC
// =========================

  bool stackableSize(Product product) {
    return product.id == productId &&
        product.selectedDetails!.size == size &&
        detailsProducts!.selectedColors!.color == color;
  }

  void increment() {
    dynamic count = quantity;
    count++;
    quantity = count;
    notifyListeners();
  }

  void decrement() {
    dynamic count = quantity;
    count--;
    quantity = count;
    notifyListeners();
  }

// =========================
// 🔐 GETTERS / SETTERS
// =========================

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
