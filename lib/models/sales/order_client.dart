import 'package:brn_ecommerce/models/address_n_cep/address.dart';
import 'package:brn_ecommerce/models/products/cart_product.dart';
import 'package:brn_ecommerce/models/sales/cart_manager.dart';
import 'package:brn_ecommerce/services/development_monitoring/firebase_performance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../common/formatted_fields/format_values.dart';
import '../../services/development_monitoring/monitoring_logger.dart';

enum StatusOfOrders { canceled, preparing, transporting, delivered, keepingReturn, returned }

class OrderClient {
  OrderClient.fromCartManager(CartManager cartManager) {
    items = List.from(cartManager.items);
    price = cartManager.totalPrice;
    userId = cartManager.users?.id;
    totalQuantity = cartManager.totalQuantity;
    userName = cartManager.users?.userName;
    address = cartManager.address;
    status = StatusOfOrders.preparing;
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
    totalQuantity = doc["totalQuantity"] as num;
    userId = doc["user"] as String;
    userName = doc["userName"] as String;
    date = doc["date"] as Timestamp;
    status = StatusOfOrders.values[doc["status"] as int];
    address = Address.fromMap(doc["address"] as Map<String, dynamic>);
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  DocumentReference get firestoreRef => firestore.collection("orders").doc(orderId);

  void updateFromDocument(DocumentSnapshot doc) {
    status = StatusOfOrders.values[doc["status"] as int];
  }

  Future<void> saveOrder() async {
    PerformanceMonitoring().startTrace('save-order', shouldStart: true);

    firestore.collection("orders").doc(orderId).set({
      "items": items?.map((e) => e.toOrderItemMap()).toList(),
      "price": price,
      "user": userId,
      "userName": userName,
      "totalQuantity": totalQuantity,
      "address": address!.toMap(),
      "status": status!.index,
      "date": Timestamp.now(),
    });
    PerformanceMonitoring().stopTrace('save-order');
  }

  Function()? get back {
    return status!.index >= StatusOfOrders.transporting.index &&
            status!.index != StatusOfOrders.delivered.index &&
            status!.index != StatusOfOrders.returned.index
        ? () {
            status = StatusOfOrders.values[status!.index - 1];
            firestoreRef.update({"status": status!.index});
          }
        : null;
  }

  Function()? get advance {
    return status!.index < StatusOfOrders.returned.index
        ? () {
            status = StatusOfOrders.values[status!.index + 1];
            firestoreRef.update({"status": status!.index});
          }
        : null;
  }

  void cancelStatus() {
    status = StatusOfOrders.canceled;
    firestoreRef.update({"status": status!.index});
  }

  String? orderId;

  List<CartProduct>? items;
  num? price;

  String? userId;
  String? userName;
  Address? address;
  num? totalQuantity;
  StatusOfOrders? status;
  Timestamp? date;

  String get formattedId => formattedOrderId(orderId);

  String get statusText => getStatusText(status!);

  String get nextStatusText => getNextStatusText(status!);

  String get previousStatusText => getPreviousStatusText(status!);

  String get bodyText => getBodyText(status!);

  static String getStatusText(StatusOfOrders status) {
    switch (status) {
      case StatusOfOrders.canceled:
        return 'Cancelado';
      case StatusOfOrders.preparing:
        return 'Em preparação';
      case StatusOfOrders.transporting:
        return 'Encomenda em transporte';
      case StatusOfOrders.delivered:
        return 'Entregue';
      case StatusOfOrders.keepingReturn:
        return 'Aguardando devolução';
      case StatusOfOrders.returned:
        return 'Encomenda Devolvida!';
      default:
        return '';
    }
  }

  static String getNextStatusText(StatusOfOrders status) {
    switch (status) {
      case StatusOfOrders.preparing:
        return 'Em transporte';
      case StatusOfOrders.transporting:
        return 'Entregue';
      case StatusOfOrders.delivered:
        return 'Aguardando devolução';
      case StatusOfOrders.keepingReturn:
        return 'Encomenda Devolvida';
      default:
        return '';
    }
  }

  static String getPreviousStatusText(StatusOfOrders status) {
    switch (status) {
      case StatusOfOrders.preparing:
        return '';
      case StatusOfOrders.transporting:
        return 'Em preparação';
      case StatusOfOrders.keepingReturn:
        return 'Entregue';
      default:
        return '';
    }
  }

  String getBodyText(StatusOfOrders status) {
    switch (status) {
      case StatusOfOrders.transporting:
        return 'Confirma que a mercadoria chegou '
            'no destinatário Correto?\n'
            '\n---NÃO PODERÁ RETROCEDER o STATUS---';
      case StatusOfOrders.delivered:
        return 'Deseja realmente confirmar que a encomenda\n '
            'vai ser DEVOLVIDA!?';
      case StatusOfOrders.keepingReturn:
        return 'Deseja realmente confirmar que a encomenda\n'
            'foi DEVOLVIDA em Perfeito Estado!?\n '
            '\n---NÃO PODERÁ RETROCEDER o STATUS---';
      case StatusOfOrders.canceled:
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
