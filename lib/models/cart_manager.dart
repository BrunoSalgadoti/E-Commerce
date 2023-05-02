import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/models/cart_product.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/models/users.dart';
import 'package:ecommerce/models/users_manager.dart';
import 'package:flutter/foundation.dart';

class CartManager extends ChangeNotifier {
  List<CartProduct> items = [];
  Users? users;
  num productsPrice = 0.0;
  bool _disposed = false; // adicionando variável para verificar se foi descartado

  void updateUser(UserManager userManager) {
    users = userManager.users;
    items.clear();

    if (users != null) {
        _loadCartItems();
    }
  }

  Future<void> _loadCartItems() async {
    final QuerySnapshot cartSnap = await users!.cartReference.get();

    items = cartSnap.docs
        .map((d) => CartProduct.fromDocument(d)..addListener(_onItemUpdate))
        .toList();
  }

  void addToCart(Product product) {
    try {
      final sameEntity = items.firstWhere((p) => p.stackable(product));
      sameEntity.increment();
    } catch (newCartProd) {
      final cartProduct = CartProduct.fromProduct(product);
      cartProduct.addListener(_onItemUpdate);
      items.add(cartProduct);
      users!.cartReference
          .add(cartProduct.toCartItemMap())
          .then((doc) => cartProduct.id = doc.id);
      _onItemUpdate();
    }
  }

  void removeOfCart(CartProduct cartProduct) {
    items.removeWhere((p) => p.id == cartProduct.id);
    users!.cartReference.doc(cartProduct.id).delete();
    cartProduct.removeListener(_onItemUpdate);
    notifyListeners();
  }

  void _onItemUpdate() {
    if (_disposed) { // lançando exceção caso o objeto já tenha sido descartado
      throw Exception('CartManager foi usado após ser descartado.');
    }
    productsPrice = 0.0;

    for (int i = 0; i < items.length; i++) {
      final cartProduct = items[i];

      if (cartProduct.quantity == 0) {
        removeOfCart(cartProduct);
        i--;
        continue;
      }
      productsPrice += cartProduct.totalPrice;

      _updateCartProduct(cartProduct);
    }
    notifyListeners();
  }

  void _updateCartProduct(CartProduct cartProduct) {
    if (cartProduct.id != null) {
      users!.cartReference
          .doc(cartProduct.id)
          .update(cartProduct.toCartItemMap());
    }
  }

  bool get isCartValid {
    for (final cartProduct in items) {
      if (!cartProduct.hasStock) return false;
    }
    return true;
  }

  @override
  void dispose() {
    _disposed = true; // marcando como descartado
    super.dispose();
  }
}