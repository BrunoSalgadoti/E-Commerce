import 'package:cloud_firestore/cloud_firestore.dart';

class Users {

  Users({required this.email, required this.password, this.userName,
          this.confirmPassword, this.id, this.storeName});

  Users.fromDocument(DocumentSnapshot document){
    id = document.id;
    userName = document.get('name');
    email = document.get('email');
  }

  String? id;
  String? userName;
  String? storeName;
  String email = '';
  String password = '';

  String? confirmPassword;

  DocumentReference get firestoreRef =>
  FirebaseFirestore.instance.doc('users/$id');

  Future<void> saveData() async {
    await firestoreRef.set(toMap());
  }

  Map<String, dynamic> toMap(){
    return{
      'name': userName,
      'email': email,
    };
  }

}