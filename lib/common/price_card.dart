import 'package:ecommerce/common/button/custom_button.dart';
import 'package:ecommerce/models/cart_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PriceCard extends StatelessWidget {
  const PriceCard({Key? key, required this.buttonText, required this.onPressed})
      : super(key: key);

  final String buttonText;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final cartManager = context.watch<CartManager>();
    final productsPrice = cartManager.productsPrice;
    final deliveryPrice = cartManager.deliveryPrice;
    final totalPrice = cartManager.totalPrice;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Resumo do pedido:',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Subtotal'),
                Text('R\$ ${productsPrice.toStringAsFixed(2)}')
              ],
            ),
            const Divider(),
            if(deliveryPrice != null)
              ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Entrega'),
                    Text('R\$ ${deliveryPrice.toStringAsFixed(2)}')
                  ],
                ),
                const Divider(),
              ],
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'R\$ ${totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 16),
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            CustomButton(
                texto: buttonText,
                fontSize: 12,
                onPressed: onPressed
            )
          ],
        ),
      ),
    );
  }
}
