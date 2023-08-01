import 'package:brn_ecommerce/models/address.dart';
import 'package:brn_ecommerce/models/opening_stores.dart';
import 'package:brn_ecommerce/models/stores.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class StoresManager extends ChangeNotifier {
  StoresManager([this.stores, this.address]) {
    _createStoresCollectionIfNotExists();
    _loadStoreList();
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stores? stores;
  Address? address;

  List<Stores> storesList = [];

  Future<void> _loadStoreList() async {
    final snapshot = await firestore.collection("stores").get();

    storesList = snapshot.docs.map((s) => Stores.fromDocument(s)).toList();
    notifyListeners();
  }

  Future<void> _createStoresCollectionIfNotExists() async {
    // Verifica se a coleção "stores" existe
    CollectionReference storesCollection = firestore.collection("stores");
    bool collectionExists = await storesCollection.limit(1).get().then(
          (querySnapshot) => querySnapshot.size > 0,
        );
    // Verifica se o documento existe
    if (!collectionExists) {
      // Create a new instance of OpeningStores and Address with the initial values
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
      // O documento não existe, então cria o documento na coleção "stores"
      // com os dados iniciais do fabricante do APP
      await storesCollection.doc(stores.id).set(stores.toMap());
    }
  }
}
