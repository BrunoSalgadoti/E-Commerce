import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/models/address.dart';
import 'package:ecommerce/models/cart_manager.dart';
import 'package:ecommerce/models/cart_product.dart';

enum Status { canceled, preparing, transporting, delivered}

class OrderClient {
  OrderClient.fromCartManager(CartManager cartManager) {
    items = List.from(cartManager.items);
    price = cartManager.totalPrice;
    userId = cartManager.users?.id;
    address = cartManager.address;
    status = Status.preparing;
  }

  OrderClient.fromDocument(DocumentSnapshot doc){
    orderId = doc.id;

    items = (doc['items'] as List<dynamic>).map((e) {
      return CartProduct.fromMap(e as Map<String, dynamic>);
    }).toList();

    price = doc['price'] as num;
    userId = doc['user'] as String;
    date = doc['date'] as Timestamp;
    status = Status.values[doc['status'] as int ];
    address = Address.fromMap(doc['address'] as Map<String, dynamic>);
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> saveOrder() async {
    firestore.collection('orders').doc(orderId).set({
      'items' : items?.map((e) => e.toOrderItemMap()).toList(),
      'price' : price,
      'user' : userId,
      'address' : address!.toMap(),
      'status' : status!.index,
      'date' : Timestamp.now(),
    });
  }

  String? orderId;

  List<CartProduct>? items;
  num? price;

  String? userId;

  Address? address;

  Status? status;

  Timestamp? date;

  String get formattedId => '#${orderId?.padLeft(6, '0')}';

  @override
  String toString() {
    return 'OrderClient{firestore: $firestore, orderId: $orderId,'
        ' items: $items, price: $price, userId: $userId,'
        ' address: $address, date: $date}';
  }
}
