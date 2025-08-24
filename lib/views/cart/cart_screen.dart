import 'package:brn_ecommerce/common/advertising/advertising_widget.dart';
import 'package:brn_ecommerce/common/buttons/custom_text_button.dart';
import 'package:brn_ecommerce/common/cards/price_card.dart';
import 'package:brn_ecommerce/common/drawer/components/page_manager.dart';
import 'package:brn_ecommerce/common/images/root_assets.dart';
import 'package:brn_ecommerce/common/messengers/components/text_of_alerts_and_messengers.dart';
import 'package:brn_ecommerce/common/miscellaneous/empty_page_indicator.dart';
import 'package:brn_ecommerce/common/advertising/info_marquee_widget.dart';
import 'package:brn_ecommerce/helpers/breakpoints.dart';
import 'package:brn_ecommerce/helpers/routes_navigator.dart';
import 'package:brn_ecommerce/models/sales/cart_manager.dart';
import 'package:brn_ecommerce/views/cart/components/cart_tile.dart';
import 'package:decorated_text/decorated_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: kIsWeb ? const EdgeInsets.only(top: 0) : MediaQuery.of(context).padding,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: wildBreakpoint),
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Meu Carrinho'),
              centerTitle: true,
            ),
            body: LayoutBuilder(
              builder: (context, constraints) {
                return Consumer2<CartManager, PageManager>(
                  builder: (_, cartManager, pageManager, __) {
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
                              image: RootAssets.goShoppingCartGif,
                              duration: null,
                            ),
                          ],
                        ),
                      );
                    }
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const AdvertisingWidget(),
                          Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 15),
                            child: InfoMarqueeWidget(
                              text: AlertsMessengersText.infoMarqueeOfCartScreen,
                              color: const Color.fromARGB(197, 225, 218, 218),
                              fontWeight: FontWeight.w800,
                              glowColor: const Color.fromARGB(255, 81, 255, 255),
                              marqueeWidth: tabletBreakpoint,
                              onPressed: () {
                                context.read<PageManager>().setPage(1);
                                Navigator.of(context).pop();
                              },
                              marqueeSpeed: MediaQuery.of(context).size.width >= 900 ? 24 : 22,
                              marqueeStart: MediaQuery.of(context).size.width >= 900 ? 1.0 : 1.7,
                              marqueeEnd: MediaQuery.of(context).size.width >= 900 ? -1.0 : -1.5,
                            ),
                          ),
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: tabletBreakpoint),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Wrap(
                                      alignment: WrapAlignment.center,
                                      runAlignment: WrapAlignment.center,
                                      crossAxisAlignment: WrapCrossAlignment.center,
                                      children: [
                                        Container(
                                          constraints: BoxConstraints(
                                            maxWidth: constraints.maxWidth >= tabletBreakpoint
                                                ? tabletBreakpoint / 100 * 70
                                                : tabletBreakpoint,
                                          ),
                                          child: Wrap(
                                            alignment: WrapAlignment.center,
                                            runAlignment: WrapAlignment.center,
                                            crossAxisAlignment: WrapCrossAlignment.center,
                                            children: cartManager.items
                                                .map(
                                                  (cartProduct) =>
                                                      CartTile(cartProduct: cartProduct),
                                                )
                                                .toList(),
                                          ),
                                        ),
                                        Container(
                                          constraints: BoxConstraints(
                                              maxWidth: constraints.maxWidth >= tabletBreakpoint
                                                  ? tabletBreakpoint / 100 * 30
                                                  : tabletBreakpoint / 100 * 80),
                                          child: PriceCard(
                                              buttonText: 'Continuar para Entrega',
                                              onPressed: cartManager.isCartValid
                                                  ? () => Navigator.pushNamed(
                                                      context, RoutesNavigator.addressScreen)
                                                  : null,
                                              showIcon: false),
                                        ),
                                      ]),
                                ]),
                          )
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
