import 'package:brn_ecommerce/models/details_products.dart';
import 'package:brn_ecommerce/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartProduct extends ChangeNotifier {
  CartProduct.fromProduct(this._product) {
    productId = product?.id;
    quantity = 1;
    size = product?.selectedDetails?.size;
  }

  CartProduct.fromDocument(DocumentSnapshot document) {
    id = document.id;
    productId = document.get('pid') as String;
    quantity = document.get('quantity') as int;
    size = document.get('size') as String;

    firestore.doc('products/$productId').get().then((doc) {
      product = Product.fromDocument(doc);
    });
  }

  CartProduct.fromMap(Map<String, dynamic> map) {
    productId = map['pid'] as String;
    quantity = map['quantity'] as int;
    size = map['size'] as String;
    fixedPrice = map['fixedPrice'] as num;

    firestore.doc('products/$productId').get().then((doc) {
      product = Product.fromDocument(doc);
    });
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  String? id;
  String? productId;
  int? quantity;
  String? size;
  num? fixedPrice;

  Product? _product;

  Product? get product => _product;

  set product(Product? value) {
    _product = value;
    notifyListeners();
  }

  DetailsProducts? get detailsProducts {
    if (product == null) return null;
    return product?.findSize(size!);
  }

  num get unitPrice {
    if (product == null) return 0;
    return detailsProducts?.price ?? 0;
  }

  num get totalPrice => unitPrice * quantity!;

  int get unitQuantity {
    if (product == null) return 0;
    return detailsProducts?.stock ?? 0;
  }

  Map<String, dynamic> toCartItemMap() {
    return {
      'pid': productId,
      'quantity': quantity,
      'size': size,
    };
  }

  Map<String, dynamic> toOrderItemMap() {
    return {
      'pid': productId,
      'quantity': quantity,
      'size': size,
      'fixedPrice': fixedPrice ?? unitPrice
    };
  }

  bool stackable(Product product) {
    return product.id == productId && product.selectedDetails!.size == size;
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
    final size = detailsProducts;
    if (size == null) return false;
    return size.stock >= quantity!;
  }
}
