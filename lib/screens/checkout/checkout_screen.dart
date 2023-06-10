import 'package:brn_ecommerce/common/price_card.dart';
import 'package:brn_ecommerce/models/cart_manager.dart';
import 'package:brn_ecommerce/models/checkout_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({
    Key? key,
  }) : super(key: key);

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
                      SizedBox(
                        height: 16,
                      ),
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

              return ListView(
                children: [
                  PriceCard(
                    buttonText: 'Finalizar Pedido',
                    onPressed: () {
                      checkoutManager.checkout(onStockFail: (error) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('$error',
                              style: const TextStyle(fontSize: 18)),
                          backgroundColor: Colors.red,
                          duration: const Duration(seconds: 5),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          margin: const EdgeInsets.all(15),
                        ));
                        Navigator.popUntil(
                            context, (route) => route.settings.name == '/cart');
                      }, onSuccess: (order) {
                        Navigator.popUntil(
                            context, (route) => route.settings.name == '/');
                        Navigator.pushNamed(context, '/sales_confirmation',
                            arguments: order);
                      });
                    },
                  )
                ],
              );
            },
          )),
    );
  }
}
