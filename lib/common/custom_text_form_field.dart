import 'dart:io';

import 'package:brn_ecommerce/helpers/themes/factory_colors/android_factory_colors.dart';
import 'package:brn_ecommerce/helpers/themes/factory_colors/ios_factory_colos.dart';
import 'package:brn_ecommerce/helpers/themes/factory_colors/web_factory_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.onSaved,
    this.hintText,
    this.title,
    this.titleBold = false,
    this.textInputType = TextInputType.text,
    this.focusedBorder,
    this.focusedBorderColor,
    this.fillColor = Colors.transparent,
    this.enabledBorder,
    this.hintColor,
    this.isDense = true,
    this.contentPadding,
    this.filled,
    this.titleColor = Colors.white,
    this.titleSize = 10,
    this.hintSize = 14,
    this.textFormFieldBold = false,
    this.hintBold = false,
    this.validator,
    this.initialValue,
    this.inputFormatters,
    this.labelText,
    this.textFormFieldSize = 16,
    this.textFormFieldColor = Colors.black,
    this.obscureText = false,
    this.enableBorderColor,
    this.enableTextEdit,
    this.textCapitalization,
    this.maxLength,
    this.controller,
    this.onChanged,
    this.autocorrect,
    this.prefixText,
    this.counterText = '',
    this.textAlign = TextAlign.start,
    this.focusNode,
    this.onSubmitted,
  });

  final String? title;
  final String? initialValue;
  final String? hintText;
  final String? labelText;
  final String? prefixText;
  final String? counterText;
  final double? titleSize;
  final double? hintSize;
  final double? textFormFieldSize;
  final int? maxLength;
  final Color textFormFieldColor;
  final Color? titleColor;
  final Color? hintColor;
  final Color? focusedBorderColor;
  final Color? enableBorderColor;
  final Color? fillColor;
  final bool titleBold;
  final bool hintBold;
  final bool textFormFieldBold;
  final bool? enableTextEdit;
  final bool? autocorrect;
  final bool? filled;
  final bool? isDense;
  final bool obscureText;
  final TextCapitalization? textCapitalization;
  final TextEditingController? controller;
  final TextAlign? textAlign;
  final FocusNode? focusNode;
  final TextInputType textInputType;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final EdgeInsetsGeometry? contentPadding;
  final void Function(String?)? onSaved;
  final void Function(String?)? onSubmitted;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;

  Color getFocusBorderColor([BuildContext? context]) {
    if (kIsWeb) {
      return const WebFactoryColors().focusedBorderColor;
    } else if (Platform.isAndroid) {
      return const AndroidFactoryColors().focusedBorderColor;
    } else if (Platform.isIOS) {
      return const IosFactoryColors().focusedBorderColor;
    } else {
      return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title == null
            ? Container()
            : Text(
                title ?? '',
                style: TextStyle(
                    fontSize: titleSize,
                    fontWeight: titleBold ? FontWeight.bold : FontWeight.w400,
                    color: titleColor),
              ),
        TextFormField(
          initialValue: initialValue,
          inputFormatters: inputFormatters,
          enabled: enableTextEdit,
          controller: controller,
          autocorrect: autocorrect ?? true,
          focusNode: focusNode,
          textCapitalization: textCapitalization ?? TextCapitalization.none,
          maxLength: maxLength,
          textAlign: textAlign!,
          style: TextStyle(
            color: textFormFieldColor,
            fontWeight: textFormFieldBold ? FontWeight.bold : FontWeight.w400,
            fontSize: textFormFieldSize,
          ),
          decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
            prefixText: prefixText,
            counterText: counterText,
            hintStyle: TextStyle(
              color: hintColor ?? Colors.black.withAlpha(100),
              fontSize: hintSize,
              fontWeight: hintBold ? FontWeight.bold : FontWeight.w500,
            ),
            focusedBorder: focusedBorder ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: BorderSide(
                    color: focusedBorderColor ?? getFocusBorderColor(),
                  ),
                ),
            enabledBorder: enabledBorder ??
                UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: BorderSide(
                    color: enableBorderColor ?? Colors.black87,
                  ),
                ),
            fillColor: fillColor,
            filled: filled,
            contentPadding: contentPadding,
            isDense: isDense,
          ),
          keyboardType: textInputType,
          onSaved: onSaved,
          onChanged: onChanged,
          validator: validator,
          obscureText: obscureText,
          onFieldSubmitted: onSubmitted,
        )
      ],
    );
  }
}
