import 'package:brn_ecommerce/common/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class CardFront extends StatelessWidget {
  const CardFront({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 16,
      child: Container(
        padding: const EdgeInsets.all(16),
        height: 220,
        color: const Color(0xFF1B4B52),
        child: Row(
          children: [
            Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomTextFormField(
                  title: 'Número',
                  titleBold: true,
                  textFormFieldColor: Colors.white,
                  hintText: '0000 0000 0000 0000',
                  hintColor: Colors.white.withAlpha(100),
                  textInputType: TextInputType.number,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 6),
                  onSaved: (value) {},
                ),
                CustomTextFormField(
                  title: 'Validade',
                  titleBold: true,
                  textFormFieldColor: Colors.white,
                  hintText: 'XX/20XX',
                  hintColor: Colors.white.withAlpha(100),
                  textInputType: TextInputType.number,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 6),
                  onSaved: (value) {},
                ),
                CustomTextFormField(
                  title: 'Titular',
                  titleBold: true,
                  textFormFieldColor: Colors.white,
                  hintText: 'Nome impresso no Cartão',
                  hintColor: Colors.white.withAlpha(100),
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 6),
                  onSaved: (value) {},
                )
              ],
            )),
          ],
        ),
      ),
    );
  }
}
