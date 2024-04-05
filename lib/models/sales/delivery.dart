import 'package:brn_ecommerce/services/db_api/config.dart';

/// # Delivery (Folder: models/sales)
///
/// A class representing delivery settings, including base price, kilometers, latitude, longitude, and maximum distance.
///
/// This class contains properties and methods related to delivery configuration.
class Delivery {
  // Proprieties

  num? basePrice;
  num? km;
  num? maxKm;
  double? lat;
  double? long;

  //TODO: Configurar na tela do ADM inserção de valores
  /// # Control variables for delivery
  /// The maximum distance configured by the administrator for product delivery
  // (Initial values taking into account the center of the city in question)
  // Delivery value considering the distance radius maxKmForDelivery x kmForPriceQuote
  num basePriceForDelivery = deliveryConfig.basePriceFromFactory;

  // Value for price quote (Base value X kilometers traveled (basePriceForDelivery X kmForPriceQuote))
  num kmForPriceQuote = deliveryConfig.kmFromFactory;

  // Store latitude (starting point for shipping calculation)
  double latOfStore = deliveryConfig.latOfStoreFromFactory;

  // store longitude (starting point for shipping calculation)
  double longOfStore = deliveryConfig.longOfStoreFromFactory;

  // Maximum delivery radius in kilometers for product deliveries
  num maxKmForDelivery = deliveryConfig.maxKmFromFactory;

  // Constructors

  /// Initializes a [Delivery] instance with the specified parameters.
  Delivery({
    this.basePrice,
    this.km,
    this.lat,
    this.long,
    this.maxKm,
  });

  /// Creates a [Delivery] instance from a map.
  Delivery.fromMap(Map<String, dynamic> map) {
    basePrice = map["basePrice"] as num;
    km = map["km"] as num;
    lat = map["lat"] as double;
    long = map["long"] as double;
    maxKm = map["maxKm"] as num;
  }

  // Methods

  /// Converts the delivery data to a map for Firestore storage.
  Map<String, dynamic> toMap() {
    return {
      "basePrice": basePriceForDelivery,
      "km": kmForPriceQuote,
      "lat": latOfStore,
      "long": longOfStore,
      "maxKm": maxKmForDelivery,
    };
  }
}
