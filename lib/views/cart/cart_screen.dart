import 'package:brn_ecommerce/common/advertising/advertising_widget.dart';
import 'package:brn_ecommerce/common/buttons/custom_text_button.dart';
import 'package:brn_ecommerce/common/cards/price_card.dart';
import 'package:brn_ecommerce/common/drawer/components/page_manager.dart';
import 'package:brn_ecommerce/common/images/root_assets.dart';
import 'package:brn_ecommerce/common/messengers/components/text_of_alerts_and_messengers.dart';
import 'package:brn_ecommerce/common/miscellaneous/empty_page_indicator.dart';
import 'package:brn_ecommerce/common/miscellaneous/info_marquee_widget.dart';
import 'package:brn_ecommerce/helpers/routes_navigator.dart';
import 'package:brn_ecommerce/helpers/themes/factory_colors/get_another_colors.dart';
import 'package:brn_ecommerce/models/sales/cart_manager.dart';
import 'package:brn_ecommerce/views/cart/components/cart_tile.dart';
import 'package:decorated_text/decorated_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
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
      body: Consumer2<CartManager, PageManager>(builder: (_, cartManager, pageManager, __) {
        if (cartManager.items.isEmpty) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 100, 20, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                const DecoratedGoogleFontText(
                  'O seu carrinho está vazio.',
                  fontMethod: GoogleFonts.merienda,
                  fillColor: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  borderWidth: 0.4,
                  borderColor: Colors.white,
                ),
                CustomTextButton(
                  onPressed: () {
                    context.read<PageManager>().setPage(2);
                    Navigator.of(context).pop();
                  },
                  text: 'Adicionar item ao carrinho',
                  icon: const Icon(FontAwesomeIcons.cartShopping),
                ),
                const EmptyPageIndicator(
                  title: '',
                  iconData: null,
                  image: rootAssets.goShoppingCartPng,
                  duration: null,
                ),
              ],
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
              text: alertsMessengersText.infoMarqueeOfCartScreen,
              color: getButtonColor(),
              glowColor: Colors.greenAccent.withAlpha(500),
              onPressed: () {
                context.read<PageManager>().setPage(1);
                Navigator.of(context).pop();
              },
            ),
            PriceCard(
                buttonText: 'Continuar para Entrega',
                onPressed: cartManager.isCartValid
                    ? () => Navigator.pushNamed(context, routesNavigator.addressScreen)
                    : null,
                showIcon: false),
          ],
        );
      }),
    );
  }
}
