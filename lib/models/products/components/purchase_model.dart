import 'package:brn_ecommerce/models/products/components/products_best_selling.dart';
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

  factory PurchaseModel.fromMap(Map<String, dynamic> map) {
    return PurchaseModel(
      userId: map['userId'] ?? '',
      items: List<String>.from(map['items'] ?? []),
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  /// Saves a purchase within aux/purchases/items centralizing by user
  static Future<void> savePurchase(PurchaseModel purchase) async {
    final docRef = FirebaseFirestore.instance.collection('aux').doc('purchases');
    await docRef.set({}, SetOptions(merge: true));

    final userDocRef = docRef.collection('items').doc(purchase.userId);
    final snapshot = await userDocRef.get();

    if (snapshot.exists) {
      await userDocRef.update({
        'items': FieldValue.arrayUnion(purchase.items),
        'updatedAt': DateTime.now(),
      });
    } else {
      await userDocRef.set({
        'userId': purchase.userId,
        'items': purchase.items,
        'createdAt': DateTime.now(),
        'updatedAt': DateTime.now(),
      });
    }
  }

  /// Returns all product IDs that the user has already purchased
  static Future<List<String>> getUserPurchasedItems(String userId) async {
    final docRef = FirebaseFirestore.instance
        .collection('aux')
        .doc('purchases')
        .collection('items')
        .doc(userId);

    final snapshot = await docRef.get();
    if (!snapshot.exists) return [];

    final data = snapshot.data();
    final List<dynamic> items = data?['items'] ?? [];
    return items.cast<String>();
  }

  /// Returns suggested products (X/X) based on other users' purchases + best sellers
  static Future<List<Product>> getPurchaseSuggestions({
    required String userId,
    required List<Product> allProducts,
    int suggestionCount = 24,
  }) async {
    final firestore = FirebaseFirestore.instance;

    final userItems = await getUserPurchasedItems(userId);

    final productsBestSelling = ProductsBestSelling(
      allProducts: allProducts,
      salesThreshold: 24,
    );

    // User never purchased → get best sellers
    if (userItems.isEmpty) {
      return productsBestSelling.getBestSellingProducts(suggestionCount);
    }

    // Search for products from other users who have purchased similar items
    final snapshot = await firestore
        .collection("aux")
        .doc("purchases")
        .collection("items")
        .where("items", arrayContainsAny: userItems)
        .get();

    final relatedItems = <String>{};

    for (final doc in snapshot.docs) {
      final otherUserId = doc["userId"];
      if (otherUserId == userId) continue;
      final List<dynamic> items = doc["items"] ?? [];
      relatedItems.addAll(items.cast<String>());
    }

    relatedItems.removeWhere((id) => userItems.contains(id));

    List<Product> suggestions = [];
    if (relatedItems.isNotEmpty) {
      final prodsSnap = await firestore
          .collection("products")
          .where(FieldPath.documentId, whereIn: relatedItems.toList())
          .get();
      suggestions = prodsSnap.docs.map((d) => Product.fromDocument(d)).toList();
    }

    // Filter stock > 0
    suggestions =
        suggestions.where((p) => p.itemProducts?.any((d) => d.stock > 0) ?? false).toList();

    // Complete with best sellers if necessary
    if (suggestions.length < suggestionCount) {
      final needed = suggestionCount - suggestions.length;
      final bestSellers = productsBestSelling
          .getBestSellingProducts(24)
          .where((p) => p.itemProducts?.any((d) => d.stock > 0) ?? false)
          .where((p) => !suggestions.any((s) => s.id == p.id))
          .take(needed)
          .toList();
      suggestions.addAll(bestSellers);
    }

    return suggestions;
  }
}
