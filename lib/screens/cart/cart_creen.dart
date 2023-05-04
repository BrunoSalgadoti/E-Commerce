import 'package:ecommerce/common/price_card.dart';
import 'package:ecommerce/models/cart_manager.dart';
import 'package:ecommerce/screens/cart/components/cart_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
        centerTitle: true,
      ),

      body: Consumer<CartManager>(
        builder: (_, cartManager, __) {
          return ListView(
            children: [
              Column(
                children: cartManager.items.map(
                        (cartProduct) => CartTile(cartProduct: cartProduct,)
                ).toList(),
              ),
               PriceCard(
                buttonText: 'Continuar para Entrega',
                onPressed: cartManager.isCartValid
                    ? () {
                  Navigator.pushNamed(context, '/address_screen');

                } : null
              ),
            ],
          );
        }
      ),
    );
  }
}
