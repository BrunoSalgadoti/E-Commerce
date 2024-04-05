import 'package:brn_ecommerce/models/products/product.dart';
import 'package:brn_ecommerce/models/sales/cart_manager.dart';
import 'package:brn_ecommerce/models/sales/order_client.dart';
import 'package:brn_ecommerce/services/firebase_remote_configs/monitoring_stock_min.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

/// # CheckoutManager (Folder: models/sales)
///
/// A class representing the checkout manager with functionalities for processing orders,
/// checking stock consistency, generating order IDs, decrementing stock, and more.
///
/// This class handles the checkout process, including checking stock availability,
/// generating order IDs, saving orders, and decrementing product stock after successful checkout.
class CheckoutManager extends ChangeNotifier {
  // Proprieties

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool _loading = false;
  CartManager? cartManager;

  // Getters and Setters

  /// Indicates if the checkout process is currently loading.
  bool get loading => _loading;

  /// Sets the loading state of the checkout process.
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  // Methods

  /// Updates the cart manager instance for checkout.
  void updateCart(CartManager cartManager) {
    this.cartManager = cartManager;
  }

  /// Initiates the checkout process.
  ///
  /// Calls the specified [onStockFail] function if there is an issue with stock availability,
  /// and calls [onSuccess] function if the checkout is successful.
  Future<void> checkout({required Function onStockFail, required Function onSuccess}) async {
    loading = true;

    try {
      await _checkConsistenceOfCounterAndOrders();
      await _decrementStock();
    } catch (error) {
      onStockFail(error);
      loading = false;
      return;
    }

    //TODO: PROCESSAR PAGAMENTO

    final orderId = await _getOrderId();

    final order = OrderClient.fromCartManager(cartManager!);
    order.orderId = orderId.toString();

    await order.saveOrder();

    cartManager!.clearCart();

    onSuccess(order);
    loading = false;
  }

  /// Checks the consistency of order counter and existing orders.
  Future<void> _checkConsistenceOfCounterAndOrders() async {
    final DocumentSnapshot orderCounterSnapshot = await firestore.doc("aux/orderCounter").get();
    final orderCounterCurrent = orderCounterSnapshot.get("current") as int;

    final QuerySnapshot ordersSnapshot = await firestore.collection("orders").get();

    int lastOrderId = 0;

    if (ordersSnapshot.docs.isNotEmpty) {
      for (final orderDoc in ordersSnapshot.docs) {
        final orderId = int.tryParse(orderDoc.id);
        if (orderId != null && orderId > lastOrderId) {
          lastOrderId = orderId;
        }
      }
    }

    bool shouldProceed = orderCounterCurrent > lastOrderId;

    if (!shouldProceed) {
      // Throws an exception an error
      throw 'Entre em contato com a Loja:'
          '\n Informe-os que a verificação: "CCO" falhou!'
          '\n Grato Pela Compreensão!';
    }
  }

  /// Generates a new order ID for the checkout process.
  Future<int> _getOrderId() async {
    await _checkConsistenceOfCounterAndOrders();

    final transactionRef = firestore.doc("aux/orderCounter");

    try {
      final result = await firestore.runTransaction((tx) async {
        final doc = await tx.get(transactionRef);
        final orderId = doc.get("current") as int;
        tx.update(transactionRef, {"current": orderId + 1});
        return {"orderId": orderId};
      });
      return result["orderId"] as int;
    } catch (error) {
      return Future.error('Falha ao gerar número do pedido!: ${error.toString()}');
    }
  }

  /// Decrements the stock of products in the cart after successful checkout.
  Future<void> _decrementStock() async {
    // 1. Read all stocks
    // 2. Decrease inventories locally
    // 3. Save stocks in Firebase

    return firestore.runTransaction((tx) async {
      final List<Product> productsToUpdate = [];
      final List<Product> productsWithoutStock = [];

      for (final cartProduct in cartManager!.items) {
        Product product;

        if (productsToUpdate.any((p) => p.id == cartProduct.productId)) {
          product = productsToUpdate.firstWhere((p) => p.id == cartProduct.productId);
        } else {
          final doc = await tx.get(firestore.doc("products/${cartProduct.productId}"));
          product = Product.fromDocument(doc);
        }

        cartProduct.product = product;
        notifyListeners();

        final details = product.findSize(cartProduct.size!);
        if (details!.stock - cartProduct.quantity! < 0 ||
            cartProduct.unitQuantityAmount - cartProduct.quantity! < 0) {
          productsWithoutStock.add(product);
        } else {
          details.stock -= cartProduct.quantity!;
          details.colorProducts?.firstWhere((color) => color.color == cartProduct.color).amount -=
              cartProduct.quantity!;
          details.sellers += cartProduct.quantity!;
          productsToUpdate.add(product);
        }
      }

      if (productsWithoutStock.isNotEmpty) {
        return Future.error('${productsWithoutStock.length} '
            'Estoque modificado antes da finalização da compra!'
            'Favor verificar quantidade disponível!');
      }

      for (final product in productsToUpdate) {
        tx.update(
            firestore.doc("products/${product.id}"), {"details": product.exportDetailsList()});
      }

      MonitoringStockMin.checkMinimumStock(productsToUpdate, productsWithoutStock);
    });
  }
}
