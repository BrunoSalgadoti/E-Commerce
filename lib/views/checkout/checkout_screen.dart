import 'package:brn_ecommerce/common/buttons/custom_text_button.dart';
import 'package:brn_ecommerce/common/cards/price_card.dart';
import 'package:brn_ecommerce/common/messengers/custom_scaffold_messenger.dart';
import 'package:brn_ecommerce/models/sales/cart_manager.dart';
import 'package:brn_ecommerce/models/sales/checkout_manager.dart';
import 'package:brn_ecommerce/views/checkout/components/credit_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatelessWidget {
  CheckoutScreen({
    super.key,
  });

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final iconSize = screenHeight * 0.043;
    final fontSize = screenHeight * 0.025;

    return ChangeNotifierProxyProvider<CartManager, CheckoutManager>(
      create: (_) => CheckoutManager(),
      update: (_, cartManager, checkoutManager) => checkoutManager!..updateCart(cartManager),
      lazy: false,
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                snap: true,
                floating: true,
                elevation: 4,
                backgroundColor: Colors.green,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text('Pagamento Seguro!',
                      style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold)),

                  // centerTitle: true,
                ),
                actions: [
                  const SizedBox(width: 150),
                  CustomTextButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero)),
                    imageAssetsTarget: 'assets/icons/locked.svg',
                    imageWidth: iconSize,
                    imageHeight: iconSize,
                    isSvg: true,
                    onPressed: null,
                  ),
                  CustomTextButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero)),
                    imageAssetsTarget: 'assets/icons/firebase.svg',
                    imageWidth: iconSize,
                    imageHeight: iconSize,
                    isSvg: true,
                    onPressed: null,
                  ),
                  const SizedBox(width: 16)
                ],
              ),
              Consumer<CheckoutManager>(
                builder: (_, checkoutManager, __) {
                  if (checkoutManager.loading) {
                    return const SliverToBoxAdapter(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Processando seu pagamento...',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                  return const SliverToBoxAdapter(child: SizedBox.shrink());
                },
              ),
              SliverToBoxAdapter(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const CreditCardWidget(),
                      Consumer<CheckoutManager>(
                        builder: (_, checkoutManager, __) {
                          return PriceCard(
                            buttonText: 'Finalizar Pedido',
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                debugPrint('enviar!!');

                                checkoutManager.checkout(onStockFail: (error) {
                                  CustomScaffoldMessenger(context: context, message: '$error')
                                      .alertScaffold();
                                  Navigator.popUntil(
                                      context, (route) => route.settings.name == "/cart");
                                }, onSuccess: (order) {
                                  Navigator.popUntil(
                                      context, (route) => route.settings.name == "/product");
                                  Navigator.pushReplacementNamed(context, "/sales_confirmation",
                                      arguments: order);
                                });
                              }
                            },
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
