import 'package:brn_ecommerce/models/address.dart';
import 'package:brn_ecommerce/models/opening_stores.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Stores {
  Stores({
    this.id,
    this.nameStore,
    this.emailStore,
    this.phoneNumberStore,
    this.imageStoreURL,
    this.openingStores,
    this.address,
  }) {
    openingStores = openingStores;
    address = address;
  }

  Stores.fromDocument(DocumentSnapshot document) {
    id = document.id;
    nameStore = document.get("nameStore") as String? ?? "";
    emailStore = document.get("emailStore") as String? ?? "";
    phoneNumberStore = document.get("phoneNumberStore") as String? ?? "";
    imageStoreURL = document.get("imageStoreURL") as String? ?? "";
    address = Address.fromMap(document.get("address") as Map<String, dynamic>);
    openingStoresFromTimeOfDay =
        (document.get("openingStores") as Map<String, dynamic>)
            .map((key, value) {
      final timesString = value as String;

      if (timesString.isNotEmpty) {
        final splitted = timesString.split(RegExp(r"[:-]"));

        return MapEntry(key, {
          "from": TimeOfDay(
            hour: int.parse(splitted[0]),
            minute: int.parse(splitted[1]),
          ),
          "to": TimeOfDay(
            hour: int.parse(splitted[2]),
            minute: int.parse(splitted[3]),
          ),
        });
      } else {
        return MapEntry(key, null);
      }
    });
  }

  Address? address;
  OpeningStores? openingStores;

  String? id;
  String? nameStore;
  String? emailStore;
  String? phoneNumberStore;
  String? imageStoreURL;
  Map<String, dynamic>? openingStoresFromTimeOfDay;

  Map<String, dynamic> toMap() {
    return {
      "nameStore": nameStore,
      "emailStore": emailStore,
      "phoneNumberStore": phoneNumberStore,
      "imageStoreURL": imageStoreURL,
      "openingStores": openingStores?.toMap(),
      "address": address?.toMap(),
    };
  }
}
