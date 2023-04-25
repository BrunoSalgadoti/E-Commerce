import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/models/section.dart';
import 'package:flutter/cupertino.dart';

class HomeManager extends ChangeNotifier {
  HomeManager() {
    _loadSections();
  }

  List<Section> sections = [];

  bool editing = false;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> _loadSections() async {
    firestore.collection('home').snapshots().listen((snapshot) {
      sections.clear();
      for (final DocumentSnapshot document in snapshot.docs) {
        sections.add(Section.fromDocument(document));
      }
      notifyListeners();
    });
  }

  void enterEditing() {
    editing = true;
    notifyListeners();
  }

  void saveEditing() {
    editing = false;
    notifyListeners();
  }

  void discardEditing() {
    editing = false;
    notifyListeners();
  }
}