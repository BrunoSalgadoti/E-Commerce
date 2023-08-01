import 'package:cloud_firestore/cloud_firestore.dart';

class OpeningStores {
  OpeningStores({
    this.monFri,
    this.saturday,
    this.monday,
  });

  OpeningStores.fromMap(DocumentSnapshot document) {
    monFri = document.get("monFri") as String? ?? "";
    saturday = document.get("saturday") as String? ?? "";
    monday = document.get("monday") as String? ?? "";
  }

  String? monFri;
  String? saturday;
  String? monday;

  Map<String, dynamic> toMap() {
    return {
      "monFri": monFri,
      "saturday": saturday,
      "monday": monday,
    };
  }
}
