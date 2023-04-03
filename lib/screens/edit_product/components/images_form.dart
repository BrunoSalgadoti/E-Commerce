import 'dart:io';

import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/screens/edit_product/components/image_source_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImagesForm extends StatelessWidget {
  const ImagesForm({
    Key? key,
    this.product,
    this.imageSourceSheet,
  }) : super(key: key);

  final Product? product;
  final ImageSourceSheet? imageSourceSheet;

  @override
  Widget build(BuildContext context) {
    return FormField<List<dynamic>>(
      initialValue: List.from(product!.images!),
      builder: (state) {
        void onImageSelected(File file) {
          state.value!.add(file);
          state.didChange(state.value);
          Navigator.of(context).pop();
        }

        void onImageSelectedList(List<File> files) {
          state.value!.addAll(files);
          state.didChange(state.value);
          Navigator.of(context).pop();
        }

        Widget imagesSourceSheet() {
          return imageSourceSheet?.local == 'gallery'
              ? ImageSourceSheet(
                  onImageSelectedList: onImageSelectedList,
                )
              : ImageSourceSheet(
                  onImageSelected: onImageSelected,
                  onImageSelectedList: onImageSelectedList);
        }

        return CarouselSlider(
          options: CarouselOptions(
            initialPage: 0,
            enableInfiniteScroll: state.value!.isEmpty ? false : true,
            height: 400,
            enlargeCenterPage: true,
            disableCenter: true,
          ),
          items: state.value!.map<Widget>((image) {
            return Stack(
              fit: StackFit.expand,
              children: <Widget>[
                if (image is String)
                  Image.network(
                    image,
                    fit: BoxFit.cover,
                  )
                else
                  Image.file(
                    image as File,
                    fit: BoxFit.cover,
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
          }).toList()
            ..add(
              kIsWeb
                  ? Container(
                      color: Colors.grey[100],
                      child: IconButton(
                          icon: Icon(
                            Icons.add_a_photo,
                            size: 60,
                            color: Theme.of(context).primaryColor,
                          ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (_) => imagesSourceSheet());
                          }),
                    )
                  : Material(
                      color: Colors.grey[100],
                      child: IconButton(
                          icon: Icon(
                            Icons.add_a_photo,
                            size: 60,
                            color: Theme.of(context).primaryColor,
                          ),
                          onPressed: () {
                            if (Platform.isAndroid) {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (_) => imagesSourceSheet());
                            } else if (Platform.isIOS) {
                              showCupertinoModalPopup(
                                  context: context,
                                  builder: (_) => imagesSourceSheet());
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (_) => imagesSourceSheet());
                            }
                          })),
            ),
        );
      },
    );
  }
}
