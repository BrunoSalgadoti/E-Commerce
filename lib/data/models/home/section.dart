import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:brn_ecommerce/core/firestore_service.dart';
import 'package:brn_ecommerce/core/monitoring/monitoring_logger.dart';
import 'package:brn_ecommerce/core/storage_service.dart';
import 'package:brn_ecommerce/data/models/home/section_item.dart';
import 'package:brn_ecommerce/services/development_monitoring/firebase_performance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show ChangeNotifier, kIsWeb, kDebugMode;
import 'package:uuid/uuid.dart';

class Section extends ChangeNotifier {
// =========================
// 🔧 CORE SERVICES
// =========================
  final FirestoreService _firestoreService = FirestoreService.instance;
  final StorageService _storageService = StorageService.instance;

  String? id;
  String? name;
  String? type;
  String? _error;
  int? position;
  List<SectionItem>? items;
  List<SectionItem>? originalItems;

  Section({this.id, this.name, this.type, this.items, this.position}) {
    items = items ?? [];
    originalItems = List.from(items!);
  }

  Section.fromDocument(DocumentSnapshot document) {
    try {
      id = document.id;
      name = document["name"] as String;
      type = document["type"] as String;
      position = document["position"] as int;

      items = (document["items"] as List<dynamic>)
          .map((i) => SectionItem.fromMap(i as Map<String, dynamic>))
          .toList();

      originalItems = List.from(items!);
    } catch (_) {
      return;
    }
  }

  String? get error => _error;

  set error(String? value) {
    _error = value;
    notifyListeners();
  }

  void addItem(SectionItem item) {
    items!.add(item);
    notifyListeners();
  }

  void removeItem(SectionItem item) {
    items!.remove(item);
    notifyListeners();
  }

  Future<void> saveSection(int position) async {
    PerformanceMonitoring().startTrace('save-section', shouldStart: true);

    final Map<String, dynamic> data = {
      "name": name,
      "type": type,
      "position": position,
    };

// =========================
// 🔥 FIRESTORE (CONTROLADO)
// =========================
    if (id == null) {
      final docId = await _firestoreService.addDocument(
        collection: "home",
        data: data,
      );
      id = docId;
    } else {
      await _firestoreService.updateDocument(
        collection: "home",
        docId: id!,
        data: data,
      );
    }

// =========================
// 🗂 STORAGE (UPLOAD)
// =========================
    for (final item in items!) {
      if (kIsWeb) {
        final base64String = item.image.split(',').last;

        const String validCharacters =
            "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789+/=";

        final trimmedString = base64String.replaceAll(RegExp("[^$validCharacters]"), "");

        if (trimmedString.isNotEmpty && trimmedString.length % 4 == 0) {
          try {
            final List<int> bytes = base64.decode(trimmedString);
            final Uint8List uint8ListBytes = Uint8List.fromList(bytes);

            item.image = await _storageService.uploadFile(
              path: "home/$id/${const Uuid().v4()}",
              file: uint8ListBytes,
              contentType: "image/jpeg",
            );
          } catch (e) {
            //TODO: tratar erro
            if (kDebugMode) print('Erro ao decodificar base64String: $e');
          }
        }
      } else if (item.image is File) {
        item.image = await _storageService.uploadFile(
          path: "home/$id/${const Uuid().v4()}",
          file: item.image as File,
        );
      }
    }

// =========================
// 🧹 CLEANUP STORAGE
// =========================
    for (final original in originalItems!) {
      try {
        if (!items!.contains(original) && (original.image as String).contains("firebase")) {
          await _storageService.deleteByUrl(original.image as String);
        }
      } catch (error) {
        //TODO: tratar erro
        MonitoringLogger().logError('Erro ao Salvar Seção: $error');
      }
    }

    final itemsData = {"items": items?.map((e) => e.toMap()).toList()};

    await _firestoreService.updateDocument(
      collection: "home",
      docId: id!,
      data: itemsData,
    );

    PerformanceMonitoring().stopTrace('save-section');
  }

  Future<void> delete() async {
    await _firestoreService.deleteDocument(
      collection: "home",
      docId: id!,
    );
    for (final item in items!) {
      if ((item.image as String).contains("firebase")) {
        try {
          await _storageService.deleteByUrl(item.image as String);
        } catch (_) {
          //TODO: tratar erro
        }
      }
    }
  }

  bool valid() {
    if (type == "BestSelling" || type == "RecentlyAdded") return true;

    if (name == null || name!.isEmpty) {
      error = 'Título Inválido';
    } else if (items!.isEmpty) {
      error = 'Insira ao menos uma imagem';
    } else {
      error = null;
    }

    return error == null;
  }

  Section clone() {
    return Section(
      id: id,
      name: name,
      type: type,
      position: position,
      items: items?.map((e) => e.clone()).toList(),
    );
  }

  @override
  String toString() => 'Section{name: $name, type: $type, items: $items}';
}
