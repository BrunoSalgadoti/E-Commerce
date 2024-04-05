import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:brn_ecommerce/models/views/section_item.dart';
import 'package:brn_ecommerce/services/development_monitoring/firebase_performance.dart';
import 'package:brn_ecommerce/services/development_monitoring/monitoring_logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart' show ChangeNotifier, kIsWeb, kDebugMode;
import 'package:uuid/uuid.dart';

/// # Section (Folder: models/views)
///
/// A class representing a section in the application.
///
/// This class represents a section in an application, with methods for adding and removing items,
/// saving the section, deleting the section, validating the section, and cloning the section.
class Section extends ChangeNotifier {
  // Proprieties

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  String? id;
  String? name;
  String? type;
  String? _error;
  int? position;
  List<SectionItem>? items;
  List<SectionItem>? originalItems;

  // Constructors

  Section({this.id, this.name, this.type, this.items, this.position}) {
    items = items ?? [];
    originalItems = List.from(items!);
  }

  /// Constructor from Firestore Document
  Section.fromDocument(DocumentSnapshot document) {
    try {
      id = document.id;
      name = document["name"] as String;
      type = document["type"] as String;
      position = document["position"] as int;
      items = (document["items"] as List<dynamic>)
          .map((i) => SectionItem.fromMap(i as Map<String, dynamic>))
          .toList();
    } catch (await) {
      return;
    }
  }

  /// Getter for Firestore Document Reference
  DocumentReference get firestoreRef => firestore.doc("home/$id");

  /// Getter for Firebase Storage Reference
  Reference get storageRef => storage.ref().child("home").child(id!);

  /// Getter for error message
  String? get error => _error;

  /// Setter for error message
  set error(String? value) {
    _error = value;
    notifyListeners();
  }

  // Methods

  /// Add an item to the section
  void addItem(SectionItem item) {
    items!.add(item);
    notifyListeners();
  }

  /// to remove an item from the section
  void removeItem(SectionItem item) {
    items!.remove(item);
    notifyListeners();
  }

  /// to save the section to Firestore
  Future<void> saveSection(int position) async {
    PerformanceMonitoring().startTrace('save-section', shouldStart: true);

    final Map<String, dynamic> data = {
      "name": name,
      "type": type,
      "position": position,
    };

    if (id == null) {
      final doc = await firestore.collection("home").add(data);
      id = doc.id;
    } else {
      await firestoreRef.update(data);
    }

    for (final item in items!) {
      if (kIsWeb) {
        final base64String = item.image.split(',').last;
        const String validCharacters =
            "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789+/=";
        final trimmedString = base64String.replaceAll(RegExp("[^$validCharacters]"), "");
        if (base64String is String && base64String.isNotEmpty && base64String.length % 4 == 0) {
          try {
            final List<int> bytes = base64.decode(trimmedString);
            final Uint8List uint8ListBytes = Uint8List.fromList(bytes);
            final metadata = SettableMetadata(contentType: "image/jpeg");
            final task = storageRef.child(const Uuid().v4()).putData(uint8ListBytes, metadata);
            final snapshot = await task.whenComplete(() {});
            final url = await snapshot.ref.getDownloadURL();
            item.image = url;
          } catch (e) {
            if (kDebugMode) {
              //TODO: tratar erro
              print('Erro ao decodificar o base64String: $e');
            }
          }
        }
      } else if (item.image is File) {
        final UploadTask task = storageRef.child(const Uuid().v4()).putFile(item.image as File);
        final TaskSnapshot snapshot = await task.whenComplete(() {});
        final String url = await snapshot.ref.getDownloadURL();
        item.image = url;
      }
    }

    for (final original in originalItems!) {
      try {
        if (!items!.contains(original) && (original.image as String).contains("firebase")) {
          final ref = storage.refFromURL(original.image as String);
          await ref.delete();
        }
      } catch (error) {
        //TODO: tratar erro
        MonitoringLogger().logError('Erro ao Salvar Seção: $error');
      }
    }

    final Map<String, dynamic> itemsData = {
      "items": items?.map((e) => e.toMap()).toList(),
    };
    await firestoreRef.update(itemsData);

    PerformanceMonitoring().stopTrace('save-section');
  }

  /// To delete the section from Firestore
  Future<void> delete() async {
    await firestoreRef.delete();
    for (final item in items!) {
      if ((item.image as String).contains("firebase")) {
        try {
          final ref = storage.refFromURL(item.image as String);
          await ref.delete();
          // ignore: empty_catches
        } catch (error) {
          //TODO: tratar erro
        }
      }
    }
  }

  /// Method to check if the section is valid
  bool valid() {
    if (name == null || name!.isEmpty) {
      error = 'Título Inválido';
    } else if (items!.isEmpty) {
      error = 'Insira ao menos uma imagem';
    } else {
      error = null;
    }
    return error == null;
  }

  /// Method to clone the section
  Section clone() {
    return Section(
        id: id,
        name: name,
        type: type,
        position: position,
        items: items?.map((e) => e.clone()).toList());
  }

  @override
  String toString() {
    return 'Section{name: $name, type: $type, items: $items}';
  }
}
