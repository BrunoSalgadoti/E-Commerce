import 'package:brn_ecommerce/common/cards/price_card.dart';
import 'package:brn_ecommerce/models/cart_manager.dart';
import 'package:brn_ecommerce/models/checkout_manager.dart';
import 'package:brn_ecommerce/screens/checkout/components/credit_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatelessWidget {
  CheckoutScreen({
    Key? key,
  }) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<CartManager, CheckoutManager>(
      create: (_) => CheckoutManager(),
      update: (_, cartManager, checkoutManager) =>
          checkoutManager!..updateCart(cartManager),
      lazy: false,
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Pagamento'),
            centerTitle: true,
          ),
          body: Consumer<CheckoutManager>(
            builder: (_, checkoutManager, __) {
              if (checkoutManager.loading) {
                return const Center(
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
                );
              }

              return Form(
                key: formKey,
                child: ListView(
                  children: [
                   CreditCardWidget(),
                    PriceCard(
                      buttonText: 'Finalizar Pedido',
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          debugPrint('enviar!!');

                          /*checkoutManager.checkout(onStockFail: (error) {
                            CustomScaffoldMessenger(
                                context: context,
                                message: '$error'
                            ).msn();
                            Navigator.popUntil(
                                context, (route) => route.settings.name == "/cart");
                          }, onSuccess: (order) {
                            Navigator.popUntil(context,
                                    (route) => route.settings.name == "/product");
                            Navigator.pushNamed(context, "/sales_confirmation",
                                arguments: order);
                          });*/
                        }
                      },
                    )
                  ],
                ),
              );
            },
          )),
    );
  }
}
