class Delivery {
  Delivery({
    this.basePrice,
    this.km,
    this.lat,
    this.long,
    this.maxKm,
  });

  num? basePrice;
  num? km;
  double? lat;
  double? long;
  num? maxKm;

  // Initial values taking into account the center of the city in question
  num basePriceFromAdmin = 5;
  num kmFromAdmin = 0.5;
  double latFromAdmin = -9.4001;
  double longFromAdmin = -38.2176;
  num maxKmFromAdmin = 30;

  Delivery.fromMap(Map<String, dynamic> map) {
    basePrice = map["basePrice"] as num;
    km = map["km"] as num;
    lat = map["lat"] as double;
    long = map["long"] as double;
    maxKm = map["maxKm"] as num;
  }

  Map<String, dynamic> toMap() {
    return {
      "basePrice": basePriceFromAdmin,
      "km": kmFromAdmin,
      "lat": latFromAdmin,
      "long": longFromAdmin,
      "maxKm": maxKmFromAdmin,
    };
  }
}
