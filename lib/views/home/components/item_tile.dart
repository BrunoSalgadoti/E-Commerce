import 'dart:io';

import 'package:brn_ecommerce/common/buttons/custom_button.dart';
import 'package:brn_ecommerce/common/formatted_fields/format_values.dart';
import 'package:brn_ecommerce/common/messengers/custom_alertdialog_adaptive.dart';
import 'package:brn_ecommerce/helpers/routes_navigator.dart';
import 'package:brn_ecommerce/models/home_sections/home_manager.dart';
import 'package:brn_ecommerce/models/home_sections/section.dart';
import 'package:brn_ecommerce/models/home_sections/section_item.dart';
import 'package:brn_ecommerce/models/products/product.dart';
import 'package:brn_ecommerce/models/products/product_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class ItemTile extends StatelessWidget {
  final SectionItem? item;
  final Product? product;

  /// Allows you to pass a SectionItem or a Product directly
  const ItemTile({super.key, this.item, this.product});

  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<HomeManager>();
    final prod = product ??
        (item?.product != null
            ? context.read<ProductManager>().findProductById(item!.product!)
            : null);

    void backScreen() => Navigator.of(context).pop();

    return GestureDetector(
      onTap: () {
        if (prod != null && prod.isValid!) {
          Navigator.pushNamed(
            context,
            RoutesNavigator.productDetailsScreen,
            arguments: prod,
          );
        }
      },
      onLongPress: () {
        if (homeManager.editing) {
          CustomAlertDialogAdaptive(
            titleText: 'Editar Item',
            titleColor: Colors.black,
            titleSize: 18,
            titleWeight: FontWeight.normal,
            bodyText: '',
            content: prod != null
                ? ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Image.network(prod.images!.first),
                    title: Text(prod.name!),
                    subtitle: !prod.hasStock
                        ? const Text(
                            'Fora de Estoque...',
                            style: TextStyle(color: Colors.red),
                          )
                        : Text(formattedRealText(prod.basePrice)),
                  )
                : const Text('Nenhum Item Vinculado a Imagem!'),
            actions: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomButton(
                        text: 'Excluir',
                        widthButton: 100,
                        heightButton: 40,
                        buttonColor: Colors.transparent,
                        textColor: Colors.red,
                        elevation: 0,
                        onPressed: () {
                          if (item != null) {
                            context.read<Section>().removeItem(item!);
                          }
                          backScreen();
                        }),
                    CustomButton(
                        text: prod != null ? 'Desvincular' : 'Vincular',
                        widthButton: 120,
                        heightButton: 40,
                        buttonColor: Colors.transparent,
                        textColor: Colors.blue,
                        elevation: 0,
                        onPressed: () async {
                          if (prod != null && item != null) {
                            item?.product = null;
                            backScreen();
                          } else if (item != null) {
                            final Product selectedProduct = await Navigator.pushNamed(
                                context, RoutesNavigator.selectProductScreen,
                                arguments: Product()) as Product;
                            item?.product = selectedProduct.id;
                            backScreen();
                          }
                        }),
                    CustomButton(
                        text: 'Voltar',
                        widthButton: 100,
                        heightButton: 40,
                        buttonColor: Colors.transparent,
                        textColor: Colors.blue,
                        elevation: 0,
                        onPressed: backScreen),
                  ],
                ),
              )
            ],
          ).alertContent(context);
        }
      },
      child: AspectRatio(
        aspectRatio: 1,
        child: item?.image != null
            ? (item!.image is String
                ? FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: item!.image as String,
                    fit: BoxFit.cover,
                  )
                : Image.file(
                    item!.image as File,
                    fit: BoxFit.cover,
                  ))
            : prod != null && prod.images!.isNotEmpty
                ? Image.network(prod.images!.first, fit: BoxFit.fitHeight)
                : Container(color: Colors.grey[200]),
      ),
    );
  }
}
