import 'package:brn_ecommerce/core/firestore_service.dart';
import 'package:brn_ecommerce/data/services/products/products_best_selling.dart';
import 'package:brn_ecommerce/models/products/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PurchaseModel {
  final String userId;
  final List<String> items;
  final DateTime createdAt;

  PurchaseModel({
    required this.userId,
    required this.items,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'items': items,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  factory PurchaseModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return PurchaseModel(
      userId: map['userId'] ?? '',
      items: List<String>.from(
        map['items'] ?? [],
      ),
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  /// Saves a purchase within aux/purchases/items
  /// centralizing by user
  static Future<void> savePurchase(
    PurchaseModel purchase,
  ) async {
    final firestore = FirestoreService.instance;

    await firestore.setDocument(
      collection: 'aux',
      docId: 'purchases',
      data: {},
      merge: true,
    );

    final snapshot = await firestore.getSubCollectionDocument(
      collection: 'aux',
      docId: 'purchases',
      subCollection: 'items',
      subDocId: purchase.userId,
    );

    if (snapshot.exists) {
      await firestore.updateSubCollectionDocument(
        collection: 'aux',
        docId: 'purchases',
        subCollection: 'items',
        subDocId: purchase.userId,
        data: {
          'items': FieldValue.arrayUnion(
            purchase.items,
          ),
          'updatedAt': DateTime.now(),
        },
      );
    } else {
      await firestore.setSubCollectionDocument(
        collection: 'aux',
        docId: 'purchases',
        subCollection: 'items',
        subDocId: purchase.userId,
        data: {
          'userId': purchase.userId,
          'items': purchase.items,
          'createdAt': DateTime.now(),
          'updatedAt': DateTime.now(),
        },
      );
    }
  }

  /// Returns all product IDs that
  /// the user has already purchased
  static Future<List<String>> getUserPurchasedItems(
    String userId,
  ) async {
    final firestore = FirestoreService.instance;

    final snapshot = await firestore.getSubCollectionDocument(
      collection: 'aux',
      docId: 'purchases',
      subCollection: 'items',
      subDocId: userId,
    );

    if (!snapshot.exists) {
      return [];
    }

    final data = snapshot.data();

    final List<dynamic> items = data?['items'] ?? [];

    return items.cast<String>();
  }

  /// Returns suggested products (X/X)
  /// based on other users' purchases
  /// + best sellers
  static Future<List<Product>> getPurchaseSuggestions({
    required String userId,
    required List<Product> allProducts,
    int suggestionCount = 24,
  }) async {
    final firestore = FirestoreService.instance;

    final userItems = await getUserPurchasedItems(
      userId,
    );

    final productsBestSelling = ProductsBestSelling(
      allProducts: allProducts,
      salesThreshold: 24,
    );

    // User never purchased
    // → get best sellers
    if (userItems.isEmpty) {
      return productsBestSelling.getBestSellingProducts(
        suggestionCount,
      );
    }

    final snapshot = await firestore.querySubCollection(
      collection: "aux",
      docId: "purchases",
      subCollection: "items",
      field: "items",
      arrayContainsAny: userItems,
    );

    final relatedItems = <String>{};

    for (final doc in snapshot.docs) {
      final otherUserId = doc["userId"];

      if (otherUserId == userId) {
        continue;
      }

      final List<dynamic> items = doc["items"] ?? [];

      relatedItems.addAll(
        items.cast<String>(),
      );
    }

    relatedItems.removeWhere(
      (id) => userItems.contains(id),
    );

    List<Product> suggestions = [];

    if (relatedItems.isNotEmpty) {
      final prodsSnap = await firestore.queryCollectionWhereIn(
        collection: "products",
        fieldPath: FieldPath.documentId,
        whereIn: relatedItems.toList(),
      );

      suggestions = prodsSnap.docs
          .map(
            (d) => Product.fromDocument(d),
          )
          .toList();
    }

    suggestions = suggestions
        .where(
          (p) =>
              p.itemProducts?.any(
                (d) => d.stock > 0,
              ) ??
              false,
        )
        .toList();

    if (suggestions.length < suggestionCount) {
      final needed = suggestionCount - suggestions.length;

      final bestSellers = productsBestSelling
          .getBestSellingProducts(
            24,
          )
          .where(
            (p) =>
                p.itemProducts?.any(
                  (d) => d.stock > 0,
                ) ??
                false,
          )
          .where(
            (p) => !suggestions.any(
              (s) => s.id == p.id,
            ),
          )
          .take(needed)
          .toList();

      suggestions.addAll(
        bestSellers,
      );
    }

    return suggestions;
  }

// TODO(BRN): separar responsabilidades.
// PurchaseModel atualmente concentra:
// - model
// - persistência
// - recomendação
// - regra de negócio
}
