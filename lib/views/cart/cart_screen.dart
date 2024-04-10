import 'package:brn_ecommerce/common/advertising/advertising_widget.dart';
import 'package:brn_ecommerce/common/cards/price_card.dart';
import 'package:brn_ecommerce/common/miscellaneous/empty_page_indicator.dart';
import 'package:brn_ecommerce/common/miscellaneous/info_marquee_widget.dart';
import 'package:brn_ecommerce/helpers/routes_navigator.dart';
import 'package:brn_ecommerce/helpers/themes/factory_colors/get_another_colors.dart';
import 'package:brn_ecommerce/models/sales/cart_manager.dart';
import 'package:brn_ecommerce/views/cart/components/cart_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Carrinho'),
        centerTitle: true,
      ),
      body: Consumer<CartManager>(builder: (_, cartManager, __) {
        if (cartManager.items.isEmpty) {
          return const Center(
            child: EmptyPageIndicator(
              title: 'Nenhum item no carrinho!',
              iconData: null,
              image: "assets/images/goShopping.gif",
              duration: null,
            ),
          );
        }

        return ListView(
          children: [
            const AdvertisingWidget(),
            Column(
              children: cartManager.items
                  .map((cartProduct) => CartTile(
                        cartProduct: cartProduct,
                      ))
                  .toList(),
            ),
            InfoMarqueeWidget(
              text: 'Continue comprando em nossa loja!! Contamos com divérsos produtos em promoção,'
                  ' confira! Clique aqui! E boas compras!',
              color: getButtonColor(),
              glowColor: Colors.greenAccent.withAlpha(500),
              onPressed: () {
                Navigator.pushNamed(context, routesNavigator.productScreen);
              },
            ),
            PriceCard(
                buttonText: 'Continuar para Entrega',
                onPressed: cartManager.isCartValid
                    ? () {
                        Navigator.pushNamed(context, routesNavigator.addressScreen);
                      }
                    : null,
              showIcon: false),
          ],
        );
      }),
    );
  }
}
