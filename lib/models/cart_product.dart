import 'package:brn_ecommerce/models/details_products.dart';
import 'package:brn_ecommerce/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CartProduct extends ChangeNotifier {
  CartProduct.fromProduct(this._product, this._detailsProducts) {
    productId = product?.id;
    quantity = 1;
    size = product?.selectedDetails?.size;
    color = detailsProducts?.selectedColors?.color;
    amount = detailsProducts?.selectedColors?.amount;
    realColorFromCart = _getColorFromString(color!);
  }

  CartProduct.fromDocument(DocumentSnapshot document) {
    id = document.id;
    productId = document.get('pid') as String;
    quantity = document.get('quantity') as int;
    size = document.get('size') as String;
    color = document.get('color') as String?;
    realColorFromCart = _getColorFromString(color!);

    firestore.doc('products/$productId').get().then((doc) {
      product = Product.fromDocument(doc);
    });
  }

  CartProduct.fromMap(Map<String, dynamic> map) {
    productId = map['pid'] as String;
    quantity = map['quantity'] as int;
    size = map['size'] as String;
    fixedPrice = map['fixedPrice'] as num;
    color = map['color'] as String;
    realColorFromCart = _getColorFromString(color!);

    firestore.doc('products/$productId').get().then((doc) {
      product = Product.fromDocument(doc);
    });
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  String? id;
  String? productId;
  String? size;
  String? color;
  int? quantity;
  int? amount;
  num? fixedPrice;
  Color? realColorFromCart;

  Product? _product;

  Product? get product => _product;

  set product(Product? value) {
    _product = value;
    notifyListeners();
  }

  DetailsProducts? _detailsProducts;

  DetailsProducts? get detailsProducts => _detailsProducts;

  set detailsProductsFindValues(DetailsProducts? value) {
    _detailsProducts = value;
    notifyListeners();
  }

  DetailsProducts? get detailsProductsFindValues {
    if (product == null) return null;
    return product?.findSize(size!);
  }

  num get unitPrice {
    if (product == null) return 0;
    return detailsProductsFindValues?.price ?? 0;
  }

  num get totalPrice => unitPrice * quantity!;

  int? get unitQuantityAmount {
    if (product == null) return 0;
    return detailsProductsFindValues?.findAmount(amount)?.amount ?? 0;
  }

  int get unitQuantityStock {
    if (product == null) return 0;
    return detailsProductsFindValues?.stock ?? 0;
  }

  Map<String, dynamic> toCartItemMap() {
    return {
      'pid': productId,
      'quantity': quantity,
      'size': size,
      'color': color,
    };
  }

  Map<String, dynamic> toOrderItemMap() {
    return {
      'pid': productId,
      'quantity': quantity,
      'size': size,
      'color': color,
      'fixedPrice': fixedPrice ?? unitPrice
    };
  }

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

  bool get hasStock {
    if (product != null && product!.deleted) return false;
    final size = detailsProductsFindValues;
    if (size == null) return false;
    return size.stock >= quantity!;
  }

  bool get hasAmount {
    if (product != null && product!.deleted) return false;
    final amount = detailsProductsFindValues?.findAmount(this.amount)?.amount;
    if (amount == null) return false;
    return amount >= quantity!;
  }

  Color _getColorFromString(String color) {
    if (color.length != 7 || color[0] != '#') {
      // Verificar se a string de cor não tem o tamanho esperado (7 caracteres)
      // ou se não começa com '#'. Nesse caso, retornar uma cor padrão ou null.
      return Colors.transparent; // ou retorne null se preferir
    }

    try {
      final int value = int.parse(color.substring(1, 7), radix: 16);
      return Color(value).withOpacity(1.0);
    } catch (e) {
      // Se ocorrer uma exceção ao tentar analisar a cor, retorne uma cor padrão ou null.
      return Colors.transparent; // ou retorne null se preferir
    }
  }
}
