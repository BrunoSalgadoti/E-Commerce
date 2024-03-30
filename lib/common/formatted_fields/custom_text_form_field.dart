import 'package:brn_ecommerce/common/functions/common_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// # Widget for a Custom TextFormField reused in the project (Folder: common/formatted_fields)
/// ## CustomTextFormField
///
/// Widget that represents a customized text form field with various styling options and functionalities.
///
/// 1- Aesthetic Personalization:
/// Custom Text Form Field offers a wide range of styling options such as colors, font sizes,
/// bold and alignment, allowing you to adapt the look of the input field according to the design
/// of your application.
///
/// 2 - Additional Functions:
/// In addition to the standard properties of a text field, such as hintText, initialValue, and maxLength,
/// the Custom Text Form Field also supports extra functionality like prefixText to add text
/// before the input field and counterText to display the character count.
///
/// 3 - Integrated Validation:
/// The class includes an integrated validation system through the property validator, allowing
/// allow you to define custom validation rules to ensure data integrity
/// entered by the user.
///
/// 4 - Ease of Use:
/// With the ability to define actions such as onSaved, onChanged, and onSubmitted, the Custom Text Form Field
/// facilitates user interaction and form data capture and manipulation.
///
/// 5 - Reuse and Modularity:
/// By encapsulating all of this functionality in a custom widget, you promote reuse
/// of code and modularity of your application, making it easier to implement and maintain fields
/// consistent text across different parts of the interface.
///
/// ## [Properties]
/// - `[title]`: The title displayed above the text form field.
/// - `[initialValue]`: The initial value of the text form field.
/// - `[hintText]`: Hint text displayed inside the text form field when it is empty.
/// - `[labelText]`: Label text displayed inside the text form field.
/// - `[prefixText]`: Text displayed before the input field.
/// - `[counterText]`: Text displayed below the input field to show character count.
/// - `[titleSize]`: Font size of the title text.
/// - `[hintSize]`: Font size of the hint text.
/// - `[textFormFieldSize]`: Font size of the input text.
/// - `[maxLength]`: Maximum length of input characters.
/// - `[textFormFieldColor]`: Color of the input text.
/// - `[titleColor]`: Color of the title text.
/// - `[hintColor]`: Color of the hint text.
/// - `[focusedBorderColor]`: Color of the border when the field is focused.
/// - `[enableBorderColor]`: Color of the border when the field is enabled.
/// - `[fillColor]`: Background color of the text form field.
/// - `[titleBold]`: Whether the title text should be bold.
/// - `[hintBold]`: Whether the hint text should be bold.
/// - `[textFormFieldBold]`: Whether the input text should be bold.
/// - `[enableTextEdit]`: Whether text editing is enabled.
/// - `[autocorrect]`: Whether autocorrection is enabled.
/// - `[filled]`: Whether the text form field should be filled with a background color.
/// - `[isDense]`: Whether the text form field should have compact vertical padding.
/// - `[obscureText]`: Whether the input text should be obscured (e.g., for passwords).
/// - `[textInputAction]`: The action to perform when the enter key is pressed.
/// - `[textCapitalization]`: Capitalization behavior for the input text.
/// - `[controller]`: The controller for editing the text.
/// - `[textAlign]`: Alignment of the text within the text form field.
/// - `[focusNode]`: The focus node that controls the focus state of the field.
/// - `[inputFormatters]`: List of input formatters to format the input text.
/// - `[onSaved]`: Callback function invoked when the form field is saved.
/// - `[onSubmitted]`: Callback function invoked when the enter key is pressed.
/// - `[onChanged]`: Callback function invoked when the input text changes.
/// - `[validator]`: Validator function to validate the input text.
///
/// ## [Usage]
/// ```dart
/// CustomTextFormField(
///   title: 'Name',
///   hintText: 'Enter your name',
///   initialValue: 'Bruno Salgado',
///   onChanged: (value) {
///     // Handle text field value changes
///   },
///   validator: (value) {
///     if (value == null || value.isEmpty) {
///       return 'Please enter your name';
///     }
///     return null;
///   },
/// )
/// ```
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
  }) : textInputAction = onSubmitted == null ? TextInputAction.done : TextInputAction.next;

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
  final TextInputAction? textInputAction;
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
          textInputAction: textInputAction,
        )
      ],
    );
  }
}
