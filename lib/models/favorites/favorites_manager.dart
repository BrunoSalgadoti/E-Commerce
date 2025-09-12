import 'package:brn_ecommerce/models/products/product.dart';
import 'package:brn_ecommerce/models/users/users_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FavoritesManager extends ChangeNotifier {
  final UserManager userManager;
  final List<Product> _favoritos = [];
  final List<Product> _wishlist = [];

  static const int maxFavorites = 100;
  static const int maxWishlist = 70;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? userId;

  List<Product> get favoritos => List.unmodifiable(_favoritos);
  List<Product> get wishlist => List.unmodifiable(_wishlist);

  FavoritesManager({required this.userManager}) {
    if (userManager.users?.id != null) {
      updateUser(userManager.users!.id);
    }

    // Listen to changes in UserManager
    userManager.addListener(() => updateUser(userManager.users?.id));
  }

  /// Updates the user and loads their favorites and wishlist
  Future<void> updateUser(String? userId) async {
    if (userId == null) return;

    this.userId = userId;

    // Clear lists before starting
    _favoritos.clear();
    _wishlist.clear();

    final doc = await firestore.collection('users').doc(userId).get();
    if (!doc.exists) return;

    final data = doc.data()!;
    final favoriteIds = List<String>.from(data['favorites'] ?? []);
    final wishlistIds = List<String>.from(data['wishlist'] ?? []);

    final List<Future<void>> futures = [];

    // Load favorites
    futures.addAll(
      favoriteIds.map(
        (id) async {
          final pDoc = await firestore.collection('products').doc(id).get();
          if (pDoc.exists &&
              _favoritos.length < maxFavorites &&
              !_favoritos.any((p) => p.id == id)) {
            _favoritos.add(Product.fromDocument(pDoc));
          }
        },
      ),
    );

    // Load wishlist
    futures.addAll(
      wishlistIds.map(
        (id) async {
          final pDoc = await firestore.collection('products').doc(id).get();
          if (pDoc.exists && _wishlist.length < maxWishlist && !_wishlist.any((p) => p.id == id)) {
            _wishlist.add(Product.fromDocument(pDoc));
          }
        },
      ),
    );

    await Future.wait(futures);
    notifyListeners();
  }

  // --- FAVORITES ---
  bool isFavorite(Product product) => _favoritos.any((p) => p.id == product.id);

  Future<void> addFavorite(Product product) async {
    if (userId == null || isFavorite(product) || _favoritos.length >= maxFavorites) return;
    _favoritos.add(product);
    notifyListeners();
    await _updateFirestore();
  }

  Future<void> removeFavorite(Product product) async {
    if (userId == null) return;
    _favoritos.removeWhere((p) => p.id == product.id);
    notifyListeners();
    await _updateFirestore();
  }

  // --- WISHLIST ---
  bool isInWishlist(Product product) => _wishlist.any((p) => p.id == product.id);

  Future<void> addWishlist(Product product) async {
    if (userId == null || isInWishlist(product) || _wishlist.length >= maxWishlist) return;
    _wishlist.add(product);
    notifyListeners();
    await _updateFirestore();
  }

  Future<void> removeWishlist(Product product) async {
    if (userId == null) return;
    _wishlist.removeWhere((p) => p.id == product.id);
    notifyListeners();
    await _updateFirestore();
  }

  // --- FIRESTORE SYNC ---
  Future<void> _updateFirestore() async {
    if (userId == null) return;

    await firestore.collection('users').doc(userId).update(
      {
        'favorites': _favoritos.map((p) => p.id).toSet().toList(),
        'wishlist': _wishlist.map((p) => p.id).toSet().toList(),
      },
    );
  }
}
