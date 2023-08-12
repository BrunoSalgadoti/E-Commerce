import 'dart:convert';
import 'dart:io';

import 'package:brn_ecommerce/helpers/extensions.dart';
import 'package:brn_ecommerce/models/address.dart';
import 'package:brn_ecommerce/models/opening_stores.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../common/formated_fields/format_values.dart';

enum StoreStatus { closed, open, closing }

class Stores extends ChangeNotifier {
  Stores({
    this.id,
    this.nameStore,
    this.emailStore,
    this.phoneNumberStore,
    this.imageStore,
    this.openingStores,
    this.address,
  });

  Stores.fromDocument(DocumentSnapshot document) {
    id = document.id;
    nameStore = document.get("nameStore") as String? ?? "";
    emailStore = document.get("emailStore") as String? ?? "";
    phoneNumberStore = document.get("phoneNumberStore") as String? ?? "";
    imageStore = document.get("imageStore") as String? ?? "";
    address = Address.fromMap(document.get("address") as Map<String, dynamic>);
    openingStores = OpeningStores.fromMap(
        document.get("openingStores") as Map<String, dynamic>);
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
    updateStatus();
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  Reference get storageRef => storage.ref().child("stores");

  Address? address;
  OpeningStores? openingStores;

  String? id;
  String? nameStore;
  String? emailStore;
  String? phoneNumberStore;
  dynamic imageStore;
  Map<String, Map<String, TimeOfDay>?>? openingStoresFromTimeOfDay;
  StoreStatus? status;

  String? get addressText => '${address?.street}, ${address?.number}'
      '${address?.complement?.isNotEmpty == true ? ' - ${address!.complement}' : ''} - '
      '${address?.district}, ${address?.city}/'
      '${address?.state} - ${formattedZipcode(address?.zipCode)}';

  String get openingText {
    return 'Seg-Sex: ${formattedPeriod(openingStoresFromTimeOfDay!["monFri"])}\n'
        'Sab: ${formattedPeriod(openingStoresFromTimeOfDay!["saturday"])}\n'
        'Dom: ${formattedPeriod(openingStoresFromTimeOfDay!["monday"])}';
  }

  String formattedPeriod(Map<String, TimeOfDay>? period) {
    if (period == null || period.isEmpty) return 'Fechada';
    return '${period["from"]?.formatted()} - ${period["to"]?.formatted()}';
  }

  Map<String, dynamic> toMap() {
    return {
      "nameStore": nameStore,
      "emailStore": emailStore,
      "phoneNumberStore": unFormatPhone(phoneNumberStore ?? ""),
      "imageStore": imageStore,
      "openingStores": openingStores?.toMap(),
      "address": address?.toMap(),
    };
  }

  Future<void> updateStore(String storeId, Stores store) async {
    try {
      final storeRef = firestore.collection("stores").doc(storeId);
      await storeRef.update(store.toMap());
      await updateStoreImage(imageStore, storeId);
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
    notifyListeners();
  }

  Future<void> saveStore(Stores store) async {
    try {
      final doc = firestore.collection("stores");
      await doc.add(store.toMap());
      store.id = doc.id;
      await updateStoreImage(imageStore, store.id);
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
    notifyListeners();
  }

  Future<void> deleteStore(Stores store, String? storeId) async {
    try {
      final firestoreRef = firestore.collection("stores").doc(storeId);

      if (store.imageStore != null &&
          store.imageStore is String &&
          store.imageStore!.contains("firebase")) {
        final storageRef = storage.refFromURL(store.imageStore!);
        await storageRef.delete();
      }

      await firestoreRef.delete();
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
    notifyListeners();
  }

  Future<void> updateStoreImage(dynamic image, [String? storeId]) async {
    // Start custom code tracing (TRACEPERFORMANCE)
    final trace = FirebasePerformance.instance.newTrace('update-store-image');
    await trace.start();

    if (imageStore != null && imageStore.contains("firebase")) {
      final oldImageRef = storage.refFromURL(imageStore);
      await oldImageRef.delete();
    }

    if (kIsWeb) {
      final base64String = image?.split(',').last;
      const String validCharacters =
          "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789+/=";
      final trimmedString =
          base64String?.replaceAll(RegExp("[^$validCharacters]"), "");
      if (base64String is String &&
          base64String.isNotEmpty &&
          base64String.length % 4 == 0) {
        try {
          final List<int> bytes = base64.decode(trimmedString!);
          final Uint8List uint8ListBytes = Uint8List.fromList(bytes);
          final metadata = SettableMetadata(contentType: "image/jpeg");
          final task = storageRef
              .child(const Uuid().v4())
              .putData(uint8ListBytes, metadata);
          final snapshot = await task.whenComplete(() {});
          final url = await snapshot.ref.getDownloadURL();
          image = url;
        } catch (e) {
          if (kDebugMode) {
            print('Erro ao decodificar o base64String: $e');
          }
        }
      }
    } else if (image is File) {
      final UploadTask task =
          storageRef.child(const Uuid().v4()).putFile(image);
      final TaskSnapshot snapshot = await task.whenComplete(() {});
      final String url = await snapshot.ref.getDownloadURL();
      image = url;
    }
    imageStore = image;
    notifyListeners();

    // Stop custom code trace
    await trace.stop();
  }

  void updateStatus() {
    final weekDay = DateTime.now().weekday;

    Map<String, TimeOfDay>? period;
    if (weekDay >= 1 && weekDay <= 5) {
      period = openingStoresFromTimeOfDay!["monFri"];
    } else if (weekDay == 6) {
      period = openingStoresFromTimeOfDay!["saturday"];
    } else {
      period = openingStoresFromTimeOfDay!["monday"];
    }
    final now = TimeOfDay.now();

    if (period == null) {
      status = StoreStatus.closed;
    } else if (period["from"]!.toMinutes() < now.toMinutes() &&
        period["to"]!.toMinutes() - 15 > now.toMinutes()) {
      status = StoreStatus.open;
    } else if (period["from"]!.toMinutes() < now.toMinutes() &&
        period["to"]!.toMinutes() > now.toMinutes()) {
      status = StoreStatus.closing;
    } else {
      status = StoreStatus.closed;
    }
  }

  String get statusText {
    switch (status) {
      case StoreStatus.closed:
        return 'Fechada';
      case StoreStatus.open:
        return 'Aberta';
      case StoreStatus.closing:
        return 'Fechando';
      default:
        return '';
    }
  }

  Color get colorsForStatus {
    switch (status) {
      case StoreStatus.closed:
        return Colors.red;
      case StoreStatus.open:
        return Colors.green;
      case StoreStatus.closing:
        return const Color.fromARGB(255, 210, 179, 7);
      default:
        return Colors.transparent;
    }
  }
}
