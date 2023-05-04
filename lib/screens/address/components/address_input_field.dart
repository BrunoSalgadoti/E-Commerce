import 'package:ecommerce/models/address.dart';
import 'package:flutter/material.dart';

class AddressInputField extends StatelessWidget {
   const AddressInputField({super.key, required this.address});

  final Address address;

  @override
  Widget build(BuildContext context) {

    String? emptyValidator(String? text) =>
        text!.isEmpty ? 'Campo Obrigatório' : null;

    return Column(
      children: [
        TextFormField(
          initialValue: address.street,
          decoration: const InputDecoration(
            isDense: true,
            labelText: 'Rua/Avenida',
            hintText: 'Av. Apolônio Sales',
            hintStyle: TextStyle(
              color: Colors.black26
            )
          ),
          validator: emptyValidator,
          onSaved: (s) =>  address.street = s,
        ),
      ],
    );
  }
}
