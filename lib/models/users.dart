import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  Users({required this.email, this.password,this.userName,
    this.confirmPassword, this.id, this.storeName});

  Users.fromDocument(DocumentSnapshot document) {
    id = document.id;
    userName = document.get('name') as String;
    email = document.get('email') as String;
  }

  String? id;
  String? userName;
  String? storeName;
  String email = '';
  String? password;
  String? confirmPassword;

  bool favourite = false;
  bool admin = false;

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
    };
  }
}
