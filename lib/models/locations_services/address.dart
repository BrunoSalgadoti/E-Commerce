import 'package:brn_ecommerce/common/formatted_fields/format_values.dart';

/// ## Address Class (Folder: models/locations_services)
///
/// Represents a physical address with detailed location information.
///
/// This class includes attributes such as street, number, complement, district, zip code,
/// city, state, latitude, and longitude to describe a complete address.
class Address {
  String? street;
  String? number;
  String? complement;
  String? district;
  String? zipCode;
  String? city;
  String? state;
  double? lat;
  double? long;

  /// Creates an [Address] object with the specified parameters.
  Address(
      {this.street,
      this.number,
      this.complement,
      this.district,
      this.zipCode,
      this.city,
      this.state,
      this.lat,
      this.long});

  /// Creates an [Address] object from a map of address data.
  ///
  /// The map should contain keys for "street", "number", "complement", "district",
  /// "zipCode", "city", "state", "lat", and "long" representing the respective address components.
  Address.fromMap(Map<String, dynamic> map) {
    street = map["street"] as String;
    number = map["number"] as String;
    complement = map["complement"] as String;
    district = map["district"] as String;
    zipCode = map["zipCode"] as String? ?? "00.000-000";
    city = map["city"] as String;
    state = map["state"] as String;
    lat = map["lat"] as double;
    long = map["long"] as double;
  }

  /// Converts the [Address] object to a map for serialization.
  ///
  /// Returns a map containing the address attributes as key-value pairs.
  Map<String, dynamic> toMap() {
    return {
      "street": street,
      "number": number,
      "complement": complement,
      "district": district,
      "zipCode": unFormattedZipcode(zipCode ?? "00000000"), // Format zip code if necessary
      "city": city,
      "state": state,
      "lat": lat,
      "long": long,
    };
  }
}
