import 'package:ecommerce/common/button/custom_button.dart';
import 'package:ecommerce/models/address.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddressInputField extends StatelessWidget {
  const AddressInputField({super.key, required this.address});

  final Address address;

  @override
  Widget build(BuildContext context) {
    String? emptyValidator(String? text) =>
        text!.isEmpty ? 'Campo Obrigatório' : null;

    if (address.zipCode != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            initialValue: address.street,
            decoration: const InputDecoration(
                isDense: true,
                labelText: 'Rua/Avenida',
                hintText: 'Av. Apolônio Sales',
                hintStyle: TextStyle(color: Colors.black26)),
            validator: emptyValidator,
            onSaved: (s) => address.street = s,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  initialValue: address.number,
                  decoration: const InputDecoration(
                    isDense: true,
                    labelText: 'Número',
                    hintText: '123',
                    hintStyle: TextStyle(color: Colors.black26),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  keyboardType: TextInputType.number,
                  validator: emptyValidator,
                  onSaved: (n) => address.number = n,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                  child: TextFormField(
                initialValue: address.complement,
                decoration: const InputDecoration(
                  isDense: true,
                  labelText: 'Complemento',
                  hintText: 'Opcional',
                  hintStyle: TextStyle(color: Colors.black26),
                ),
                onSaved: (c) => address.complement = c,
              ))
            ],
          ),
          TextFormField(
            initialValue: address.district,
            decoration: const InputDecoration(
              isDense: true,
              labelText: 'Bairro',
              hintText: 'Centro',
              hintStyle: TextStyle(color: Colors.black26),
            ),
            validator: emptyValidator,
            onSaved: (d) => address.district = d,
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: TextFormField(
                  enabled: false,
                  initialValue: address.city,
                  style: const TextStyle(color: Colors.black45),
                  decoration: const InputDecoration(
                    isDense: true,
                    labelText: 'Cidade',
                    hintText: 'Paulo Afonso',
                    hintStyle: TextStyle(color: Colors.black26),
                  ),
                  validator: emptyValidator,
                  onSaved: (c) => address.city = c,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  enabled: false,
                  textCapitalization: TextCapitalization.characters,
                  initialValue: address.state,
                  style: const TextStyle(color: Colors.black45),
                  decoration: const InputDecoration(
                    isDense: true,
                    labelText: 'UF',
                    hintText: 'BA',
                    counterText: '',
                    hintStyle: TextStyle(color: Colors.black26),
                  ),
                  maxLength: 2,
                  validator: (e) {
                    if (e!.isEmpty) {
                      return 'Campo Obrigatório';
                    } else if (e.length != 2) {
                      return 'Inválido';
                    }
                    return null;
                  },
                  onSaved: (st) => address.state = st,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          CustomButton(texto: 'Calcular Frete', onPressed: () {}),
        ],
      );
    }
    return Container();
  }
}
