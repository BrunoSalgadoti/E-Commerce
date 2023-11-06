import 'package:brn_ecommerce/models/address.dart';
import 'package:brn_ecommerce/models/cart_manager.dart';
import 'package:brn_ecommerce/models/delivery.dart';
import 'package:brn_ecommerce/screens/address/components/address_input_field.dart';
import 'package:brn_ecommerce/screens/address/components/cep_input_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Consumer<CartManager>(
            builder: (_, cartManager, __) {
              final address = cartManager.address ?? Address();
              final delivery = cartManager.delivery ?? Delivery();

              return Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Endereço de Entrega',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    CepInputField(
                      address: address,
                    ),
                    AddressInputField(
                      address: address,
                      delivery: delivery,
                    ),
                  ],
                ),
              );
            },
          )),
    );
  }
}
