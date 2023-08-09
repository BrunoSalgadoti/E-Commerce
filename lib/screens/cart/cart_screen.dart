import 'package:brn_ecommerce/common/empty_page_indicator.dart';
import 'package:brn_ecommerce/common/cards/price_card.dart';
import 'package:brn_ecommerce/models/cart_manager.dart';
import 'package:brn_ecommerce/screens/cart/components/cart_tile.dart';
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
      body: Consumer<CartManager>(builder: (_, cartManager, __) {
        if (cartManager.items.isEmpty) {
          return const Center(
            child: EmptyPageIndicator(
              title: 'Nenhum item no carrinho!',
              iconData: null,
              image: "assets/images/goShopping.gif",
            ),
          );
        }

        return ListView(
          children: [
            Column(
              children: cartManager.items
                  .map((cartProduct) => CartTile(
                        cartProduct: cartProduct,
                      )).toList(),
            ),
            PriceCard(
                buttonText: 'Continuar para Entrega',
                onPressed: cartManager.isCartValid
                    ? () {
                        Navigator.pushNamed(context, "/address");
                      }
                    : null),
          ],
        );
      }),
    );
  }
}
