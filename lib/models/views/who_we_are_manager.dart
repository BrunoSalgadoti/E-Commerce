import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show ChangeNotifier;

/// # WhoWeAreManager (Folder: models/views)
///
/// Manages the descriptions for the "Who We Are" section in the application.
///
/// This class provides methods to subscribe to real-time updates of descriptions
/// and save changes to Firestore.
class WhoWeAreManager extends ChangeNotifier {
  // Proprieties

  String? footerDescription = "";
  String? topDescription = "";
  bool _loading = false;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Constructors

  /// Constructs a WhoWeAreManager instance with optional initial descriptions.
  WhoWeAreManager({
    this.footerDescription,
    this.topDescription,
  }) {
    _subscribeToDescriptions();
  }

  // Getters and Setters

  /// Returns true if the manager is in a loading state.
  bool get loading => _loading;

  /// Sets the loading state and notifies listeners of changes.
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  // Methods

  /// Subscribes to real-time updates of descriptions from Firestore.
  void _subscribeToDescriptions() {
    firestore.collection("whoweare").doc("descriptions").snapshots().listen((DocumentSnapshot doc) {
      if (doc.exists) {
        footerDescription = doc["footerDescription"] as String?;
        topDescription = doc["topDescription"] as String?;
        notifyListeners();
      }
    });
  }

  /// Saves the descriptions to Firestore.
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
