import 'package:brn_ecommerce/helpers/routes_navigator.dart';
import 'package:brn_ecommerce/models/products/cart_product.dart';
import 'package:flutter/material.dart';

import '../../../common/formatted_fields/format_values.dart';

class OrderProductTile extends StatelessWidget {
  const OrderProductTile(
    this.cartProduct, {
    super.key,
  });

  final CartProduct? cartProduct;

  @override
  Widget build(BuildContext context) {
    final fixedOrUnityPrice = cartProduct?.fixedPrice ?? cartProduct?.unitPrice ?? 0.0;
    final imageNotAvailable =
        cartProduct!.product?.images == null || cartProduct!.product!.images!.isEmpty;

    return GestureDetector(
      onTap: () {
        if (!imageNotAvailable) {
          Navigator.pushNamed(context, routesNavigator.productDetailsScreen, arguments: cartProduct?.product);
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: imageNotAvailable
                  ? Image.asset(
                      'assets/images/noImage.png',
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      cartProduct!.product!.images!.first,
                      fit: BoxFit.cover,
                    ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartProduct?.product?.name ?? 'Produto indisponível',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      'Tamanho: ${cartProduct?.size ?? 'Tamanho não encontrado'}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          cartProduct!.realColorFromCart == Colors.transparent
                              ? const Text('Cor: Cor da foto')
                              : const Text('Cor: '),
                          Container(
                            width: 60,
                            height: 20,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: cartProduct!.realColorFromCart == Colors.transparent
                                      ? Colors.grey.withOpacity(0.0)
                                      : Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Container(
                              color: cartProduct?.realColorFromCart ?? Colors.transparent,
                            ),
                          ),
                        ],
                      )),
                  Text(
                    formattedRealText(fixedOrUnityPrice),
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Text(
                  '${cartProduct?.quantity}',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'QTD.',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
