import 'package:geolocator/geolocator.dart';

class LocationService {
  GeolocatorPlatform geolocatorPlatform = GeolocatorPlatform.instance;

  static Future<Position> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    return position;
  }
}

class ViaCepAddress {
  final double? longitude;
  final double? latitude;
  final String cep;
  final String? streetAddress;
  final String? district;
  final String? city;
  final String? state;
  final String? ddd;
  final String? ibge;

  ViaCepAddress({
    this.longitude,
    this.latitude,
    required this.cep,
    this.streetAddress,
    this.district,
    this.city,
    this.state,
    this.ddd,
    this.ibge,
  });

  factory ViaCepAddress.fromMap(Map<String, dynamic> map,
      {double? latitude, double? longitude}) {
    return ViaCepAddress(
      longitude: longitude,
      latitude: latitude,
      cep: map["cep"] as String,
      streetAddress: map["logradouro"] as String? ?? '',
      district: map["bairro"] as String? ?? '',
      city: map["localidade"] as String? ?? '',
      state: map["uf"] as String? ?? '',
      ddd: map["ddd"] as String? ?? '',
      ibge: map["ibge"] as String? ?? '',
    );
  }

  @override
  String toString() {
    return 'ViaCepAddress{longitude: $longitude, latitude: $latitude, '
        'cep: $cep, streetAddress: $streetAddress, district: $district, '
        'city: $city, state: $state, ddd: $ddd, ibge: $ibge}';
  }
}
