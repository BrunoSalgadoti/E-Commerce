import 'package:brasil_fields/brasil_fields.dart';

/// # Formatted Values (Folder: common/formatted_fields)
///
/// This file contains functions for formatting and unformatting different types of data.
/// The functions here provide flexibility to work with specific formats
/// such as zip code, telephone number, monetary values, etc.

/// ##Formatted CEP (formatted Zipcode)
///
/// Function that formats a Zipcode to a specific format.
///
/// - The [address] parameter is the address string to be formatted.
/// - Returns the formatted zip code or '00000000' if the address is null or does not have 8 characters.
String formattedZipcode(String? address) {
  if (address == null || address.length != 8) {
    return '00.000-000';
  }
  final zipcode = UtilBrasilFields.obterCep(address);
  return zipcode;
}

/// ## unFormattedZipcode (Zipcode unformatted)
///
/// Function that unformats a Zipcode, removing non-numeric characters.
///
/// - The [address] parameter is the address string to be unformatted.
/// - Returns the unformatted zip code.
String? unFormattedZipcode(String? address) {
  final unformattedValue = address?.replaceAll(RegExp(r"[^0-9]"), ""); //
  return unformattedValue;
}

/// ## formattedPhoneNumber (Phone number formatting)
///
/// Function that formats a phone number to a specific format.
///
/// - The [phone] parameter is the phone number string to be formatted.
/// - Returns the formatted phone number.
String formattedPhoneNumber(String? phone) {
  final phoneNumber = UtilBrasilFields.obterTelefone(phone ?? "");
  return phoneNumber;
}

/// ## unFormatPhone (Clean phone number)
///
/// Function that unformats a phone number, removing non-numeric characters.
///
/// - The [formattedValue] parameter is the formatted phone number string.
/// - Returns the unformatted phone number.
String unFormatPhone(String formattedValue) {
  final unformattedValue = formattedValue.replaceAll(RegExp(r"[^\d]"), "");
  return unformattedValue;
}

/// ## formattedRealText (Formatted monetary value)
///
/// Function that formats a numeric value as Brazilian currency (Real).
///
/// - The [real] parameter is the numeric value to be formatted.
/// - Returns the value formatted as Brazilian currency.
String formattedRealText(num real) {
  final currencyReal = UtilBrasilFields.obterReal(real.toDouble(), moeda: true, decimal: 2);
  return currencyReal;
}

/// ## formattedRealTextFormFiled (Formatted numeric value)
///
/// Function that formats a numeric value as text, without the currency symbol.
///
/// - The [real] parameter is the numeric value to be formatted as text.
/// - Returns the value formatted as text.
String formattedRealTextFormFiled(num real) {
  final currencyReal = UtilBrasilFields.obterReal(real.toDouble(), moeda: false, decimal: 2);
  return currencyReal;
}

/// ## unFormattedReal (Unformatted monetary value)
///
/// Function that unformats a monetary value, removing thousands and decimal separators.
///
/// - The [formattedValue] parameter is the formatted monetary value string.
/// - Returns the unformatted value.
String unFormattedReal(String formattedValue) {
  final unformattedValue = formattedValue.replaceAll(".", "").replaceAll(",", ".");
  return unformattedValue;
}

/// ## formattedOrderId (formatted order ID)
///
/// Function that formats an order ID by adding "#" and completing with leading zeros.
///
/// - The [orderId] parameter is the order ID string to be formatted.
/// - Returns the formatted order ID.
String formattedOrderId(String? orderId) {
  final formattedId = "#${orderId?.padLeft(6, "0")}";
  return formattedId;
}
