import 'dart:io';

import 'package:ecommerce/common/button/custom_button.dart';
import 'package:ecommerce/common/show_alert_dialog.dart';
import 'package:ecommerce/models/home_manager.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/models/product_manager.dart';
import 'package:ecommerce/models/section.dart';
import 'package:ecommerce/models/section_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class ItemTile extends StatelessWidget {
  const ItemTile({Key? key, this.item}) : super(key: key);

  final SectionItem? item;

  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<HomeManager>();
    late final backPage = Navigator.of(context).pop();

    return GestureDetector(
        onTap: () {
          if (item?.product != null) {
            final product =
                context.read<ProductManager>().findProductById(item!.product!);
            if (product != null) {
              Navigator.pushNamed(context, '/product', arguments: product);
            }
          }
        },
        onLongPress: homeManager.editing
            ? () {
                showDialog(
                    context: context,
                    builder: (_) {
                      final product = context
                          .read<ProductManager>()
                          .findProductById(
                              item?.product != null ? item!.product! : '');
                      return ShowAlertDialog(
                          titleText: 'Editar Item',
                          bodyText: '',
                          content: product != null
                              ? ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: Image.network(product.images!.first),
                                  title: Text(product.name!),
                                  subtitle: Text(
                                      'R\$ ${product.basePrice.toStringAsFixed(2)}'),
                                )
                              : const Text('Nenhum Item Vinculado'
                                  ' a Imagem!'),
                          actions: [
                            CustomButton(
                                texto: 'Excluir',
                                corBotao: Colors.transparent,
                                corTexto: Colors.red,
                                elevation: 0,
                                onPressed: () {
                                  context.read<Section>().removeItem(item!);
                                  Navigator.of(context).pop();
                                }),
                            CustomButton(
                                texto: product != null
                                    ? 'Desvincular'
                                    : 'Vincular',
                                corBotao: Colors.transparent,
                                corTexto: Colors.blue,
                                elevation: 0,
                                onPressed: () async {
                                  if(product != null){
                                    item?.product = null;
                                    backPage;
                                  } else {
                                   final Product product =
                                   await Navigator.pushNamed(
                                        context, '/select_product') as Product;
                                   item?.product = product.id;
                                   backPage;
                                  }
                                  backPage;
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
                    fit: BoxFit.fill,
                  )));
  }
}
