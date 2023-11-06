import 'package:brn_ecommerce/models/chearch_cep/cepaberto_address.dart';
import 'package:brn_ecommerce/services/db_api/config.dart';
import 'package:dio/dio.dart';

const token = Config.cepabertoServiceToken;

class CepAbertoService {
  Map<String, dynamic>? headers;

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
