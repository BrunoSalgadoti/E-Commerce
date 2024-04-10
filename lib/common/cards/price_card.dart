import 'package:brn_ecommerce/common/buttons/custom_button.dart';
import 'package:brn_ecommerce/common/buttons/custom_icon_button.dart';
import 'package:brn_ecommerce/common/formatted_fields/format_values.dart';
import 'package:brn_ecommerce/helpers/routes_navigator.dart';
import 'package:brn_ecommerce/models/sales/cart_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// ## PriceCard
/// Widget that displays a summary of the order with subtotal, delivery cost, and total price.
class PriceCard extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed; // Function called when the button is pressed.
  final bool showIcon;

  /// Create a PriceCard widget.
  ///
  /// The parameter [buttonText] is required and represents the text displayed on the button.
  ///
  /// The parameter [onPressed] is a function called when the button is pressed.
  const PriceCard({
    super.key,
    required this.buttonText,
    required this.onPressed,
    required this.showIcon,
  });

  @override
  Widget build(BuildContext context) {
    final cartManager = context.watch<CartManager>();
    final productsPrice = cartManager.productsPrice;
    final deliveryPrice = cartManager.deliveryPrice;
    final totalPrice = cartManager.totalPrice;
    final totalItens = cartManager.totalQuantity;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40, 30, 40, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Visibility(
                  visible: showIcon == false ? false : true,
                  child: CustomIconButton(
                      iconData: Icons.add_shopping_cart_rounded,
                      padding: EdgeInsets.zero,
                      semanticLabel: 'Voltar \n ao carrinho',
                      onTap: () =>
                          Navigator.popUntil(context, (route) => route.settings.name == routesNavigator.cartScreen)),
                ),
              ],
            ),
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
              mainAxisSize: MainAxisSize.min,
              children: [
                const Expanded(child: Text('Total de ítens:')),
                Expanded(
                  child: Text(
                    totalItens.toString(),
                    textAlign: TextAlign.end,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: Text(
                    'Subtotal:',
                  ),
                ),
                Expanded(
                  child: Text(
                    formattedRealText(productsPrice),
                    textAlign: TextAlign.end,
                  ),
                )
              ],
            ),
            const Divider(),
            if (deliveryPrice != null && cartManager.hasFreeShippingProduct) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(child: Text('Envio:')),
                  Expanded(
                    child: Text(
                      formattedRealText(deliveryPrice),
                      textAlign: TextAlign.end,
                    ),
                  )
                ],
              ),
              const Divider(),
            ] else ...[
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text('Envio:')),
                  Expanded(
                    child: Text(
                      'Frete Grátis',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.green,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(),
            ],
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: Text(
                    'Total:',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    formattedRealText(totalPrice),
                    textAlign: TextAlign.end,
                    style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16),
                  ),
                ),
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
