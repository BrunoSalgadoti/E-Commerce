import 'package:brn_ecommerce/common/buttons/custom_button.dart';
import 'package:brn_ecommerce/common/formatted_fields/format_values.dart';
import 'package:brn_ecommerce/models/sales/cart_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// ## PriceCard
/// Widget that displays a summary of the order with subtotal, delivery cost, and total price.
class PriceCard extends StatelessWidget {
  /// Create a PriceCard widget.
  ///
  /// The parameter [buttonText] is required and represents the text displayed on the button.
  ///
  /// The parameter [onPressed] is a function called when the button is pressed.
  const PriceCard({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  final String buttonText;
  final VoidCallback? onPressed; // Function called when the button is pressed.

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
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [const Text('Subtotal'), Text(formattedRealText(productsPrice))],
            ),
            const Divider(),
            if (deliveryPrice != null && cartManager.hasFreeShippingProduct) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [const Text('Entrega'), Text(formattedRealText(deliveryPrice))],
              ),
              const Divider(),
            ] else ...[
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Entrega'),
                  Text(
                    'Frete Grátis',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.green,
                      fontSize: 14,
                    ),
                  )
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
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  formattedRealText(totalPrice),
                  style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16),
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
