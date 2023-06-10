import 'package:brn_ecommerce/models/address.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  Users(
      {required this.email,
      this.password,
      this.userName,
      this.confirmPassword,
      this.id,
      this.favourite});

  Users.fromDocument(DocumentSnapshot document) {
    id = document.id;
    userName = document.get('name') as String;
    email = document.get('email') as String;
    favourite = document.get('favourite') as bool;

    Map<String, dynamic> dataMap = document.data() as Map<String, dynamic>;

    if (dataMap.containsKey('address')) {
      address =
          Address.fromMap(document.get('address') as Map<String, dynamic>);
    }
  }

  String? id;
  String? userName;
  String email = '';
  String? password;
  String? confirmPassword;

  bool? favourite;
  bool admin = false;

  Address? address;

  DocumentReference get firestoreRef =>
      FirebaseFirestore.instance.doc('users/$id');

  CollectionReference get cartReference => firestoreRef.collection('cart');

  Future<void> saveData() async {
    await firestoreRef.set(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'name': userName,
      'email': email,
      'favourite': favourite = false,
      if (address != null) 'address': address!.toMap(),
    };
  }

  void setAddress(Address address) {
    this.address = address;
    saveData();
  }
}
