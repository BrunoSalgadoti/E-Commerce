import 'dart:io';

import 'package:brn_ecommerce/common/button/custom_button.dart';
import 'package:brn_ecommerce/common/custom_messengers/custom_alert_dialog.dart';
import 'package:brn_ecommerce/models/home_manager.dart';
import 'package:brn_ecommerce/models/product.dart';
import 'package:brn_ecommerce/models/product_manager.dart';
import 'package:brn_ecommerce/models/section.dart';
import 'package:brn_ecommerce/models/section_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../common/formatted_fields/format_values.dart';

class ItemTile extends StatelessWidget {
  const ItemTile({Key? key, this.item}) : super(key: key);

  final SectionItem? item;

  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<HomeManager>();
    backScreen() => Navigator.of(context).pop();
    final product = context
        .read<ProductManager>()
        .findProductById(item?.product != null ? item!.product! : '');

    return GestureDetector(
        onTap: () {
          if (item?.product != null) {
            if (product != null && product.isValid!) {
              Navigator.pushNamed(context, "/product", arguments: product);
            }
          }
        },
        onLongPress: homeManager.editing
            ? () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return CustomAlertDialog(
                          titleText: 'Editar Item',
                          titleColor: Colors.black,
                          titleSize: 18,
                          titleWeight: FontWeight.normal,
                          bodyText: '',
                          content: product != null
                              ? ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading:
                                      Image.network(product.images!.first),
                                  title: Text(product.name!),
                                  subtitle: !product.hasStock
                                      ? const Text(
                                          'Fora de Estoque...',
                                          style: TextStyle(color: Colors.red),
                                        )
                                      : Text(formattedRealText(
                                          product.basePrice)),
                                )
                              : const Text('Nenhum Item Vinculado'
                                  ' a Imagem!'),
                          actions: [
                            CustomButton(
                                text: 'Excluir',
                                buttonColor: Colors.transparent,
                                textColor: Colors.red,
                                elevation: 0,
                                onPressed: () {
                                  context.read<Section>().removeItem(item!);
                                  Navigator.of(context).pop();
                                }),
                            CustomButton(
                                text: product != null
                                    ? 'Desvincular'
                                    : 'Vincular',
                                buttonColor: Colors.transparent,
                                textColor: Colors.blue,
                                elevation: 0,
                                onPressed: () async {
                                  if (product != null) {
                                    item?.product = null;
                                    Navigator.of(context).pop();
                                  } else {
                                    final Product product =
                                        await Navigator.pushNamed(
                                                context, '/select_product')
                                            as Product;
                                    item?.product = product.id;
                                    backScreen();
                                  }
                                })
                          ]);
                    });
              }
            : null,
        child: AspectRatio(
            aspectRatio: 1,
            child: item!.image is String
                ? FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: item!.image as String,
                    fit: BoxFit.cover,
                  )
                : Image.file(
                    item!.image as File,
                    fit: BoxFit.cover,
                  )));
  }
}
