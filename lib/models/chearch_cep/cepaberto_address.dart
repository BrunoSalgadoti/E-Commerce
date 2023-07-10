class CepAbertoAddress {
  final double? altitude;
  final double? latitude;
  final double? longitude;
  final String cep;
  final String? streetAddress;
  final String? district;
  final City? city;
  final State? state;

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

class City {
  final int ddd;
  final String ibge;
  final String cityName;

  City.fromMap(Map<String, dynamic> map)
      : ddd = map["ddd"] as int? ?? 0,
        ibge = map["ibge"] as String? ?? "",
        cityName = map["nome"] as String? ?? "";

  @override
  String toString() {
    return 'City{ddd: $ddd, ibge: $ibge, cityName: $cityName}';
  }
}

class State {
  final String code;

  State.fromMap(Map<String, dynamic> map)
      : code = map["sigla"] as String? ?? "";

  @override
  String toString() {
    return 'State{code: $code}';
  }
}
