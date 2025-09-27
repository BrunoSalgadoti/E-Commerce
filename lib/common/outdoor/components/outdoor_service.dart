import 'dart:io';

import 'package:brn_ecommerce/common/outdoor/components/outdoor_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class OutdoorService {
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  CollectionReference get _outdoorRef => _firestore.collection('outdoors');

  // Busca todos os outdoors
  Future<List<OutdoorItem>> fetchOutdoors() async {
    final snapshot = await _outdoorRef.get();
    return snapshot.docs
        .map((doc) => OutdoorItem.fromMap(doc.id, doc.data() as Map<String, dynamic>))
        .toList();
  }

  // Adiciona outdoor ao Firestore
  Future<void> addOutdoor(OutdoorItem item) async {
    await _outdoorRef.add(item.toMap());
  }

  // Deleta outdoor
  Future<void> deleteOutdoor(OutdoorItem item) async {
    await _outdoorRef.doc(item.id).delete();
  }

  // Upload de imagem e retorna o OutdoorItem com URL do Firebase Storage
  Future<OutdoorItem?> uploadImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result == null) return null;

    final file = File(result.files.single.path!);
    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final ref = _storage.ref().child('outdoors/$fileName.jpg');
    await ref.putFile(file);
    final url = await ref.getDownloadURL();

    final newItem = OutdoorItem(id: '', url: url, type: OutdoorType.image);
    await addOutdoor(newItem);
    return newItem;
  }

  // Adiciona link de YouTube ao Firestore
  Future<void> addYoutubeLink(String youtubeUrl) async {
    final newItem = OutdoorItem(id: '', url: youtubeUrl, type: OutdoorType.youtube);
    await addOutdoor(newItem);
  }

  // Adiciona asset local como outdoor
  Future<void> addAsset(String assetPath) async {
    final newItem = OutdoorItem(id: '', url: assetPath, type: OutdoorType.asset);
    await addOutdoor(newItem);
  }
}
