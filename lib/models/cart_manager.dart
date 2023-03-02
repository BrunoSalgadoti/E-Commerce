import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/models/cart_product.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/models/users.dart';
import 'package:ecommerce/models/users_manager.dart';

class CartManager {

  List<CartProduct> items = [];

  Users? users;

  void updateUser(UserManager userManager) {
    users = userManager.users;
    items.clear();

    if(users != null) {
      _loadCartItems();
    }
  }
  
  Future<void> _loadCartItems() async {
    final QuerySnapshot cartSnap = await users!.cartReference.get();

    items = cartSnap.docs.map((d) => CartProduct.fromDocument(d)).toList();
  }

  void addToCart(Product product) {
    try {
      final sameEntity = items.firstWhere((p) => p.stackable(product));
      sameEntity.quantity! + sameEntity.quantity!;
    } catch (newCartProd) {
      final cartProduct = CartProduct.fromProduct(product);
      items.add(cartProduct);
      users!.cartReference.add(cartProduct.toCartItemMap());
    }
  }

}