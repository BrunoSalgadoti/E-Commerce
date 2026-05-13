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