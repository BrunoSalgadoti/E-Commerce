import 'package:brn_ecommerce/common/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CardBack extends StatelessWidget {
  const CardBack({super.key, required this.cvvFocus});

  final FocusNode cvvFocus;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 16,
      child: Container(
        height: 250,
        color: const Color(0xFF343131),
        child: Column(
          children: [
            Container(
              color: Colors.black,
              height: 40,
              margin: const EdgeInsets.symmetric(vertical: 16),
            ),
            Row(
              children: [
                Expanded(
                    flex: 60,
                    child: Container(
                      color: Colors.grey[500],
                      margin: const EdgeInsets.only(left: 12),
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      child: CustomTextFormField(
                        hintText: '123',
                        hintSize: 18,
                        textFormFieldBold: true,
                        textFormFieldSize: 19,
                        textAlign: TextAlign.end,
                        textInputType: TextInputType.number,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusNode: cvvFocus,
                        maxLength: 3,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (cvv) {
                          if (cvv?.length != 3) return 'I N V Á L I D O';
                          return null;
                        },
                      ),
                    )),
                Expanded(flex: 40, child: Container())
              ],
            )
          ],
        ),
      ),
    );
  }
}
