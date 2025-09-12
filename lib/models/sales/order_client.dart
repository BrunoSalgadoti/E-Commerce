import 'package:brn_ecommerce/common/formatted_fields/format_values.dart';
import 'package:brn_ecommerce/models/locations_services/address.dart';
import 'package:brn_ecommerce/models/products/cart_product.dart';
import 'package:brn_ecommerce/models/sales/cart_manager.dart';
import 'package:brn_ecommerce/services/development_monitoring/firebase_performance.dart';
import 'package:brn_ecommerce/services/development_monitoring/monitoring_logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

/// # StatusOfOrders (Folder: models/sales)
///
/// An enum representing the status of orders, including canceled, preparing,
/// transporting, delivered, keeping return, and returned.
enum StatusOfOrders { canceled, preparing, transporting, delivered, keepingReturn, returned }

/// # OrderClient (Folder: models/sales)
///
/// A class representing an order with properties and methods for managing order data,
/// including order ID, user information, items, address, status, and more.
///
/// This class handles order-related functionalities such as saving orders, updating status,
/// getting status text, advancing and going back in status, and managing order cancellation.
class OrderClient {
  // Proprieties

  String? orderId;
  String? userId;
  String? userName;
  num? totalQuantity;
  num? price;
  List<CartProduct>? items;
  Address? address;
  StatusOfOrders? status;
  Timestamp? date;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  /// Returns the Firestore reference for the order document.
  DocumentReference get firestoreRef => firestore.collection("orders").doc(orderId);

  //Constructors

  /// Initializes an instance of [OrderClient] from a [CartManager] instance.
  ///
  /// This constructor creates an order instance based on the data retrieved from a [CartManager].
  OrderClient.fromCartManager(CartManager cartManager) {
    items = List.from(cartManager.items);
    price = cartManager.totalPrice;
    userId = cartManager.users?.id;
    totalQuantity = cartManager.totalQuantity;
    userName = cartManager.users?.userName;
    address = cartManager.address;
    status = StatusOfOrders.preparing;
  }

  /// Initializes an instance of [OrderClient] from a Firestore document snapshot.
  ///
  /// The factory constructor creates an order instance based on the data retrieved from a Firestore document snapshot.
  OrderClient.fromDocument(DocumentSnapshot doc) {
    if (kDebugMode) {
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

  // Getters and Setters

  /// Gets the formatted order ID.
  String get formattedId => formattedOrderId(orderId);

  /// Gets the text representation of the order status.
  String get statusText => getStatusText(status!);

  /// Gets the next status text based on the current order status.
  String get nextStatusText => getNextStatusText(status!);

  /// Gets the previous status text based on the current order status.
  String get previousStatusText => getPreviousStatusText(status!);

  /// Gets the body text based on the current order status.
  String get bodyText => getBodyText(status!);

  // Methods

  /// Updates the order status based on a Firestore document snapshot.
  void updateFromDocument(DocumentSnapshot doc) {
    status = StatusOfOrders.values[doc["status"] as int];
  }

  /// Saves the order data to Firestore.
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

  /// Gets the function to go back in status, if applicable.
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

  /// Gets the function to advance in status, if applicable.
  Function()? get advance {
    return status!.index < StatusOfOrders.returned.index
        ? () {
            status = StatusOfOrders.values[status!.index + 1];
            firestoreRef.update({"status": status!.index});
          }
        : null;
  }

  /// Cancels the order status.
  void cancelStatus() {
    status = StatusOfOrders.canceled;
    firestoreRef.update({"status": status!.index});
  }

  /// Returns the text representation of the order status.
  static String getStatusText(StatusOfOrders status) {
    switch (status) {
      case StatusOfOrders.canceled:
        return 'Cancelado';
      case StatusOfOrders.preparing:
        return 'Em preparação';
      case StatusOfOrders.transporting:
        return 'Em transporte';
      case StatusOfOrders.delivered:
        return 'Entregue';
      case StatusOfOrders.keepingReturn:
        return 'Aguardando devolução';
      case StatusOfOrders.returned:
        return 'Encomenda Devolvida!';
    }
  }

  /// Returns the next status text based on the current order status.
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

  /// Returns the previous status text based on the current order status.
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

  /// Returns the body text based on the current order status.
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
