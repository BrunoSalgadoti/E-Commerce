import 'package:brasil_fields/brasil_fields.dart';
import 'package:brn_ecommerce/common/custom_text_form_field.dart';
import 'package:brn_ecommerce/helpers/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CardFront extends StatelessWidget {
  const CardFront({super.key});

  @override
  Widget build(BuildContext context) {
    const spaceTextFormFieldHeight = SizedBox(height: 3);

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 16,
      child: Container(
        padding: const EdgeInsets.all(16),
        height: 250,
        color: const Color(0xFF343131),
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
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CartaoBancarioInputFormatter()
                    ],
                    validator: (number) {
                      if (number?.length != 19) return 'I N V Á L I D O!';
                      return null;
                    },
                    onSaved: (value) {},
                  ),
                  spaceTextFormFieldHeight,
                  CustomTextFormField(
                    title: 'Validade',
                    titleBold: true,
                    textFormFieldColor: Colors.white,
                    hintText: 'XX/XX',
                    hintColor: Colors.white.withAlpha(100),
                    textInputType: TextInputType.number,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 6),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      ValidadeCartaoInputFormatter()
                    ],
                    validator: (date) {
                      if (date?.length != 5) return 'I N V Á L I D O!';
                      return null;
                    },
                    onSaved: (value) {},
                  ),
                  spaceTextFormFieldHeight,
                  CustomTextFormField(
                    title: 'Titular',
                    titleBold: true,
                    textFormFieldColor: Colors.white,
                    hintText: 'Nome impresso no Cartão',
                    hintColor: Colors.white.withAlpha(100),
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 6),
                    inputFormatters: [],
                    validator: (name) => emptyValidator(name),
                    onSaved: (value) {},
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
