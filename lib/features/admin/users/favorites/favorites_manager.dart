import 'package:brn_ecommerce/core/firestore_service.dart';
import 'package:brn_ecommerce/features/auth/managers/users_manager.dart';
import 'package:brn_ecommerce/models/products/product.dart';
import 'package:flutter/material.dart';

class FavoritesManager extends ChangeNotifier {
  final UserManager userManager;

  final List<Product> _favoritos = [];
  final List<Product> _wishlist = [];

  static const int maxFavorites = 100;
  static const int maxWishlist = 70;

  final FirestoreService _firestoreService = FirestoreService.instance;

  String? userId;

  // 🔥 CONTROLE DE REEXECUÇÃO
  String? _lastUserId;
  bool _isLoading = false;

  List<Product> get favoritos => List.unmodifiable(_favoritos);
  List<Product> get wishlist => List.unmodifiable(_wishlist);

  FavoritesManager({required this.userManager}) {
    if (userManager.users?.id != null) {
      updateUser(userManager.users!.id);
    }

    userManager.addListener(() {
      updateUser(userManager.users?.id);
    });
  }

  /// =========================
  /// 🔥 UPDATE USER (PROTEGIDO)
  /// =========================
  Future<void> updateUser(String? userId) async {
    if (userId == null) return;

    // 🔥 evita chamadas duplicadas
    if (_isLoading) return;

    // 🔥 evita reload desnecessário
    if (_lastUserId == userId && _favoritos.isNotEmpty) return;

    _isLoading = true;
    _lastUserId = userId;

    this.userId = userId;

    _favoritos.clear();
    _wishlist.clear();

    try {
      final doc = await _firestoreService.getDocument(
        collection: 'users',
        docId: userId,
      );

      if (!doc.exists) return;

      final data = doc.data()!;
      final favoriteIds = List<String>.from(data['favorites'] ?? []);
      final wishlistIds = List<String>.from(data['wishlist'] ?? []);

      final List<Future<void>> futures = [];

      // =========================
      // FAVORITES
      // =========================
      futures.addAll(
        favoriteIds.map(
          (id) async {
            final pDoc = await _firestoreService.getDocument(
              collection: 'products',
              docId: id,
            );

            if (pDoc.exists &&
                _favoritos.length < maxFavorites &&
                !_favoritos.any((p) => p.id == id)) {
              _favoritos.add(Product.fromDocument(pDoc));
            }
          },
        ),
      );

      // =========================
      // WISHLIST (CORRIGIDO)
      // =========================
      futures.addAll(
        wishlistIds.map(
          (id) async {
            final pDoc = await _firestoreService.getDocument(
              collection: 'products',
              docId: id,
            );

            if (pDoc.exists &&
                _wishlist.length < maxWishlist &&
                !_wishlist.any((p) => p.id == id)) {
              _wishlist.add(Product.fromDocument(pDoc));
            }
          },
        ),
      );

      await Future.wait(futures);

      notifyListeners();
    } catch (e) {
      debugPrint('FavoritesManager ERROR → $e');
    } finally {
      _isLoading = false;
    }
  }

  // =========================
  // FAVORITES
  // =========================
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

  // =========================
  // WISHLIST
  // =========================
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

  // =========================
  // FIRESTORE SYNC
  // =========================
  Future<void> _updateFirestore() async {
    if (userId == null) return;

    await _firestoreService.updateDocument(
      collection: 'users',
      docId: userId ?? '',
      data: {
        'favorites': _favoritos.map((p) => p.id).toSet().toList(),
        'wishlist': _wishlist.map((p) => p.id).toSet().toList(),
      },
    );
  }
}
