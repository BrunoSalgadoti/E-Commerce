import 'package:brn_ecommerce/common/buttons/custom_icon_button.dart';
import 'package:brn_ecommerce/common/buttons/custom_text_button.dart';
import 'package:brn_ecommerce/common/formatted_fields/format_values.dart';
import 'package:brn_ecommerce/common/images/root_assets.dart';
import 'package:brn_ecommerce/common/messengers/custom_alertdialog_adaptive.dart';
import 'package:brn_ecommerce/common/miscellaneous/freight_logo.dart';
import 'package:brn_ecommerce/helpers/routes_navigator.dart';
import 'package:brn_ecommerce/models/products/cart_product.dart';
import 'package:brn_ecommerce/models/products/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartTile extends StatelessWidget {
  const CartTile({super.key, required this.cartProduct});

  final CartProduct? cartProduct;

  @override
  Widget build(BuildContext context) {
    // Handle the case where cartProduct is null
    return (cartProduct == null || cartProduct!.product == null)
        ? Container()
        : ChangeNotifierProvider.value(
            value: cartProduct,
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, RoutesNavigator.productDetailsScreen,
                    arguments: cartProduct?.product);
              },
              child: LayoutBuilder(builder: (context, constraints) {
                return ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 460),
                  child: Card(
                    margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                    semanticContainer: true,
                    clipBehavior: Clip.antiAlias,
                    elevation: 4,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Visibility(
                          visible: constraints.maxWidth <= 362 ? false : true,
                          child: Flexible(
                            child: Container(
                              constraints: const BoxConstraints(
                                  maxHeight: 155, minWidth: 100, maxWidth: 140),
                              color: Colors.transparent,
                              child: Stack(children: [
                                cartProduct?.product?.images == null ||
                                        cartProduct!.product!.images!.isEmpty
                                    ? Image.asset(
                                        RootAssets.noImagePng,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity,
                                      )
                                    : Image(
                                        image: NetworkImage(
                                          cartProduct?.product?.images?.first ?? "",
                                        ),
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity,
                                      ),
                                FreightLogo(
                                  containerHeight: 32,
                                  containerWidth: 50,
                                  text: null,
                                  product: cartProduct?.product ?? Product(),
                                ),
                              ]),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  cartProduct?.product?.name ?? "",
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                ),
                                if (cartProduct?.brand != null && cartProduct?.brand != "")
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 7),
                                    child: Text(
                                      'Marca: ${cartProduct?.brand ?? ""}',
                                      style: const TextStyle(fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 2),
                                  child: Text(
                                    'Tamanho: ${cartProduct?.size ?? ""}',
                                    style: const TextStyle(fontWeight: FontWeight.w300),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 2),
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        cartProduct!.realColorFromCart == Colors.transparent
                                            ? const Text(
                                                'Cor: Cor do produto',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              )
                                            : const Text('Cor: ', overflow: TextOverflow.ellipsis),
                                        Flexible(
                                          child: Container(
                                            width: 60,
                                            height: 20,
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: cartProduct!.realColorFromCart ==
                                                          Colors.transparent
                                                      ? Colors.grey.withOpacity(0.0)
                                                      : Colors.grey.withOpacity(0.5),
                                                  spreadRadius: 2,
                                                  blurRadius: 4,
                                                  offset: const Offset(0, 2),
                                                ),
                                              ],
                                            ),
                                            child: Container(
                                                color: cartProduct?.realColorFromCart ??
                                                    Colors.transparent),
                                          ),
                                        ),
                                      ]),
                                ),
                                Consumer<CartProduct>(
                                  builder: (_, cartProduct, __) {
                                    if (cartProduct.hasStock && cartProduct.hasAmount) {
                                      return Text(
                                        formattedRealText(cartProduct.unitPrice),
                                        style: TextStyle(
                                            color: Theme.of(context).primaryColor,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      );
                                    } else if (cartProduct.unitQuantityStock != 0) {
                                      return Text(
                                        'Sem estoque suficiente!\n'
                                        'QTD Disponível com esta cor: '
                                        '${cartProduct.unitQuantityAmount}\n'
                                        'QTD Disponível deste tamanho: '
                                        '${cartProduct.unitQuantityStock}',
                                        style: const TextStyle(color: Colors.red, fontSize: 12),
                                      );
                                    } else {
                                      return const Text(
                                        'Estoque Esgotado!',
                                        overflow: TextOverflow.ellipsis,
                                      );
                                    }
                                  },
                                ),
                              ]),
                        ),
                        Consumer<CartProduct>(builder: (_, cartProduct, __) {
                          return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                CustomIconButton(
                                  iconData: cartProduct.quantity! > cartProduct.unitQuantityStock ||
                                          cartProduct.quantity! > cartProduct.unitQuantityAmount
                                      ? Icons.not_interested
                                      : Icons.add,
                                  onTap: cartProduct.quantity! > cartProduct.unitQuantityStock ||
                                          cartProduct.quantity! > cartProduct.unitQuantityAmount
                                      ? () {}
                                      : cartProduct.increment,
                                  color: cartProduct.quantity! > cartProduct.unitQuantityStock ||
                                          cartProduct.quantity! > cartProduct.unitQuantityAmount
                                      ? Colors.red
                                      : Theme.of(context).primaryColor,
                                  semanticLabel: 'Incluir mais Itens',
                                ),
                                Text(
                                  '${cartProduct.quantity}',
                                  style: const TextStyle(fontSize: 20),
                                ),
                                CustomIconButton(
                                  iconData:
                                      cartProduct.quantity! == 1 ? Icons.delete : Icons.remove,
                                  onTap: cartProduct.quantity! <= 1
                                      ? () => CustomAlertDialogAdaptive(
                                              titleText: 'Confirmação de Exclusão',
                                              bodyText: 'Deseja realmente deletar\n '
                                                  '${cartProduct.product!.name}'
                                                  '${cartProduct.size} '
                                                  'do carrinho?',
                                              actions: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Flexible(
                                                      child: CustomTextButton(
                                                          text: 'Sim',
                                                          icon: null,
                                                          fontColor: Colors.red,
                                                          onPressed: () {
                                                            cartProduct.decrement();
                                                            Navigator.of(context).pop();
                                                          }),
                                                    ),
                                                    Flexible(
                                                      child: CustomTextButton(
                                                        text: 'NÃO',
                                                        icon: null,
                                                        fontSize: 18,
                                                        fontColor: Colors.green,
                                                        onPressed: () {
                                                          Navigator.of(context).pop();
                                                        },
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ]).alertContent(context)
                                      : cartProduct.decrement,
                                  color: cartProduct.quantity! > 1
                                      ? Theme.of(context).primaryColor
                                      : Colors.red,
                                  semanticLabel: 'Excluir Item',
                                ),
                              ]);
                        }),
                      ],
                    ),
                  ),
                );
              }),
            ),
          );
  }
}
