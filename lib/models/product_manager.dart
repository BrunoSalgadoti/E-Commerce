import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/models/product.dart';
import 'package:flutter/cupertino.dart';

class ProductManager extends ChangeNotifier {

  ProductManager(){
    _loadAllProducts();
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<Product> allProducts = [];

  Future<void> _loadAllProducts() async{
    final QuerySnapshot snapProducts =
    await firestore.collection('products').get();

    allProducts = snapProducts.docs.map(
            (d) => Product.fromDocument(d)).toList();

    notifyListeners();
  }
}