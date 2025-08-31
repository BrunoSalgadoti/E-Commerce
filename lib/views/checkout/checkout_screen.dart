import 'package:brn_ecommerce/common/Progress_indicators/custom_loading_overlay.dart';
import 'package:brn_ecommerce/common/app_bar/complement_app_bar.dart';
import 'package:brn_ecommerce/common/app_bar/custom_app_bar.dart';
import 'package:brn_ecommerce/common/buttons/custom_text_button.dart';
import 'package:brn_ecommerce/common/cards/price_card.dart';
import 'package:brn_ecommerce/common/images/root_assets.dart';
import 'package:brn_ecommerce/common/messengers/custom_scaffold_messenger.dart';
import 'package:brn_ecommerce/helpers/breakpoints.dart';
import 'package:brn_ecommerce/helpers/routes_navigator.dart';
import 'package:brn_ecommerce/models/sales/checkout_manager.dart';
import 'package:brn_ecommerce/views/checkout/components/credit_card_widget.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatelessWidget {
  CheckoutScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FlipCardState> creditCardKey = GlobalKey<FlipCardState>();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final iconSize = screenHeight * 0.043;

    return Consumer<CheckoutManager>(
      builder: (_, checkoutManager, __) {
        return Scaffold(
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
              children: [
                // Main content
                CustomScrollView(
                  slivers: [
                    ComplementAppBar(
                      asSliver: true,
                      padding: kIsWeb ? EdgeInsets.only(bottom: 10) : EdgeInsets.only(top: 30),
                    ),
                    CustomAppBar(
                      title: 'Pagamento Seguro -->',
                      showDrawerIcon: false,
                      showSearchButton: false,
                      isSilver: true,
                      backgroundColor: Colors.green,
                      titleColor: Colors.yellow,
                      buttonColor: Colors.yellow,
                      removePadding: true,
                      actions: [
                        CustomTextButton(
                          text: screenWidth <= mobileBreakpoint ? '' : 'Dados seguros',
                          fontColor: Colors.yellow,
                          buttonStyle: ButtonStyle(
                            padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.zero),
                          ),
                          imageAssetsTarget: RootAssets.iconPadlock,
                          imageWidth: iconSize,
                          imageHeight: iconSize,
                          isSvg: true,
                          onPressed: null,
                        ),
                        CustomTextButton(
                          text: screenWidth <= mobileBreakpoint ? '' : 'Segurança Firebase',
                          fontColor: Colors.yellow,
                          buttonStyle: ButtonStyle(
                            padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.zero),
                          ),
                          imageAssetsTarget: RootAssets.iconFirebaseLogo,
                          imageWidth: iconSize,
                          imageHeight: iconSize,
                          isSvg: true,
                          onPressed: null,
                        ),
                        const SizedBox(width: 18),
                      ],
                    ),
                    SliverToBoxAdapter(
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            CreditCardWidget(cardKey: creditCardKey),
                            PriceCard(
                              buttonText: 'Finalizar Pedido',
                              showIcon: true,
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  checkoutManager.checkout(
                                    onStockFail: (error) {
                                      CustomScaffoldMessenger(context: context, message: '$error')
                                          .alertScaffold();
                                      Navigator.popUntil(
                                          context,
                                          (route) =>
                                              route.settings.name == RoutesNavigator.cartScreen);
                                    },
                                    onSuccess: (order) {
                                      Navigator.popUntil(
                                          context,
                                          (route) =>
                                              route.settings.name ==
                                              RoutesNavigator.productDetailsScreen);
                                      Navigator.pushNamed(
                                        context,
                                        RoutesNavigator.salesConfirmationScreen,
                                        arguments: order,
                                      );
                                    },
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                // Loading overlay
                if (checkoutManager.loading) CustomLoadingOverlay()
              ],
            ),
          ),
        );
      },
    );
  }
}
