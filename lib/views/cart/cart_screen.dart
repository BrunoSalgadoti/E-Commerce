import 'package:brn_ecommerce/common/advertising/advertising_widget.dart';
import 'package:brn_ecommerce/common/app_bar/custom_app_bar.dart';
import 'package:brn_ecommerce/common/buttons/custom_text_button.dart';
import 'package:brn_ecommerce/common/cards/price_card.dart';
import 'package:brn_ecommerce/common/cards/recently_added_products.dart';
import 'package:brn_ecommerce/common/cards/sales_suggestion_visited_products.dart';
import 'package:brn_ecommerce/common/drawer/components/page_manager.dart';
import 'package:brn_ecommerce/common/functions/common_functions.dart';
import 'package:brn_ecommerce/common/images/root_assets.dart';
import 'package:brn_ecommerce/common/messengers/components/text_of_alerts_and_messengers.dart';
import 'package:brn_ecommerce/common/miscellaneous/empty_page_indicator.dart';
import 'package:brn_ecommerce/common/advertising/info_marquee_widget.dart';
import 'package:brn_ecommerce/helpers/breakpoints.dart';
import 'package:brn_ecommerce/helpers/routes_navigator.dart';
import 'package:brn_ecommerce/helpers/themes/get_another_colors.dart';
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
            appBar: CustomAppBar(
              title: 'Meu Carrinho',
              showDrawerIcon: false,
              showSearchButton: false,
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
                            DecoratedGoogleFontText(
                              'O seu carrinho está vazio.',
                              fontMethod: GoogleFonts.merienda,
                              fillColor: Colors.amber,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              borderWidth: 0.4,
                              borderColor: getEspecialColor(),
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

                    final isWide = constraints.maxWidth >= mobileBreakpoint;

                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const AdvertisingWidget(),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: InfoMarqueeWidget(
                              text: AlertsMessengersText.infoMarqueeOfCartScreen,
                              color: getCustomAppBarColorBackground(),
                              fontWeight: FontWeight.w800,
                              glowColor: Colors.orange,
                              marqueeWidth: tabletBreakpoint,
                              onPressed: () {
                                // context.read<PageManager>().pageController.page(2)
                                context.read<PageManager>().setPage(2);
                                Navigator.of(context).pop();
                              },
                              marqueeSpeed: MediaQuery.of(context).size.width >= 900 ? 24 : 22,
                              marqueeStart: MediaQuery.of(context).size.width >= 900 ? 1.0 : 1.7,
                              marqueeEnd: MediaQuery.of(context).size.width >= 900 ? -1.0 : -1.5,
                            ),
                          ),
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: tabletBreakpoint),
                            child: isWide
                                ? Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // LEFT SIDE
                                      Expanded(
                                        flex: (constraints.minWidth < 1625) ? 7 : 8,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Wrap(
                                              spacing: 3,
                                              runSpacing: 3,
                                              children: cartManager.items
                                                  .map((cartProduct) =>
                                                      CartTile(cartProduct: cartProduct))
                                                  .toList(),
                                            ),
                                            const SizedBox(height: 15),
                                            SalesSuggestionVisitedProducts(), // “You may also like”
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                        // RIGHT SIDE
                                      Expanded(
                                        flex: (constraints.minWidth < 1625) ? 4 : 2,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Align(
                                              alignment: Alignment(-1, 0),
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                                child: textForGoogleDecorations(
                                                  titleForDecorations: 'Adicionados recentemente...',
                                                  fontMethod: GoogleFonts.amaranth,
                                                  borderWidth: 0.2,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                            RecentlyAddedProducts(carrossel: false),
                                            const SizedBox(height: 15),
                                            PriceCard(
                                              buttonText: 'Continuar para Entrega',
                                              onPressed: cartManager.isCartValid
                                                  ? () => Navigator.pushNamed(
                                                      context, RoutesNavigator.addressScreen)
                                                  : null,
                                              showIcon: false,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                : Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Wrap(
                                        spacing: 5,
                                        runSpacing: 5,
                                        alignment: WrapAlignment.center,
                                        children: cartManager.items
                                            .map(
                                                (cartProduct) => CartTile(cartProduct: cartProduct))
                                            .toList(),
                                      ),
                                      const SizedBox(height: 15),
                                      SalesSuggestionVisitedProducts(),
                                      const SizedBox(height: 15),
                                      PriceCard(
                                        buttonText: 'Continuar para Entrega',
                                        onPressed: cartManager.isCartValid
                                            ? () => Navigator.pushNamed(
                                                context, RoutesNavigator.addressScreen)
                                            : null,
                                        showIcon: false,
                                      ),
                                      Align(
                                        alignment: Alignment(-1, 0),
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                          child: textForGoogleDecorations(
                                            titleForDecorations: 'Adicionados recentemente...',
                                            fontMethod: GoogleFonts.amaranth,
                                            borderWidth: 0.2,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                      RecentlyAddedProducts(carrossel: false),
                                      const SizedBox(height: 15),
                                    ],
                                  ),
                          ),
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
