import 'package:brasil_fields/brasil_fields.dart';

formattedZipcode(String? address) {
  final zipcode = UtilBrasilFields.obterCep(address ?? "");
  return zipcode;
}

formattedPhoneNumber(String? phone) {
  final phoneNumber = UtilBrasilFields.obterTelefone(phone ?? "");
  return phoneNumber;
}

formattedRealText(num real) {
  final currencyReal =
      UtilBrasilFields.obterReal(real.toDouble(), moeda: true, decimal: 2);
  return currencyReal;
}

formattedRealTextFormFiled(num real) {
  final currencyReal =
      UtilBrasilFields.obterReal(real.toDouble(), moeda: false, decimal: 2);
  return currencyReal;
}

unFormattedReal(String formattedValue) {
  final unformattedValue =
      formattedValue.replaceAll(".", "").replaceAll(",", ".");

  return unformattedValue;
}

formattedOrderId(String? orderId) {
  final formattedId = "#${orderId?.padLeft(6, "0")}";
  return formattedId;
}
