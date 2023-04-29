import 'dart:io';

import 'package:ecommerce/models/product_manager.dart';
import 'package:ecommerce/models/section_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class ItemTile extends StatelessWidget {
  const ItemTile({Key? key, this.item}) : super(key: key);

  final SectionItem? item;

  @override
  Widget build(BuildContext context) {
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
