import 'dart:async';

import 'package:brn_ecommerce/models/address.dart';
import 'package:brn_ecommerce/models/opening_stores.dart';
import 'package:brn_ecommerce/models/stores.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class StoresManager extends ChangeNotifier {
  StoresManager([this.stores, this.address]) {
    _createStoresCollectionIfNotExists();
    _loadStoreList();
    _startTime();
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stores? stores;
  Address? address;
  Timer? _timer;

  List<Stores> storesList = [];

  Future<void> _loadStoreList() async {
    final snapshot = await firestore.collection("stores").get();

    storesList = snapshot.docs.map((s) => Stores.fromDocument(s)).toList();
    notifyListeners();
  }

  void _startTime() {
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      _checkOpening();
    });
  }

  void _checkOpening() {
    for (final store in storesList) {
      store.updateStatus();
      notifyListeners();
    }
  }

  void updateStore(Stores stores) {
    notifyListeners();
  }

  void saveStore(Stores stores) {
    notifyListeners();
  }

  void deleteStore(Stores stores) async {
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  Future<void> _createStoresCollectionIfNotExists() async {
    // Checks if the "stores" collection exists
    CollectionReference storesCollection = firestore.collection("stores");
    bool collectionExists = await storesCollection.limit(1).get().then(
          (querySnapshot) => querySnapshot.size > 0,
        );
    // Verifica se o documento existe
    if (!collectionExists) {
      // Create a new instance of OpeningStores and Address
      // with the initial values
      Address initialAddressStores = Address(
        street: "Rua: X",
        number: "Nº 00",
        complement: "",
        district: "Alves de Souza",
        zipCode: "48608510",
        city: "Paulo Afonso",
        state: "BA",
        lat: -9.4001,
        long: -38.2176,
      );
      OpeningStores initialOpeningStores = OpeningStores(
        monFri: "8:00-18:00",
        saturday: "8:00-12:00",
        monday: "",
      );
      Stores? stores = Stores(
        nameStore: "Loja Virtual BRN Info_Dev",
        emailStore: "brunosalgadoti@gmail.com",
        phoneNumberStore: "(82) 99984-5889",
        openingStores: initialOpeningStores,
        address: initialAddressStores,
      );
      // The document does not exist, so create the document in the "stores"
      // collection with the initial data of the APP manufacturer
      await storesCollection.doc(stores.id).set(stores.toMap());
    }
  }
}
