import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/models/details_products.dart';
import 'package:ecommerce/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartProduct extends ChangeNotifier{

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  String? id;
  String? productId;
  int? quantity;
  String? size;
  
  Product? product;

  CartProduct.fromProduct(this.product) {
    productId = product!.id;
    quantity = 1;
    size = product!.selectedDetails?.size;
  }

  CartProduct.fromDocument(DocumentSnapshot document) {
    id = document.id;
    productId = document.get('pid') as String;
    quantity = document.get('quantity') as int;
    size = document.get('size') as String;

      firestore.doc('products/$productId').get().then(
              (doc) {
                product = Product.fromDocument(doc);
                notifyListeners();
              }
      );
  }

  DetailsProducts? get detailsProducts {
    if(product == null) return null;
    return product?.findSize(size!);
  }
  num get unitPrice {
    if(product == null) return 0;
    return detailsProducts?.price ?? 0;
  }

  num get totalPrice => unitPrice * quantity!;

  int get unitQuantity {
    if(product == null) return 0;
    return detailsProducts?.stock ?? 0;
  }

  Map<String, dynamic> toCartItemMap() {
    return {
      'pid': productId,
      'quantity': quantity,
      'size': size,
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

  void decrement(){
      dynamic count = quantity;
      count--;
      quantity = count;
      notifyListeners();
  }

  bool get hasStock {
    final size = detailsProducts;
    if(size == null) return false;
    return size.stock >= quantity!;
  }

}