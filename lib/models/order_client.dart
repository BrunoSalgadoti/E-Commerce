import 'package:brn_ecommerce/models/address.dart';
import 'package:brn_ecommerce/models/cart_manager.dart';
import 'package:brn_ecommerce/models/cart_product.dart';
import 'package:brn_ecommerce/services/development_monitoring/firebase_performance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../common/formated_fields/format_values.dart';
import '../services/development_monitoring/monitoring_logger.dart';

enum Status {
  canceled,
  preparing,
  transporting,
  delivered,
  keepingReturn,
  returned
}

class OrderClient {
  OrderClient.fromCartManager(CartManager cartManager) {
    items = List.from(cartManager.items);
    price = cartManager.totalPrice;
    userId = cartManager.users?.id;
    userName = cartManager.users?.userName;
    address = cartManager.address;
    status = Status.preparing;
  }

  OrderClient.fromDocument(DocumentSnapshot doc) {
    if (!kReleaseMode) {
      MonitoringLogger().logInfo('Info: OrderClient.fromDocument');
    }

    orderId = doc.id;

    items = (doc["items"] as List<dynamic>).map((e) {
      return CartProduct.fromMap(e as Map<String, dynamic>);
    }).toList();

    price = doc["price"] as num;
    userId = doc["user"] as String;
    userName = doc["userName"] as String;
    date = doc["date"] as Timestamp;
    status = Status.values[doc["status"] as int];
    address = Address.fromMap(doc["address"] as Map<String, dynamic>);
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  DocumentReference get firestoreRef =>
      firestore.collection("orders").doc(orderId);

  void updateFromDocument(DocumentSnapshot doc) {
    status = Status.values[doc["status"] as int];
  }

  Future<void> saveOrder() async {
    PerformanceMonitoring().startTrace('saveOrder', shouldStart: true);

    firestore.collection("orders").doc(orderId).set({
      "items": items?.map((e) => e.toOrderItemMap()).toList(),
      "price": price,
      "user": userId,
      "userName": userName,
      "address": address!.toMap(),
      "status": status!.index,
      "date": Timestamp.now(),
    });
    PerformanceMonitoring().stopTrace('saveOrder');
  }

  Function()? get back {
    return status!.index >= Status.transporting.index &&
            status!.index != Status.delivered.index &&
            status!.index != Status.returned.index
        ? () {
            status = Status.values[status!.index - 1];
            firestoreRef.update({"status": status!.index});
          }
        : null;
  }

  Function()? get advance {
    return status!.index < Status.returned.index
        ? () {
            status = Status.values[status!.index + 1];
            firestoreRef.update({"status": status!.index});
          }
        : null;
  }

  void cancel() {
    status = Status.canceled;
    firestoreRef.update({"status": status!.index});
  }

  String? orderId;

  List<CartProduct>? items;
  num? price;

  String? userId;
  String? userName;
  Address? address;
  Status? status;
  Timestamp? date;

  String get formattedId => formattedOrderId(orderId);

  String get statusText => getStatusText(status!);

  String get nextStatusText => getNextStatusText(status!);

  String get previousStatusText => getPreviousStatusText(status!);

  String get bodyText => getBodyText(status!);

  static String getStatusText(Status status) {
    switch (status) {
      case Status.canceled:
        return 'Cancelado';
      case Status.preparing:
        return 'Em preparação';
      case Status.transporting:
        return 'Encomenda em transporte';
      case Status.delivered:
        return 'Entregue';
      case Status.keepingReturn:
        return 'Aguardando devolução';
      case Status.returned:
        return 'Encomenda Devolvida!';
      default:
        return '';
    }
  }

  static String getNextStatusText(Status status) {
    switch (status) {
      case Status.preparing:
        return 'Em transporte';
      case Status.transporting:
        return 'Entregue';
      case Status.delivered:
        return 'Aguardando devolução';
      case Status.keepingReturn:
        return 'Encomenda Devolvida';
      default:
        return '';
    }
  }

  static String getPreviousStatusText(Status status) {
    switch (status) {
      case Status.preparing:
        return '';
      case Status.transporting:
        return 'Em preparação';
      case Status.keepingReturn:
        return 'Entregue';
      default:
        return '';
    }
  }

  String getBodyText(Status status) {
    switch (status) {
      case Status.transporting:
        return 'Confrima que a mercadoria chegou '
            'no destinatário Correto?\n'
            '\n---NÃO PODERÁ RETROCEDER o STATUS---';
      case Status.delivered:
        return 'Deseja realmente confirmar que a encomenda\n '
            'vai ser DEVOLVIDA!?';
      case Status.keepingReturn:
        return 'Deseja realmente confirmar que a encomenda\n'
            'foi DEVOLVIDA em Perfeito Estado!?\n '
            '\n---NÃO PODERÁ RETROCEDER o STATUS---';
      case Status.canceled:
        return 'Pedido nº ${'#${orderId?.padLeft(6, '0')}'} será cancelado!'
            'Realmente deseja CANCELAR o pedido?\n '
            '\n---NÃO PODERÁ RETROCEDER o STATUS---';
      default:
        return '';
    }
  }

  @override
  String toString() {
    return 'OrderClient{firestore: $firestore, orderId: $orderId,'
        ' items: $items, price: $price, userId: $userId, userName: $userName,'
        ' address: $address, status: $status, date: $date}';
  }
}
