import 'package:brn_ecommerce/models/cart_manager.dart';
import 'package:brn_ecommerce/models/order_client.dart';
import 'package:brn_ecommerce/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class CheckoutManager extends ChangeNotifier {
  CartManager? cartManager;

  bool _loading = false;

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void updateCart(CartManager cartManager) {
    this.cartManager = cartManager;
  }

  Future<void> checkout(
      {required Function onStockFail, required Function onSuccess}) async {
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

  Future<void> _checkConsistenceOfCounterAndOrders() async {
    final DocumentSnapshot orderCounterSnapshot =
        await firestore.doc("aux/orderCounter").get();
    final orderCounterCurrent = orderCounterSnapshot.get("current") as int;

    final QuerySnapshot ordersSnapshot =
        await firestore.collection("orders").get();

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
      // Throws an exception an errorr
      throw 'Entre em contato com a Loja:'
          '\n Informe-os que a verificação: "CCO" falhou!'
          '\n Grato Pela Compreenção!';
    }
  }

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
      return Future.error(
          'Falha ao gerar número do pedido!: ${error.toString()}');
    }
  }

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
          product =
              productsToUpdate.firstWhere((p) => p.id == cartProduct.productId);
        } else {
          final doc =
              await tx.get(firestore.doc("products/${cartProduct.productId}"));
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
          details.colorProducts
              ?.firstWhere((color) => color.color == cartProduct.color)
              .amount -= cartProduct.quantity!;
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
        tx.update(firestore.doc("products/${product.id}"),
            {"details": product.exportDetailsList()});
      }
    });
  }
}
