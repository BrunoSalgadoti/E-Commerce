import 'package:brn_ecommerce/models/locations_services/address.dart';
import 'package:brn_ecommerce/models/locations_services/viacep_map_api.dart';
import 'package:brn_ecommerce/models/products/cart_product.dart';
import 'package:brn_ecommerce/models/products/details_products.dart';
import 'package:brn_ecommerce/models/products/product.dart';
import 'package:brn_ecommerce/models/sales/delivery.dart';
import 'package:brn_ecommerce/models/users/users.dart';
import 'package:brn_ecommerce/models/users/users_manager.dart';
import 'package:brn_ecommerce/services/cepaberto_api.dart';
import 'package:brn_ecommerce/services/development_monitoring/monitoring_logger.dart';
import 'package:brn_ecommerce/services/viacep_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

/// # CartManager (Folder: models/sales)
///
/// A class representing the cart manager with functionalities for managing cart items,
/// calculating prices, updating user information, handling addresses, and more.
///
/// This class is responsible for managing the user's cart, including adding and removing items,
/// updating prices, checking address validity, calculating delivery charges, and more.
class CartManager extends ChangeNotifier {
  // Proprieties

  num productsPrice = 0.0;
  num? deliveryPrice;
  bool _loading = false;
  List<CartProduct> items = [];
  Users? users;
  Address? address;
  Delivery? delivery;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Getters and Setters

  /// Returns the total price of all products in the cart including delivery charges, if applicable.
  num get totalPrice => productsPrice + (deliveryPrice ?? 0);

  /// Indicates if the cart is currently loading data.
  bool get loading => _loading;

  /// Checks if the user's address is valid and delivery price is available.
  bool get isAddressValid => address != null && deliveryPrice != null;

  /// Checks if the cart is valid, i.e., all cart products have sufficient stock and amount.
  bool get isCartValid {
    for (final cartProduct in items) {
      if (!cartProduct.hasStock || !cartProduct.hasAmount) return false;
    }
    return true;
  }

  /// Checks if the cart has any product eligible for free shipping.
  bool get hasFreeShippingProduct {
    return items.any((product) => product.freight == true);
  }

  /// Returns the total quantity of items in the cart.
  num get totalQuantity {
    num quantity = 0;
    for (final item in items) {
      quantity += item.quantity ?? 0;
    }
    return quantity;
  }

  /// Sets the loading state of the cart.
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  // Methods

  /// Updates the user information and loads the cart items and user address.
  void updateUser(UserManager userManager) {
    if (kDebugMode) {
      MonitoringLogger().logInfo('Info message: Start Load User Cart');
    }

    users = userManager.users;
    productsPrice = 0.0;
    items.clear();
    removeAddress();

    if (users?.id != null) {
      _loadCartItems();
      _loadUserAddress();
    } else {
      users = null;
      notifyListeners();
    }
  }

  /// Loads the cart items from Firestore.
  Future<void> _loadCartItems() async {
    if (kDebugMode) {
      MonitoringLogger().logInfo('Info message: Start Load Cart Items');
    }

    final QuerySnapshot cartSnap = await users!.cartReference.get();

    items =
        cartSnap.docs.map((d) => CartProduct.fromDocument(d)..addListener(_onItemUpdate)).toList();
    notifyListeners();
  }

  /// Loads the user address and calculates delivery charges if applicable.
  Future<void> _loadUserAddress() async {
    if (kDebugMode) {
      MonitoringLogger().logInfo('Info message: Start Load Cart Address');
    }

    if (users?.address != null &&
        await calculateDelivery(users!.address!.lat!, users!.address!.long!)) {
      address = users!.address;
      notifyListeners();
    }
  }

  /// Adds a product to the cart with the specified details.
  void addToCart(Product product, DetailsProducts detailsProducts) {
    if (kDebugMode) {
      MonitoringLogger().logInfo('Info message: Add to Cart');
    }

    try {
      final sameEntity = items.firstWhere((p) => p.stackableSize(product));
      sameEntity.increment();
    } catch (newCartProd) {
      final cartProduct = CartProduct.fromProduct(product, detailsProducts);
      cartProduct.addListener(_onItemUpdate);
      items.add(cartProduct);
      users!.cartReference.add(cartProduct.toCartItemMap()).then((doc) => cartProduct.id = doc.id);
      _onItemUpdate();
    }
  }

  /// Removes a product from the cart.
  void removeOfCart(CartProduct cartProduct) {
    items.removeWhere((p) => p.id == cartProduct.id);
    users!.cartReference.doc(cartProduct.id).delete();
    cartProduct.removeListener(_onItemUpdate);
    notifyListeners();
  }

  /// Clears the entire cart, removing all items.
  void clearCart() {
    for (final cartProduct in items) {
      users!.cartReference.doc(cartProduct.id).delete();
    }
    items.clear();
    notifyListeners();
  }

  /// Handles cart item updates, recalculating prices and updating product details.
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

  /// Updates the cart product details in Firestore.
  void _updateCartProduct(CartProduct cartProduct) {
    if (cartProduct.id != null) {
      users!.cartReference.doc(cartProduct.id).update(cartProduct.toCartItemMap());
      users!.firestoreRef.update({"favourite": true});
    }

    hasFreeShippingProduct;
    if (hasFreeShippingProduct) {
      calculateDelivery(users?.address?.lat ?? 0.00, users?.address?.long ?? 0.00);
    }
    notifyListeners();
  }

  /// Fetches address details from a given ZIP code.
  Future<void> getAddress(String cep) async {
    if (!kReleaseMode) {
      MonitoringLogger().logInfo('Info message: Start Load Get Address Cart');
    }

    if (kIsWeb) {
      loading = true;
      final viaCepService = ViaCepApi();

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
      final cepAbertoService = CepAbertoApi();

      try {
        final cepAbertoAddress = await cepAbertoService.getAddressFromZipCode(cep);

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

  /// Sets the address for delivery and calculates associated charges.
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

  /// Removes the currently set address and associated delivery charges.
  void removeAddress() {
    address = null;
    deliveryPrice = null;
    notifyListeners();
  }

  /// Calculates delivery charges based on the user's location.
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

      double distanceClient = Geolocator.distanceBetween(latStore, longStore, lat, long);

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
      return Future.error('Erro ao calcular Frete $error');
    }
  }
}
