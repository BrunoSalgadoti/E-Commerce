import 'dart:io';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/screens/edit_product/components/image_source_sheet.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImagesForm extends StatelessWidget {
  const ImagesForm({
    Key? key,
    this.product,
  }) : super(key: key);

  final Product? product;

  @override
  Widget build(BuildContext context) {
    return FormField<List<dynamic>>(
      initialValue: product!.images!,
      builder: (state) {
        return CarouselSlider(
          items: state.value!.map<Widget>((image) {
            return Stack(
              fit: StackFit.expand,
              children: <Widget>[
                if (image is String)
                  Image.network(
                    image,
                    fit: BoxFit.fill,
                  )
                else
                  Image.file(
                    image as File,
                    fit: BoxFit.fill,
                  ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(
                      Icons.delete,
                      size: 40,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      state.value!.remove(image);
                      state.didChange(state.value);
                    },
                  ),
                )
              ],
            );
          }).toList()..add(
            Material(
              color: Colors.grey[100],
              child: IconButton(
                icon:  Icon(
                  Icons.add_a_photo,
                  size: 60,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (_) => const ImageSourceSheet()
                  );

                },
              ))
          ),
          options: CarouselOptions(
            initialPage: 0,
            enableInfiniteScroll: false,
            height: 400,
            enlargeCenterPage: true,
            disableCenter: true,
          ),
        );
      },
    );
  }
}
