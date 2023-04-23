import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/models/details_products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class Product extends ChangeNotifier {
  Product({
    this.id,
    required this.name,
    this.description,
    this.images,
    this.itemProducts,
  }) {
    images = images ?? [];
    itemProducts = itemProducts ?? [];
  }

  Product.fromDocument(DocumentSnapshot document) {
    id = document.id;
    name = document['name'] as String;
    description = document['description'] as String;
    images = List<String>.from(document.get('images') as List<dynamic>);
    itemProducts = (document['details'] as List<dynamic>)
        .map((d) => DetailsProducts.fromMap(d as Map<String, dynamic>))
        .toList();
  }

  String? id;
  String name = '';
  String? description;
  List<String>? images;
  List<DetailsProducts>? itemProducts;

  List<dynamic>? newImages;

  DetailsProducts? _selectedDetails;

  DetailsProducts? get selectedDetails => _selectedDetails;

  set selectedDetails(DetailsProducts? value) {
    _selectedDetails = value;
    notifyListeners();
  }

  int get totalStock {
    int stock = 0;
    for (final item in itemProducts!) {
      stock += item.stock;
    }
    return stock;
  }

  bool get hasStock {
    return totalStock > 0;
  }

  num get basePrice {
    num lowest = double.infinity;
    for (final size in itemProducts!) {
      if (size.price! < lowest && size.hasStock) {
        lowest = size.price!;
      }
    }
    return lowest;
  }

  DetailsProducts? findSize(String name) {
    try {
      return itemProducts?.firstWhere((s) => s.size == name);
    } catch (error) {
      return null;
    }
  }

  Product clone() {
    return Product(
        id: id,
        name: name,
        description: description,
        images: List.from(images!),
        itemProducts: itemProducts?.map((items) => items.clone()).toList());
  }
}
