import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/models/details_products.dart';
import 'package:flutter/cupertino.dart';

class Product extends ChangeNotifier {

  Product.fromDocument(DocumentSnapshot document) {
    id = document.id;
    name = document['name'] as String;
    description = document['description'] as String;
    images = List<String>.from(document.get('images') as List<dynamic>);
    itemProducts = (document['details']  as List<dynamic>).map(
            (d) => DetailsProducts.fromMap(d as Map<String, dynamic>)).toList();
  }

  String? id;
  String name = '';
  String? description;
  List<String>? images;
  List<DetailsProducts> itemProducts = [];

  DetailsProducts? _selectedDetails;

  DetailsProducts? get selectedDetails => _selectedDetails;
  set selectedDetails(DetailsProducts? value) {
    _selectedDetails = value;
    notifyListeners();
  }

  int get totalStock {
    int stock = 0;
    for(final item in itemProducts) {
      stock += item.stock;
    }
    return stock;
  }

  bool get hasStock {
    return totalStock > 0;
  }

}
