import 'package:brn_ecommerce/common/outdoor/components/outdoor_item.dart';
import 'package:brn_ecommerce/common/outdoor/components/outdoor_repository.dart';
import 'package:brn_ecommerce/models/products/product.dart';
import 'package:brn_ecommerce/models/products/product_manager.dart';
import 'package:flutter/material.dart';

class OutdoorController extends ChangeNotifier {
  final OutdoorRepository _repository;
  final ProductManager productManager;

  List<OutdoorItem> items = [];

  OutdoorController(this._repository, this.productManager);

  Future<void> loadOutdoors() async {
    items = await _repository.getOutdoors();
    notifyListeners();
  }

  Future<void> addOutdoor(OutdoorItem item) async {
    await _repository.addOutdoor(item);
    await loadOutdoors();
  }

  Future<void> deleteOutdoor(OutdoorItem item) async {
    await _repository.deleteOutdoor(item);
    await loadOutdoors();
  }

  Future<void> uploadImage() async {
    final newItem = await _repository.uploadImage();
    if (newItem != null) await loadOutdoors();
  }

  Future<void> addYoutube(String url) async {
    await _repository.addYoutube(url);
    await loadOutdoors();
  }

  Future<void> addAsset(String path) async {
    await _repository.addAsset(path);
    await loadOutdoors();
  }

  /// Busca produto pelo ID
  Product? getProductById(String id) {
    return productManager.findProductById(id);
  }
}
