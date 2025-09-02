import 'package:brn_ecommerce/models/locations_services/address.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// # Users (Folder: models/users)
///
/// A class representing user information, including ID, username, email, password, phone number, and address.
///
/// This class contains properties and methods related to user data management.
class Users {
  // Proprieties

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

  // Properties for Firestore references
  DocumentReference get firestoreRef => FirebaseFirestore.instance.doc("users/$id");

  CollectionReference get cartReference => firestoreRef.collection("cart");

  // Constructors

  /// Initializes a [Users] instance with the specified parameters.
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

  /// Creates a [Users] instance from a Firestore document snapshot.
  Users.fromDocument(DocumentSnapshot document) {
    id = document.id;
    userName = document.get("name") as String;
    email = document.get("email") as String;
    favourite = document.get("favourite") as bool;
    phoneNumber = document.get("phone") as String? ?? "";
    userPhotoURL = document.get("userPhoto") as String? ?? "";
    policyAndTerms = document.get("policyAndTerms") as bool? ?? false;

    Map<String, dynamic> dataMap = document.data() as Map<String, dynamic>;

    favoriteProductIds = List<String>.from(dataMap["favorites"] ?? []);
    wishlistProductIds = List<String>.from(dataMap["wishlist"] ?? []);

    if (dataMap.containsKey("address")) {
      address = Address.fromMap(document.get("address") as Map<String, dynamic>);
    }
  }

  // Methods

  /// Converts user data to a map for Firestore storage.
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

  /// Saves user data to Firestore.
  Future<void> saveUserData() async {
    await firestoreRef.set(toMap());
  }

  /// Updates user data in Firestore.
  Future<void> updateUserData() async {
    await firestoreRef.update(toMap());
  }

  /// Sets the user's address and saves the updated user data to Firestore.
  void setAddress(Address address) {
    this.address = address;
    saveUserData();
  }
}
