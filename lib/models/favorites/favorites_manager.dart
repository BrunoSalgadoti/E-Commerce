import 'package:brn_ecommerce/models/products/product.dart';
import 'package:flutter/material.dart';



class FavoritesManager extends ChangeNotifier {
  final List<Product> _favoritos = [];

  List<Product> get favoritos => List.unmodifiable(_favoritos);

  void addFavorite(Product product) {
    if (!_favoritos.contains(product)) {
      _favoritos.add(product);
      notifyListeners();
    }
  }

  void removeFavorite(Product product) {
    _favoritos.remove(product);
    notifyListeners();
  }

  bool isFavorite(Product product) {
    return _favoritos.contains(product);
  }
}
