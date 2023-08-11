import 'package:brasil_fields/brasil_fields.dart';

formattedZipcode(String? address) {
  final zipcode = UtilBrasilFields.obterCep(address ?? "00000000");
  return zipcode;
}

unFormattedZipcode(String? address) {
  final unformattedValue = address?.replaceAll(RegExp(r"[^0-9]"), ""); //
  return unformattedValue;
}

formattedPhoneNumber(String? phone) {
  final phoneNumber = UtilBrasilFields.obterTelefone(phone ?? "");
  return phoneNumber;
}

unFormatPhone(String formattedValue) {
  final unformattedValue = formattedValue.replaceAll(RegExp(r"[^\d]"), "");
  return unformattedValue;
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
