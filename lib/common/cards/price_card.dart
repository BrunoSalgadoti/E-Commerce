import 'package:brn_ecommerce/common/button/custom_button.dart';
import 'package:brn_ecommerce/common/formated_fields/format_values.dart';
import 'package:brn_ecommerce/models/cart_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PriceCard extends StatelessWidget {
  const PriceCard({
    Key? key,
    required this.buttonText,
    required this.onPressed,
  }) : super(key: key);

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
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
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
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Subtotal'),
                Text(formattedRealText(productsPrice))
              ],
            ),
            const Divider(),
            if (deliveryPrice != null) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Entrega'),
                  Text(formattedRealText(deliveryPrice))
                ],
              ),
              const Divider(),
            ],
            const SizedBox(height: 12),
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
                  formattedRealText(totalPrice),
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16
                  ),
                )
              ],
            ),
            const SizedBox(height: 8),
            CustomButton(
              text: buttonText,
              onPressed: onPressed,
            )
          ],
        ),
      ),
    );
  }
}
