import 'package:ecommerce/common/price_card.dart';
import 'package:ecommerce/models/cart_manager.dart';
import 'package:ecommerce/screens/address/components/address_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrega'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const AddressCard(),
          Consumer<CartManager>(
              builder: (_, cartManager, __) {
            return PriceCard(
              buttonText: 'Continuar para Pagamento',
              onPressed: cartManager.isAddressValid ? () {
                Navigator.pushNamed(context, '/checkout');
              } : null,
            );
          })
        ],
      ),
    );
  }
}
