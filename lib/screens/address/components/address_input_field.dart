import 'package:brn_ecommerce/common/button/custom_button.dart';
import 'package:brn_ecommerce/models/address.dart';
import 'package:brn_ecommerce/models/cart_manager.dart';
import 'package:brn_ecommerce/models/delivery.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddressInputField extends StatelessWidget {
  const AddressInputField(
      {super.key, required this.address, required this.delivery});

  final Address address;
  final Delivery delivery;

  @override
  Widget build(BuildContext context) {
    final cartManager = context.watch<CartManager>();

    String? emptyValidator(String? text) =>
        text!.isEmpty ? 'Campo Obrigatório' : null;

    if (address.zipCode != null && cartManager.deliveryPrice == null) {
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
          const SizedBox(height: 8),
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
                  flex: 3,
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
          const SizedBox(height: 8),
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
          const SizedBox(height: 15),
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
          Consumer<CartManager>(builder: (_, cartManager, __) {
            return CustomButton(
              text: 'Calcular Frete',
              onPressed: !cartManager.loading
                  ? () async {
                      if (Form.of(context).validate()) {
                        Form.of(context).save();
                        try {
                          await cartManager.saveAuxDelivery(delivery);
                          await cartManager.setAddress(address);
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
                  : null,
            );
          })
        ],
      );
    } else if (address.zipCode != null) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 10, top: 05),
        child: Text(
          '${address.street}, ${address.number}\n'
          '${address.district}\n'
          '${address.city} - ${address.state}\n'
          '\n${address.complement ?? ''}',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
