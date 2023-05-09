import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/models/address.dart';
import 'package:ecommerce/models/cart_manager.dart';
import 'package:ecommerce/models/cart_product.dart';

class OrderClient {
  OrderClient.fromCartManager(CartManager cartManager) {
    items = List.from(cartManager.items);
    price = cartManager.totalPrice;
    userId = cartManager.users?.id;
    address = cartManager.address;
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> saveOrder() async {
    firestore.collection('orders').doc(orderId).set({
      'items' : items?.map((e) => e.toOrderItemMap()).toList(),
      'price' : price,
      'user' : userId,
      'address' : address!.toMap()

    });
  }

  String? orderId;

  List<CartProduct>? items;
  num? price;

  String? userId;

  Address? address;

  Timestamp? date;
}
