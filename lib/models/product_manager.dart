import 'dart:async';
import 'package:brn_ecommerce/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class ProductManager extends ChangeNotifier {
  ProductManager() {
    _listenToProducts();
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  StreamSubscription? _subscription;

  List<Product> allProducts = [];
  String _search = '';

  String get search => _search;

  set search(String value) {
    _search = value;
    notifyListeners();
  }

  List<Product> get filteredProducts {
    final List<Product> filteredProducts = [];

    if (search.isEmpty) {
      filteredProducts.addAll(allProducts);
    } else {
      filteredProducts.addAll(allProducts
          .where((p) => p.name!.toLowerCase().contains(search.toLowerCase())));
    }
    return filteredProducts;
  }

  void _listenToProducts() async {
    _subscription = firestore
        .collection('products')
        .where('deleted', isEqualTo: false)
        .snapshots()
        .listen((event) {
      allProducts.clear();
      for (final product in event.docs) {
        // Make sure the document is complete before creating a Product instance
        if (product.data().containsKey('name') &&
            product.data().containsKey('description') &&
            product.data().containsKey('images') &&
            product.data().containsKey('details')) {
          allProducts.add(Product.fromDocument(product));
        }
      }
      notifyListeners();
    });
  }

  Product? findProductById(String id) {
    try {
      return allProducts.firstWhere((p) => p.id == id);
    } catch (error) {
      return null;
    }
  }

  void updateProducts(Product product) {
    allProducts.removeWhere((p) => p.id == product.id);
    allProducts.add(product);
    notifyListeners();
  }

  void requestDelete(Product product) {
    product.delete();
    allProducts.removeWhere((p) => p.id == product.id);
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
  }
}
