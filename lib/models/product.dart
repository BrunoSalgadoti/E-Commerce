import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/models/details_products.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/foundation.dart' show kIsWeb, ChangeNotifier;
import 'dart:convert';
import 'dart:typed_data';

class Product extends ChangeNotifier {
  Product({
    this.id,
    this.name,
    this.description,
    this.images,
    this.itemProducts,
  }) {
    images = images ?? [];
    itemProducts = itemProducts ?? [];
  }

  bool _loading = false;

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Product.fromDocument(DocumentSnapshot document) {
    id = document.id;
    name = document['name'] as String;
    description = document['description'] as String;
    images = List<String>.from(document.get('images') as List<dynamic>);
    itemProducts = (document['details'] as List<dynamic>)
        .map((d) => DetailsProducts.fromMap(d as Map<String, dynamic>))
        .toList();
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  DocumentReference get firestoreRef => firestore.doc('products/$id');

  Reference get storageRef => storage.ref().child('products').child(id!);

  String? id;
  String? name;
  String? description;
  List<String>? images;
  List<dynamic>? newImages;
  List<DetailsProducts>? itemProducts;

  DetailsProducts? _selectedDetails;

  DetailsProducts? get selectedDetails => _selectedDetails;

  set selectedDetails(DetailsProducts? value) {
    _selectedDetails = value;
    notifyListeners();
  }

  int get totalStock {
    int stock = 0;
    for (final item in itemProducts!) {
      stock += item.stock;
    }
    notifyListeners();
    return stock;
  }

  bool get hasStock {
    return totalStock > 0;
  }

  num get basePrice {
    num lowest = double.infinity;
    for (final size in itemProducts!) {
      if (size.price! < lowest && size.hasStock) {
        lowest = size.price!;
      }
    }
    return lowest;
  }

  DetailsProducts? findSize(String name) {
    try {
      return itemProducts?.firstWhere((s) => s.size == name);
    } catch (error) {
      return null;
    }
  }

  List<Map<String, dynamic>>? exportDetailsList() {
    return itemProducts!.map((details) => details.toMap()).toList();
  }

  Future<void> saveProduct() async {
    loading = true;

    final Map<String, dynamic> data = {
      'name': name,
      'description': description,
      'details': exportDetailsList(),
    };

    if (id == null) {
      final doc = await firestore.collection('products').add(data);
      id = doc.id;
    } else {
      await firestoreRef.update(data);
    }

    final List<String> updateImages = [];
    for (final newImage in newImages!) {
      if (images!.contains(newImage)) {
        updateImages.add(newImage as String);
      } else {
        if (kIsWeb) {
          final List<int> bytes = base64.decode(newImage.split(',').last);
          final Uint8List uint8ListBytes = Uint8List.fromList(bytes);
          final metadata = SettableMetadata(contentType: 'image/jpeg');
          final task = storageRef
              .child(const Uuid().v4())
              .putData(uint8ListBytes, metadata);
          final snapshot = await task.whenComplete(() {});
          final url = await snapshot.ref.getDownloadURL();
          updateImages.add(url);
        } else {
          final UploadTask task =
              storageRef.child(const Uuid().v4()).putFile(newImage as File);
          final TaskSnapshot snapshot = await task.whenComplete(() {});
          final String url = await snapshot.ref.getDownloadURL();
          updateImages.add(url);
        }
      }
    }

    for (final image in images!) {
      try {
        if (!newImages!.contains(image)) {
          final ref = storage.refFromURL(image);
          await ref.delete();
        }
      } catch (error) {
        return;
      }
    }
    await firestoreRef.update({'images': updateImages});
    images = updateImages;

    loading = false;
  }

  Product clone() {
    return Product(
        id: id,
        name: name,
        description: description,
        images: List.from(images!),
        itemProducts: itemProducts?.map((items) => items.clone()).toList());
  }
}
