import 'package:brn_ecommerce/common/formatted_fields/format_values.dart';
import 'package:brn_ecommerce/common/images/root_assets.dart';
import 'package:brn_ecommerce/helpers/routes_navigator.dart';
import 'package:brn_ecommerce/models/products/cart_product.dart';
import 'package:flutter/material.dart';

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
          Navigator.pushNamed(context, RoutesNavigator.productDetailsScreen,
              arguments: cartProduct?.product);
        }
      },
      child: LayoutBuilder(builder: (context, constraints) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              imageNotAvailable
                  ? FittedBox(
                      child: Image.asset(RootAssets.noImagePng,
                          height: constraints.maxWidth > 300 ? 100 : constraints.maxWidth * 0.22,
                          width: constraints.maxWidth > 300 ? 150 : constraints.maxWidth * 0.25,
                          fit: BoxFit.fill))
                  : FittedBox(
                      child: Image.network(cartProduct!.product!.images!.first,
                          height: constraints.maxWidth > 300 ? 100 : constraints.maxWidth * 0.22,
                          width: constraints.maxWidth > 300 ? 150 : constraints.maxWidth * 0.25,
                          fit: BoxFit.fill)),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cartProduct?.product?.name ?? 'Produto indisponível',
                      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
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
                              ? const Flexible(child: Text(maxLines: 2, 'Cor: Cor da foto'))
                              : const Flexible(
                                  child: Text('Cor:  '),
                                ),
                          Flexible(
                            child: Container(
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
                                      offset: const Offset(0, 2)),
                                ],
                              ),
                              child: Container(
                                  color: cartProduct?.realColorFromCart ?? Colors.transparent),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(formattedRealText(fixedOrUnityPrice),
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Column(
                children: [
                  Text('${cartProduct?.quantity}',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const Text('Qtd.', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))
                ],
              )
            ],
          ),
        );
      }),
    );
  }
}
