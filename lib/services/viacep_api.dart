import 'package:brn_ecommerce/models/locations_services/viacep_map_api.dart';
import 'package:dio/dio.dart';

/// # ViaCepApi (Folder: services)
///
/// Provides methods to fetch address information from ViaCEP API based on a given zip code.
///
/// This class uses the `dio` package for making HTTP requests.
class ViaCepApi {
  // Methods

  /// Fetches address information from ViaCEP API based on the provided [zipCode].
  ///
  /// Returns a [Future] containing a [ViaCepAddress] object representing the address.
  /// If the zip code is invalid or an error occurs during the request, an error message is returned.
  Future<ViaCepAddress> getAddressFromZipCode(String zipCode) async {
    final cleanZipCode = zipCode.replaceAll(RegExp("[^0-9]"), "");
    final endpoint = "https://viacep.com.br/ws/$cleanZipCode/json/";

    final Dio dio = Dio();

    dio.options.responseType = ResponseType.json;

    try {
      final response = await dio.get(endpoint);

      if (response.data.isEmpty) {
        return Future.error('CEP Inválido');
      }

      final ViaCepAddress address = ViaCepAddress.fromMap(response.data);

      return address;
    } on DioException {
      return Future.error('Erro ao Buscar CEP, favor tentar em instantes!');
    }
  }
}
