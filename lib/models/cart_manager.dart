import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/models/address.dart';
import 'package:ecommerce/models/cart_product.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/models/users.dart';
import 'package:ecommerce/models/users_manager.dart';
import 'package:ecommerce/models/viacep_adress.dart';
import 'package:ecommerce/services/cepaberto_service.dart';
import 'package:ecommerce/services/viacep_service.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class CartManager extends ChangeNotifier {
  List<CartProduct> items = [];
  Users? users;
  Address? address;
  num productsPrice = 0.0;
  num? deliveryPrice;

  num get totalPrice => productsPrice + (deliveryPrice ?? 0);

  bool _loading = false;

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void updateUser(UserManager userManager) {
    users = userManager.users;
    productsPrice = 0.0;
    items.clear();
    removeAddress();

    if (users != null) {
      _loadCartItems();
      _loadUserAddress();
    } else {
      users = null;
      notifyListeners();
    }
  }

  Future<void> _loadCartItems() async {
    final QuerySnapshot cartSnap = await users!.cartReference.get();

    items = cartSnap.docs
        .map((d) => CartProduct.fromDocument(d)..addListener(_onItemUpdate))
        .toList();
  }

  Future<void> _loadUserAddress() async {
    if(users?.address != null &&
        await calculateDelivery(users!.address!.lat!, users!.address!.long!)) {
      address = users!.address;
      notifyListeners();
    }

  }

  void addToCart(Product product) {
    try {
      final sameEntity = items.firstWhere((p) => p.stackable(product));
      sameEntity.increment();
    } catch (newCartProd) {
      final cartProduct = CartProduct.fromProduct(product);
      cartProduct.addListener(_onItemUpdate);
      items.add(cartProduct);
      users!.cartReference
          .add(cartProduct.toCartItemMap())
          .then((doc) => cartProduct.id = doc.id);
      _onItemUpdate();
    }
  }

  void removeOfCart(CartProduct cartProduct) {
    items.removeWhere((p) => p.id == cartProduct.id);
    users!.cartReference.doc(cartProduct.id).delete();
    cartProduct.removeListener(_onItemUpdate);
    notifyListeners();
  }

  void _onItemUpdate() {
    productsPrice = 0.0;

    for (int i = 0; i < items.length; i++) {
      final cartProduct = items[i];

      if (cartProduct.quantity == 0) {
        removeOfCart(cartProduct);
        i--;
        continue;
      }
      productsPrice += cartProduct.totalPrice;
      _updateCartProduct(cartProduct);
    }
    notifyListeners();
  }

  void _updateCartProduct(CartProduct cartProduct) {
    if (cartProduct.id != null) {
      users!.cartReference
          .doc(cartProduct.id)
          .update(cartProduct.toCartItemMap());
    }
  }

  bool get isCartValid {
    for (final cartProduct in items) {
      if (!cartProduct.hasStock) return false;
    }
    return true;
  }

  bool get isAddressValid => address != null && deliveryPrice != null;

  Future<void> getAddress(String cep) async {
    if (kIsWeb) {
      loading = true;
      final viaCepService = ViaCepService();

      try {
        final viaCepAddress = await viaCepService.getAddressFromZipCode(cep);

        // Obter a localização atual caso WEB
        final position = await LocationService.getCurrentLocation();
        final latitude = position.latitude;
        final longitude = position.longitude;

          address = Address(
            zipCode: viaCepAddress.cep,
            city: viaCepAddress.cidade,
            state: viaCepAddress.estado,
            street: viaCepAddress.logradouro,
            district: viaCepAddress.bairro,
            lat: latitude,
            long: longitude,
          );
        loading = false;
      } catch (error) {
        loading = false;
        return Future.error('CEP Inválido');
      }
    } else {
      loading = true;
      final cepAbertoService = CepAbertoService();

      try {
        final cepAbertoAddress =
            await cepAbertoService.getAddressFromZipCode(cep);

          address = Address(
            street: cepAbertoAddress.logradouro,
            district: cepAbertoAddress.bairro,
            zipCode: cepAbertoAddress.cep,
            city: cepAbertoAddress.cidade!.nome,
            state: cepAbertoAddress.estado!.sigla,
            lat: cepAbertoAddress.latitude,
            long: cepAbertoAddress.longitude,
          );
        loading = false;
      } catch (error) {
        loading = false;
        return Future.error('CEP Inválido');
      }
    }
  }

  Future<void> setAddress(Address address) async {
    loading = true;

    this.address = address;

    if(await calculateDelivery(address.lat!, address.long!)){
      users!.setAddress(address);
      loading = false;
    } else {
      loading = false;
      return Future.error('Endereço fora do raio de entrega :(');
    }
  }

  void removeAddress() {
    address = null;
    deliveryPrice = null;
    notifyListeners();
  }

  Future<bool> calculateDelivery(double lat, double long) async {
    final DocumentSnapshot doc = await firestore.doc('aux/delivery').get();

    final latStore = doc.get('lat') as double;
    final longStore = doc.get('long') as double;
    final basePriceDelivery = doc.get('baseprice') as num;
    final kmForDelivery = doc.get('km') as num;

    final maximumDeliveryDistance = doc.get('maxkm') as num;

    double distanceClient =
        Geolocator.distanceBetween(latStore, longStore, lat, long);

    //Convertendo a distância de M Para KM
    distanceClient /= 1000.0;

    if(distanceClient > maximumDeliveryDistance){
      return false;
    }
    deliveryPrice = basePriceDelivery + distanceClient * kmForDelivery;
    return true;
  }

}
