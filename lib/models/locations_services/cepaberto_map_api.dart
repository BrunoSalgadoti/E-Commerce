/// ## CepAbertoAddress Class (Folder: models/locations_services)
/// Represents an address retrieved from the CepAberto API.
///
/// This class provides a structured representation of address information
/// obtained from the CepAberto API, including details such as altitude, latitude,
/// longitude, postal code (CEP), street address, district, city, and
class CepAbertoAddress {
  final double? altitude;
  final double? latitude;
  final double? longitude;
  final String cep;
  final String? streetAddress;
  final String? district;
  final City? city;
  final State? state;

  /// Creates a [CepAbertoAddress] object from a map of address data.
  ///
  /// The [altitude], [latitude], [longitude], [cep], [streetAddress], [district],
  /// [city], and [state] parameters are initialized based on the provided map.
  CepAbertoAddress.fromMap(Map<String, dynamic> map)
      : altitude = map["altitude"] as double? ?? 0.0,
        latitude = double.tryParse(map["latitude"] as String? ?? ""),
        longitude = double.tryParse(map["longitude"] as String? ?? ""),
        cep = map["cep"] as String,
        streetAddress = map["logradouro"] as String? ?? "",
        district = map["bairro"] as String? ?? "",
        city = City.fromMap(map["cidade"] as Map<String, dynamic>),
        state = State.fromMap(map["estado"] as Map<String, dynamic>);

  @override
  String toString() {
    return 'CepAbertoAddress{altitude: $altitude, latitude: $latitude, '
        'longitude: $longitude, cep: $cep, streetAddress: $streetAddress, '
        'district: $district, city: $city, state: $state}';
  }
}

/// Represents a city entity.
class City {
  /// Area code (DDD) of the city.
  final int ddd;

  /// IBGE code of the city.
  final String ibge;

  /// Name of the city.
  final String cityName;

  /// Creates a [City] object from a map of city data.
  ///
  /// The [ddd], [ibge], and [cityName] parameters are initialized based on the provided map.
  City.fromMap(Map<String, dynamic> map)
      : ddd = map["ddd"] as int? ?? 0,
        ibge = map["ibge"] as String? ?? "",
        cityName = map["nome"] as String? ?? "";

  @override
  String toString() {
    return 'City{ddd: $ddd, ibge: $ibge, cityName: $cityName}';
  }
}

/// Represents a state entity.
class State {
  /// Abbreviation code of the state.
  final String code;

  /// Creates a [State] object from a map of state data.
  ///
  /// The [code] parameter is initialized based on the provided map.
  State.fromMap(Map<String, dynamic> map) : code = map["sigla"] as String? ?? "";

  @override
  String toString() {
    return 'State{code: $code}';
  }
}
