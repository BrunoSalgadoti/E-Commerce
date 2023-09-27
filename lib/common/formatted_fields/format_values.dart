import 'package:brasil_fields/brasil_fields.dart';

String formattedZipcode(String? address) {
  if (address == null || address.length != 8) {
    return '00000000';
  }
  final zipcode = UtilBrasilFields.obterCep(address);
  return zipcode;
}

String? unFormattedZipcode(String? address) {
  final unformattedValue = address?.replaceAll(RegExp(r"[^0-9]"), ""); //
  return unformattedValue;
}

String formattedPhoneNumber(String? phone) {
  final phoneNumber = UtilBrasilFields.obterTelefone(phone ?? "");
  return phoneNumber;
}

String unFormatPhone(String formattedValue) {
  final unformattedValue = formattedValue.replaceAll(RegExp(r"[^\d]"), "");
  return unformattedValue;
}

String formattedRealText(num real) {
  final currencyReal =
      UtilBrasilFields.obterReal(real.toDouble(), moeda: true, decimal: 2);
  return currencyReal;
}

String formattedRealTextFormFiled(num real) {
  final currencyReal =
      UtilBrasilFields.obterReal(real.toDouble(), moeda: false, decimal: 2);
  return currencyReal;
}

String unFormattedReal(String formattedValue) {
  final unformattedValue =
      formattedValue.replaceAll(".", "").replaceAll(",", ".");
  return unformattedValue;
}

String formattedOrderId(String? orderId) {
  final formattedId = "#${orderId?.padLeft(6, "0")}";
  return formattedId;
}
