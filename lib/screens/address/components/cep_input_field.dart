import 'package:brasil_fields/brasil_fields.dart';
import 'package:ecommerce/common/button/custom_button.dart';
import 'package:ecommerce/common/button/custom_icon_button.dart';
import 'package:ecommerce/models/address.dart';
import 'package:ecommerce/models/cart_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CepInputField extends StatefulWidget {
  const CepInputField({super.key, required this.address});

  final Address address;

  @override
  State<CepInputField> createState() => _CepInputFieldState();
}

class _CepInputFieldState extends State<CepInputField> {
  final TextEditingController cepController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cartManager = context.watch<CartManager>();
    final primaryColor = Theme.of(context).primaryColor;

    if (widget.address.zipCode == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            enabled: !cartManager.loading,
            controller: cepController,
            decoration: const InputDecoration(
                isDense: true,
                labelText: 'CEP',
                hintText: '00.000-000',
                hintStyle: TextStyle(color: Colors.black26)),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CepInputFormatter(),
            ],
            keyboardType: TextInputType.number,
            validator: (cep) {
              if (cep!.isEmpty) {
                return 'Campo obrigatório';
              } else if (cep.length != 10) {
                return 'CEP Inválido';
              } else {
                return null;
              }
            },
          ),
          const SizedBox(
            height: 7,
          ),
          CustomButton(
              texto: 'Buscar CEP',
              onPressed: !cartManager.loading
                  ? () async {
                      if (Form.of(context).validate()) {
                        try {
                          await cartManager.getAddress(cepController.text);
                        } catch (error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('$error'),
                              backgroundColor: Colors.red,
                              duration: const Duration(milliseconds: 4500),
                            ),
                          );
                        }
                      }
                    }
                  : null
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
                'CEP: ${widget.address.zipCode}',
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
              onTap: () {
                cartManager.removeAddress();
              },
            )
          ],
        ),
      );
    }
  }
}
