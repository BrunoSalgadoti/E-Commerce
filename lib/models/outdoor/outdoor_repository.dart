

import 'package:brn_ecommerce/models/outdoor/components/outdoor_item.dart';
import 'package:brn_ecommerce/models/outdoor/components/outdoor_service.dart';

class OutdoorRepository {
  final OutdoorService _service;

  OutdoorRepository(this._service);

  Future<List<OutdoorItem>> getOutdoors() => _service.fetchOutdoors();

  Future<void> addOutdoor(OutdoorItem item) => _service.addOutdoor(item);

  Future<void> deleteOutdoor(OutdoorItem item) => _service.deleteOutdoor(item);

  Future<OutdoorItem?> uploadImage() => _service.uploadImage();

  Future<void> addYoutube(String url) => _service.addYoutubeLink(url);

  Future<void> addAsset(String path) => _service.addAsset(path);
}
