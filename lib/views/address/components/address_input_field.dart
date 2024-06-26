import 'package:brn_ecommerce/common/buttons/custom_button.dart';
import 'package:brn_ecommerce/common/formatted_fields/custom_text_form_field.dart';
import 'package:brn_ecommerce/common/messengers/components/text_of_alerts_and_messengers.dart';
import 'package:brn_ecommerce/common/messengers/custom_scaffold_messenger.dart';
import 'package:brn_ecommerce/helpers/validators.dart';
import 'package:brn_ecommerce/models/locations_services/address.dart';
import 'package:brn_ecommerce/models/sales/cart_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddressInputField extends StatelessWidget {
  final Address address;

  const AddressInputField({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    final cartManager = context.watch<CartManager>();

    // Functions to remove context from async methods
    calculateShippingError() => CustomScaffoldMessenger(
          context: context,
          message: AlertsMessengersText.checkingDeliveryRadius,
          duration: const Duration(milliseconds: 4500),
        ).alertScaffold();

    if (address.zipCode != null && cartManager.deliveryPrice == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextFormField(
            initialValue: address.street,
            labelText: 'Logradouro',
            hintText: 'Av./Rua... Nome da Av./Rua...',
            validator: emptyValidator,
            onSaved: (value) => address.street = value,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                  child: CustomTextFormField(
                initialValue: address.number,
                labelText: 'Número',
                hintText: '123',
                textInputType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                validator: emptyValidator,
                onSaved: (value) => address.number = value,
              )),
              const SizedBox(width: 16),
              Expanded(
                  flex: 3,
                  child: CustomTextFormField(
                    initialValue: address.complement,
                    labelText: 'Complemento (Opcional)',
                    hintText: 'Opcional',
                    isDense: false,
                    onSaved: (value) => address.complement = value,
                  )),
            ],
          ),
          const SizedBox(height: 8),
          CustomTextFormField(
            initialValue: address.district,
            labelText: 'Bairro',
            hintText: 'Ex: Centro',
            validator: emptyValidator,
            onSaved: (value) => address.district = value,
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: CustomTextFormField(
                  initialValue: address.city,
                  enableTextEdit: false,
                  labelText: 'Cidade',
                  validator: emptyValidator,
                  onSaved: (value) => address.city = value,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                  child: CustomTextFormField(
                initialValue: address.state,
                enableTextEdit: false,
                labelText: 'UF',
                hintText: 'BA',
                validator: (value) {
                  emptyValidator(value);
                  if (value?.length != 2) {
                    return 'Inválido';
                  }
                  return null;
                },
                textCapitalization: TextCapitalization.characters,
                onSaved: (value) => address.state = value,
              )),
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
                          await cartManager.setAddress(address);
                        } catch (error) {
                          calculateShippingError();
                          cartManager.loading = false;
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
