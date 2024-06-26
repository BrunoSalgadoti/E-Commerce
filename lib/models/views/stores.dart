import 'dart:convert';
import 'dart:io';

import 'package:brn_ecommerce/helpers/extensions.dart';
import 'package:brn_ecommerce/models/locations_services/address.dart';
import 'package:brn_ecommerce/models/views/opening_stores.dart';
import 'package:brn_ecommerce/services/development_monitoring/firebase_performance.dart';
import 'package:brn_ecommerce/services/development_monitoring/monitoring_logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../common/formatted_fields/format_values.dart';

/// Enumeration that represents the status of the store.
enum StoreStatus { closed, open, closing }

/// # Stores (Folder: models/views)
///
/// Class that represents an unity of the store.
class Stores extends ChangeNotifier {
  // Proprieties

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  String? id;
  String? nameStore;
  String? emailStore;
  String? phoneNumberStore;
  dynamic imageStore;
  Map<String, Map<String, TimeOfDay>?>? openingStoresFromTimeOfDay;
  Address? address;
  OpeningStores? openingStores;
  StoreStatus? status;

  //Constructors

  /// Constructor for the Stores class.
  Stores({
    this.id,
    this.nameStore,
    this.emailStore,
    this.phoneNumberStore,
    this.imageStore,
    this.openingStores,
    this.address,
  });

  /// Constructor from a DocumentSnapshot.
  Stores.fromDocument(DocumentSnapshot document) {
    PerformanceMonitoring().startTrace('stores-from-document', shouldStart: true);
    if (kDebugMode) {
      MonitoringLogger().logInfo('Instance beginning Stores.fromDocument');
    }

    // Assigning values from DocumentSnapshot
    id = document.id;
    nameStore = document.get("nameStore") as String? ?? "";
    emailStore = document.get("emailStore") as String? ?? "";
    phoneNumberStore = document.get("phoneNumberStore") as String? ?? "";
    imageStore = document.get("imageStore") as String? ?? "";
    address = Address.fromMap(document.get("address") as Map<String, dynamic>);
    openingStores = OpeningStores.fromMap(document.get("openingStores") as Map<String, dynamic>);
    openingStoresFromTimeOfDay =
        (document.get("openingStores") as Map<String, dynamic>).map((key, value) {
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
    PerformanceMonitoring().stopTrace('stores-from-document');
  }

  //Getters

  /// Reference for store storage.
  Reference get storageRef => storage.ref().child("stores");

  /// Formatted address text.
  String? get addressText => '${address?.street}, ${address?.number}'
      '${address?.complement?.isNotEmpty == true ? ' - ${address!.complement}' : ''} - '
      '${address?.district}, ${address?.city}/'
      '${address?.state} - ${formattedZipcode(address?.zipCode)}';

  /// Text of opening hours.
  String get openingText {
    // Cálculo do texto do horário de funcionamento
    return 'Seg-Sex: ${formattedPeriod(openingStoresFromTimeOfDay!["monFri"])}\n'
        'Sab: ${formattedPeriod(openingStoresFromTimeOfDay!["saturday"])}\n'
        'Dom: ${formattedPeriod(openingStoresFromTimeOfDay!["monday"])}';
  }

  /// Store status text.
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

  /// Colors associated with the store status.
  Color get colorsForOpenStore {
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

  // Methods

  // Converts the store to a Map.
  Map<String, dynamic> toMap() {
    return {
      "nameStore": nameStore,
      "emailStore": emailStore,
      "phoneNumberStore": unFormatPhone(phoneNumberStore ?? ""),
      "imageStore": imageStore ?? "",
      "openingStores": openingStores?.toMap(),
      "address": address?.toMap(),
    };
  }

  /// Formats the time period.
  String formattedPeriod(Map<String, TimeOfDay>? period) {
    if (period == null || period.isEmpty) return 'Fechada';
    return '${period["from"]?.formatted()} - ${period["to"]?.formatted()}';
  }

  /// Updates the store in the database.
  Future<void> updateStore(String storeId, Stores store) async {
    try {
      final storeRef = firestore.collection("stores").doc(storeId);
      await storeRef.update(store.toMap());
      await updateStoreImage(imageStore, storeId);
    } catch (error) {
      if (kDebugMode) {
        //TODO: Tratar erro
        print(error);
      }
    }
    notifyListeners();
  }

  /// Saves the store in the database.
  Future<void> saveStore(Stores store) async {
    PerformanceMonitoring().startTrace('save-store', shouldStart: true);
    if (kDebugMode) {
      MonitoringLogger().logInfo('Save file upload to Firebase Storage');
    }

    try {
      final doc = firestore.collection("stores");
      await doc.add(store.toMap());
      store.id = doc.id;
      await updateStoreImage(imageStore, store.id);
    } catch (error) {
      if (kDebugMode) {
        //TODO: Tratar erro
        print(error);
      }
    }
    notifyListeners();

    PerformanceMonitoring().stopTrace('save-store');
    if (kDebugMode) {
      MonitoringLogger().logInfo('File saved completed');
    }
  }

  /// Deletes the store from the database.
  Future<void> deleteStore(Stores store, String? storeId) async {
    if (kDebugMode) {
      MonitoringLogger().logInfo('Starting file delete to Firebase Storage');
    }

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
        //TODO: Tratar erro
        print(error);
      }
    }
    notifyListeners();
  }

  /// Updates the store image.
  Future<void> updateStoreImage(dynamic image, [String? storeId]) async {
    PerformanceMonitoring().startTrace('update-store-image', shouldStart: true);
    if (kDebugMode) {
      MonitoringLogger().logInfo('Starting file upload to Firebase Storage');
    }

    if (imageStore != null && imageStore.contains("firebase")) {
      final oldImageRef = storage.refFromURL(imageStore);
      await oldImageRef.delete();
    }

    if (kIsWeb) {
      final base64String = image?.split(',').last;
      const String validCharacters =
          "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789+/=";
      final trimmedString = base64String?.replaceAll(RegExp("[^$validCharacters]"), "");
      if (base64String is String && base64String.isNotEmpty && base64String.length % 4 == 0) {
        try {
          final List<int> bytes = base64.decode(trimmedString!);
          final Uint8List uint8ListBytes = Uint8List.fromList(bytes);
          final metadata = SettableMetadata(contentType: "image/jpeg");
          final task = storageRef.child(const Uuid().v4()).putData(uint8ListBytes, metadata);
          final snapshot = await task.whenComplete(() {});
          final url = await snapshot.ref.getDownloadURL();
          image = url;
        } catch (e) {
          if (kDebugMode) {
            //TODO: Tratar erro
            print('Erro ao decodificar o base64String: $e');
          }
        }
      }
    } else if (image is File) {
      final UploadTask task = storageRef.child(const Uuid().v4()).putFile(image);
      final TaskSnapshot snapshot = await task.whenComplete(() {});
      final String url = await snapshot.ref.getDownloadURL();
      image = url;
    }
    imageStore = image;
    notifyListeners();

    PerformanceMonitoring().stopTrace('update-store-image');
  }

  /// Updates the store status.
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
}
