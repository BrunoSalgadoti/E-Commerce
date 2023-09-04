import 'package:brn_ecommerce/models/address.dart';
import 'package:brn_ecommerce/models/cart_product.dart';
import 'package:brn_ecommerce/models/chearch_cep/viacep_adress.dart';
import 'package:brn_ecommerce/models/delivery.dart';
import 'package:brn_ecommerce/models/details_products.dart';
import 'package:brn_ecommerce/models/product.dart';
import 'package:brn_ecommerce/models/users.dart';
import 'package:brn_ecommerce/models/users_manager.dart';
import 'package:brn_ecommerce/services/cepaberto_service.dart';
import 'package:brn_ecommerce/services/development_monitoring/monitoring_logger.dart';
import 'package:brn_ecommerce/services/viacep_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class CartManager extends ChangeNotifier {
  List<CartProduct> items = [];
  Users? users;
  Address? address;
  Delivery? delivery;
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
    if (!kReleaseMode) {
      MonitoringLogger().logInfo('Info message: Start Load User Cart');
    }

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
    if (!kReleaseMode) {
      MonitoringLogger().logInfo('Info message: Start Load Cart Items');
    }

    final QuerySnapshot cartSnap = await users!.cartReference.get();

    items = cartSnap.docs
        .map((d) => CartProduct.fromDocument(d)..addListener(_onItemUpdate))
        .toList();
    notifyListeners();
  }

  Future<void> _loadUserAddress() async {
    if (!kReleaseMode) {
      MonitoringLogger().logInfo('Info message: Start Load Cart Address');
    }

    if (users?.address != null &&
        await calculateDelivery(users!.address!.lat!, users!.address!.long!)) {
      address = users!.address;
      notifyListeners();
    }
  }

  void addToCart(Product product, DetailsProducts detailsProducts) {
    if (!kReleaseMode) {
      MonitoringLogger().logInfo('Info message: Add to Cart');
    }

    try {
      final sameEntity = items.firstWhere((p) => p.stackableSize(product));
      sameEntity.increment();
    } catch (newCartProd) {
      final cartProduct = CartProduct.fromProduct(product, detailsProducts);
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

  void clearCart() {
    for (final cartProduct in items) {
      users!.cartReference.doc(cartProduct.id).delete();
    }
    items.clear();
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
      users!.firestoreRef.update({"favourite": true});
    }

    hasFreeShippingProduct;
    if (hasFreeShippingProduct) {
      calculateDelivery(
          users?.address?.lat ?? 0.00, users?.address?.long ?? 0.00);
    }
    notifyListeners();
  }

  bool get isCartValid {
    for (final cartProduct in items) {
      if (!cartProduct.hasStock || !cartProduct.hasAmount) return false;
    }
    return true;
  }

  bool get hasFreeShippingProduct {
    return items.any((product) => product.freight == true);
  }

  bool get isAddressValid => address != null && deliveryPrice != null;

  num get totalQuantity {
    num quantity = 0;
    for (final item in items) {
      quantity += item.quantity ?? 0;
    }
    return quantity;
  }

  Future<void> getAddress(String cep) async {
    if (!kReleaseMode) {
      MonitoringLogger().logInfo('Info message: Start Load Get Address Cart');
    }

    if (kIsWeb) {
      loading = true;
      final viaCepService = ViaCepService();

      try {
        final viaCepAddress = await viaCepService.getAddressFromZipCode(cep);

        // Get current location if WEB
        final position = await LocationService.getCurrentLocation();
        final latitude = position.latitude;
        final longitude = position.longitude;

        address = Address(
          zipCode: viaCepAddress.cep,
          city: viaCepAddress.city,
          state: viaCepAddress.state,
          street: viaCepAddress.streetAddress,
          district: viaCepAddress.district,
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
          zipCode: cepAbertoAddress.cep,
          city: cepAbertoAddress.city!.cityName,
          state: cepAbertoAddress.state!.code,
          street: cepAbertoAddress.streetAddress,
          district: cepAbertoAddress.district,
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

    if (await calculateDelivery(address.lat!, address.long!)) {
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
    if (!kReleaseMode) {
      MonitoringLogger().logInfo('Info message: Start Calculate Delivery Cart');
    }

    try {
      final DocumentSnapshot doc = await firestore.doc("aux/delivery").get();

      final latStore = doc.get("lat") as double;
      final longStore = doc.get("long") as double;
      final basePriceDelivery = doc.get("basePrice") as num;
      final kmForDelivery = doc.get("km") as num;

      final maximumDeliveryDistance = doc.get("maxKm") as num;

      double distanceClient =
          Geolocator.distanceBetween(latStore, longStore, lat, long);

      // Converting distance from M to KM
      distanceClient /= 1000.0;

      if (distanceClient > maximumDeliveryDistance) {
        return false;
      }

      if (hasFreeShippingProduct) {
        deliveryPrice = basePriceDelivery + distanceClient * kmForDelivery;
        notifyListeners();
      } else {
        deliveryPrice = 0;
        notifyListeners();
      }

      return true;
    } catch (error) {
      return Future.error('CalculateDelivery $error');
    }
  }
}
