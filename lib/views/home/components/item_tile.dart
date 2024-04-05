import 'dart:io';

import 'package:brn_ecommerce/common/buttons/custom_button.dart';
import 'package:brn_ecommerce/common/messengers/custom_alertdialog_adaptive.dart';
import 'package:brn_ecommerce/models/products/product.dart';
import 'package:brn_ecommerce/models/products/product_manager.dart';
import 'package:brn_ecommerce/models/views/home_manager.dart';
import 'package:brn_ecommerce/models/views/section.dart';
import 'package:brn_ecommerce/models/views/section_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../common/formatted_fields/format_values.dart';

class ItemTile extends StatelessWidget {
  const ItemTile({super.key, this.item});

  final SectionItem? item;

  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<HomeManager>();
    backScreen() => Navigator.of(context).pop();
    final product =
        context.read<ProductManager>().findProductById(item?.product != null ? item!.product! : '');

    return GestureDetector(
        onTap: () {
          if (item?.product != null) {
            if (product != null && product.isValid!) {
              Navigator.pushNamed(context, "/product", arguments: product);
            }
          }
        },
        onLongPress: () => homeManager.editing
            ? CustomAlertDialogAdaptive(
                titleText: 'Editar Item',
                titleColor: Colors.black,
                titleSize: 18,
                titleWeight: FontWeight.normal,
                bodyText: '',
                content: product != null
                    ? ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Image.network(product.images!.first),
                        title: Text(product.name!),
                        subtitle: !product.hasStock
                            ? const Text(
                                'Fora de Estoque...',
                                style: TextStyle(color: Colors.red),
                              )
                            : Text(formattedRealText(product.basePrice)),
                      )
                    : const Text('Nenhum Item Vinculado'
                        ' a Imagem!'),
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
                                context.read<Section>().removeItem(item!);
                                Navigator.of(context).pop();
                              }),
                          CustomButton(
                              text: product != null ? 'Desvincular' : 'Vincular',
                              widthButton: 120,
                              heightButton: 40,
                              buttonColor: Colors.transparent,
                              textColor: Colors.blue,
                              elevation: 0,
                              onPressed: () async {
                                if (product != null) {
                                  item?.product = null;
                                  Navigator.of(context).pop();
                                } else {
                                  final Product product =
                                      await Navigator.pushNamed(context, '/select_product')
                                          as Product;
                                  item?.product = product.id;
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
                              onPressed: () => Navigator.of(context).pop())
                        ]),
                  )
                ],
              ).alertContent(context)
            : null,
        child: AspectRatio(
            aspectRatio: 1,
            child: item!.image is String
                ? FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: item!.image as String,
                    fit: BoxFit.fill,
                  )
                : Image.file(
                    item!.image as File,
                    fit: BoxFit.fill,
                  )));
  }
}
