import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show ChangeNotifier;

class WhoWeAreManager extends ChangeNotifier {
  WhoWeAreManager({
    this.footerDescription,
    this.topDescription,
  }) {
    _subscribeToDescriptions();
  }

  bool _loading = false;

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  String? footerDescription = "";
  String? topDescription = "";

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void _subscribeToDescriptions() {
    firestore.collection("whoweare").doc("descriptions").snapshots().listen((DocumentSnapshot doc) {
      if (doc.exists) {
        footerDescription = doc["footerDescription"] as String?;
        topDescription = doc["topDescription"] as String?;
        notifyListeners();
      }
    });
  }

  Future<void> saveDescriptions() async {
    loading = true;

    final Map<String, dynamic> data = {
      "topDescription": topDescription,
      "footerDescription": footerDescription,
    };

    final DocumentReference docRef = firestore.collection("whoweare").doc("descriptions");

    await docRef.set(data);

    loading = false;
  }
}
