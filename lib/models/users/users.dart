import 'package:brn_ecommerce/core/firestore_service.dart';
import 'package:brn_ecommerce/core/getters/core_getters_service.dart';
import 'package:brn_ecommerce/data/models/location/address.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
// =========================
// 🔧 CORE
// =========================
  final FirestoreService _firestoreService = FirestoreService.instance;
  final CoreGettersService _getters = CoreGettersService.instance;

// =========================
// 📦 DATA
// =========================
  String? id;
  String? userName;
  String email = "";
  String? password;
  String? confirmPassword;
  String? phoneNumber;
  String? userPhotoURL = "";
  bool? favourite;
  bool? policyAndTerms;
  bool admin = false;
  Address? address;
  List<String> favoriteProductIds = [];
  List<String> wishlistProductIds = [];

// =========================
// 🔥 GETTERS (CORE)
// =========================

// 🔁 MESMO NOME (compatibilidade total)
  DocumentReference get firestoreRef => _getters.getDocumentRef(
        collection: "users",
        docId: id!,
      );

// 🔁 MESMO NOME (compatibilidade total)
  CollectionReference get cartReference => _getters.getCollectionRef(
        path: "users/$id/cart",
      );

// =========================
// 🏗 CONSTRUCTORS
// =========================
  Users({
    this.id,
    this.userName,
    required this.email,
    this.favourite,
    this.phoneNumber,
    this.userPhotoURL,
    this.policyAndTerms,
    this.password,
    this.confirmPassword,
  });

  Users.fromDocument(DocumentSnapshot document) {
    id = document.id;
    userName = document.get("name") as String;
    email = document.get("email") as String;
    favourite = document.get("favourite") as bool;
    phoneNumber = document.get("phone") as String? ?? "";
    userPhotoURL = document.get("userPhoto") as String? ?? "";
    policyAndTerms = document.get("policyAndTerms") as bool? ?? false;

    final Map<String, dynamic> dataMap = document.data() as Map<String, dynamic>;

    favoriteProductIds = List<String>.from(dataMap["favorites"] ?? []);
    wishlistProductIds = List<String>.from(dataMap["wishlist"] ?? []);

    if (dataMap.containsKey("address")) {
      address = Address.fromMap(
        document.get("address") as Map<String, dynamic>,
      );
    }
  }

// =========================
// 🔁 MAP
// =========================
  Map<String, dynamic> toMap() {
    return {
      "name": userName,
      "email": email,
      "favourite": favourite = false,
      "phone": phoneNumber,
      "userPhoto": userPhotoURL ?? "",
      "policyAndTerms": policyAndTerms ?? false,
      "favorites": favoriteProductIds,
      "wishlist": wishlistProductIds,
      if (address != null) "address": address!.toMap(),
    };
  }

// =========================
// 🔥 FIRESTORE (CORE)
// =========================

  Future<void> saveUserData() async {
    await _firestoreService.setDocument(
      collection: "users",
      docId: id!,
      data: toMap(),
    );
  }

  Future<void> updateUserData() async {
    await _firestoreService.updateDocument(
      collection: "users",
      docId: id!,
      data: toMap(),
    );
  }

  void setAddress(Address address) {
    this.address = address;
    saveUserData(); // 🔁 mantido
  }
}
