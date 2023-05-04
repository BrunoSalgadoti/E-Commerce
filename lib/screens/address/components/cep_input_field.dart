import 'package:brasil_fields/brasil_fields.dart';
import 'package:ecommerce/common/button/custom_button.dart';
import 'package:ecommerce/models/cart_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CepInputField extends StatelessWidget {
  const CepInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final TextEditingController cepController = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          controller: cepController,
          decoration:  const InputDecoration(
            isDense: true,
            labelText: 'CEP',
            hintText: '00.000-000',
              hintStyle: TextStyle(
                  color: Colors.black26
              )
          ),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            CepInputFormatter(),
          ],
          keyboardType: TextInputType.number,
          validator: (cep) {
            if(cep!.isEmpty) {
              return 'Campo obrigatório';
            } else if (cep.length != 10) {
              return 'CEP Inválido';
            } else {
              return null;
            }
          },
        ),
        const SizedBox(height: 7,),
        CustomButton(
            texto: 'Buscar CEP',
            onPressed: () {
              if(Form.of(context).validate()){
                context.read<CartManager>().getAddress(cepController.text);

              }
            }
        )
      ],
    );
  }
}
