import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/models/section_item.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart'
    show ChangeNotifier, kDebugMode, kIsWeb;
import 'package:uuid/uuid.dart';

class Section extends ChangeNotifier {
  Section({this.id, this.name, this.type, this.items}) {
    items = items ?? [];
    originalItems = List.from(items!);
  }

  Section.fromDocument(DocumentSnapshot document) {
    try {
      id = document.id;
      name = document['name'] as String;
      type = document['type'] as String;
      items = (document['items'] as List<dynamic>)
          .map((i) => SectionItem.fromMap(i as Map<String, dynamic>))
          .toList();
    } catch (await) {
      return;
    }
  }

  String? id;
  String? name;
  String? type;
  List<SectionItem>? items;
  List<SectionItem>? originalItems;

  String? _error;

  String? get error => _error;

  set error(String? value) {
    _error = value;
    notifyListeners();
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  DocumentReference get firestoreRef => firestore.doc('home/$id');

  Reference get storageRef => storage.ref().child('home').child(id!);

  void addItem(SectionItem item) {
    items!.add(item);
    notifyListeners();
  }

  void removeItem(SectionItem item) {
    items!.remove(item);
    notifyListeners();
  }

  Future<void> saveSection(int position) async {
    final Map<String, dynamic> data = {
      'name': name,
      'type': type,
      'position': position
    };

    if (id == null) {
      final doc = await firestore.collection('home').add(data);
      id = doc.id;
    } else {
      await firestoreRef.update(data);
    }

    for (final item in items!) {
      if (kIsWeb) {
        final base64String = item.image.split(',').last;
        const String validCharacters =
            'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789+/=';
        final trimmedString =
            base64String.replaceAll(RegExp('[^$validCharacters]'), '');
        if (base64String is String &&
            base64String.isNotEmpty &&
            base64String.length % 4 == 0) {
          try {
            final List<int> bytes = base64.decode(trimmedString);
            final Uint8List uint8ListBytes = Uint8List.fromList(bytes);
            final metadata = SettableMetadata(contentType: 'image/jpeg');
            final task = storageRef
                .child(const Uuid().v4())
                .putData(uint8ListBytes, metadata);
            final snapshot = await task.whenComplete(() {});
            final url = await snapshot.ref.getDownloadURL();
            item.image = url;
          } catch (e) {
            if (kDebugMode) {
              print('Erro ao decodificar o base64String: $e');
            }
          }
        }
      } else if (item.image is File) {
        final UploadTask task =
            storageRef.child(const Uuid().v4()).putFile(item.image as File);
        final TaskSnapshot snapshot = await task.whenComplete(() {});
        final String url = await snapshot.ref.getDownloadURL();
        item.image = url;
      }
    }

    for (final original in originalItems!) {
      try {
        if (!items!.contains(original)) {
          final ref = storage.refFromURL(original.image as String);
          await ref.delete();
        }
        // ignore: empty_catches
      } catch (error) {}
    }

    final Map<String, dynamic> itemsData = {
      'items': items?.map((e) => e.toMap()).toList(),
    };
    await firestoreRef.update(itemsData);
  }

  Future<void> delete() async {
    await firestoreRef.delete();
    for (final item in items!) {
      try {
        final ref = storage.refFromURL(item.image as String);
        await ref.delete();
        // ignore: empty_catches
      } catch (error) {}
    }
  }

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

  Section clone() {
    return Section(
        id: id,
        name: name,
        type: type,
        items: items?.map((e) => e.clone()).toList());
  }

  @override
  String toString() {
    return 'Section{name: $name, type: $type, items: $items}';
  }
}
