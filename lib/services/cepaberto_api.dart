import 'package:brn_ecommerce/models/locations_services/cepaberto_map_api.dart';
import 'package:brn_ecommerce/services/db_api/config.dart';
import 'package:dio/dio.dart';

const token = Config.cepabertoServiceToken;

/// # CepAbertoApi (Folder: services)
///
/// Provides methods to fetch address information from CepAberto API based on a given zip code.
///
/// This class uses the `dio` package for making HTTP requests.
class CepAbertoApi {
  // Propriety

  Map<String, dynamic>? headers;

  // Methods

  /// Fetches address information from CepAberto API based on the provided [zipCode].
  ///
  /// Returns a [Future] containing a [CepAbertoAddress] object representing the address.
  /// If the zip code is invalid or an error occurs during the request, an error message is returned.
  Future<CepAbertoAddress> getAddressFromZipCode(String zipCode) async {
    final cleanZipCode = zipCode.replaceAll(RegExp("[^0-9]"), "");
    final endpoint = "https://www.cepaberto.com/api/v3/cep?cep=$cleanZipCode";

    final Dio dio = Dio();

    dio.options.headers["Authorization"] = "Token token=$token";

    try {
      final response = await dio.get<Map<String, dynamic>>(endpoint);

      if (response.data!.isEmpty) {
        return Future.error('CEP Inválido');
      }

      final CepAbertoAddress address = CepAbertoAddress.fromMap(response.data!);

      return address;
    } on DioException {
      return Future.error('Erro ao Buscar CEP');
    }
  }
}
