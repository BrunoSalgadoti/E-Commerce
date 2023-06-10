import 'package:brn_ecommerce/models/chearch_cep/viacep_adress.dart';
import 'package:dio/dio.dart';

class ViaCepService {
  Future<ViaCepAddress> getAddressFromZipCode(String zipCode) async {
    final cleanZipCode = zipCode.replaceAll(RegExp('[^0-9]'), '');
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
      return Future.error('Erro ao Buscar CEP');
    }
  }
}
