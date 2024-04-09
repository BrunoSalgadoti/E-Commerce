import 'package:brasil_fields/brasil_fields.dart';
import 'package:brn_ecommerce/common/buttons/custom_button.dart';
import 'package:brn_ecommerce/common/buttons/custom_icon_button.dart';
import 'package:brn_ecommerce/common/formatted_fields/custom_text_form_field.dart';
import 'package:brn_ecommerce/common/messengers/custom_scaffold_messenger.dart';
import 'package:brn_ecommerce/models/locations_services/address.dart';
import 'package:brn_ecommerce/models/sales/cart_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../common/formatted_fields/format_values.dart';

class CepInputField extends StatelessWidget {
  final Address address;

  CepInputField({
    super.key,
    required this.address,
  });

  final TextEditingController cepController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cartManager = context.watch<CartManager>();
    final primaryColor = Theme.of(context).primaryColor;

    if (address.zipCode == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 10),
          CustomTextFormField(
            enableTextEdit: !cartManager.loading,
            controller: cepController,
            labelText: 'CEP',
            hintText: '00000000',
            inputFormatters: [FilteringTextInputFormatter.digitsOnly, CepInputFormatter()],
            textInputType: TextInputType.number,
            validator: (value) {
              if (value?.length != 10) {
                return 'CEP Inválido';
              } else {
                return null;
              }
            },
          ),
          const SizedBox(height: 7),
          CustomButton(
            text: 'Buscar CEP',
            onPressed: !cartManager.loading
                ? () async {
                    if (Form.of(context).validate()) {
                      try {
                        await cartManager.getAddress(cepController.text);
                      } catch (error) {
                        // ignore: use_build_context_synchronously
                        CustomScaffoldMessenger(context: context, message: '$error')
                            .alertScaffold();
                      }
                    }
                  }
                : null,
          )
        ],
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Expanded(
              child: Text(
                'CEP: ${formattedZipcode(address.zipCode)}',
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            CustomIconButton(
              iconData: Icons.edit,
              size: 20,
              color: primaryColor,
              onTap: () => cartManager.removeAddress(),
              semanticLabel: 'Editar',
            )
          ],
        ),
      );
    }
  }
}
