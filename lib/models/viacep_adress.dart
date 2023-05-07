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
  final String? logradouro;
  final String? bairro;
  final String? cidade;
  final String? estado;
  final String? ddd;
  final String? ibge;

  ViaCepAddress({
    this.longitude,
    this.latitude,
    required this.cep,
    this.logradouro,
    this.bairro,
    this.cidade,
    this.estado,
    this.ddd,
    this.ibge,
  });

  factory ViaCepAddress.fromMap(Map<String, dynamic> map,
      {double? latitude, double? longitude}) {
    return ViaCepAddress(
      longitude: longitude,
      latitude: latitude,
      cep: map['cep'] as String,
      logradouro: map['logradouro'] as String? ?? '',
      bairro: map['bairro'] as String? ?? '',
      cidade: map['localidade'] as String? ?? '',
      estado: map['uf'] as String? ?? '',
      ddd: map['ddd'] as String? ?? '',
      ibge: map['ibge'] as String? ?? '',
    );
  }

  @override
  String toString() {
    return 'ViaCepAddress{longitude: $longitude, latitude: $latitude, '
        'cep: $cep, logradouro: $logradouro, bairro: $bairro, '
        'cidade: $cidade, estado: $estado, ddd: $ddd, ibge: $ibge}';
  }
}
