import 'dart:io';
import 'package:brn_ecommerce/models/product.dart';
import 'package:brn_ecommerce/screens/edit_product/components/image_source_sheet.dart';
import 'package:brn_ecommerce/screens/edit_product/components/image_source_web.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:custom_universal_html/html.dart' as html;

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
      initialValue: List.from(product!.images as Iterable),
      validator: (images) {
        if (images!.isEmpty) {
          return 'Isira ao menos uma imagem!';
        }
        return null;
      },
      onSaved: (images) => product?.newImages = images,
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

        void onImageSelectedWeb(List<html.File> files) {
          for (html.File file in files) {
            html.FileReader reader = html.FileReader();
            reader.readAsDataUrl(file);
            reader.onLoadEnd.listen((event) {
              state.value!.add(reader.result);
              state.didChange(state.value);
            });
          }
          Navigator.of(context).pop();
        }

        Widget buildImageSourceSheet() {
          if (kIsWeb) {
            return ImageSourceWeb(
              onImageSelectedWeb: onImageSelectedWeb,
            );
          } else if (imageSourceSheet?.local == 'gallery') {
            return ImageSourceSheet(
              onImageSelectedList: onImageSelectedList,
            );
          } else {
            return ImageSourceSheet(
              onImageSelected: onImageSelected,
              onImageSelectedList: onImageSelectedList,
            );
          }
        }

        return Column(
          children: [
            CarouselSlider(
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
                    else if (image is File)
                      Image.file(
                        image,
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
                                    builder: (_) => buildImageSourceSheet());
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
                                      builder: (_) => buildImageSourceSheet());
                                } else if (Platform.isIOS) {
                                  showCupertinoModalPopup(
                                      context: context,
                                      builder: (_) => buildImageSourceSheet());
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (_) => buildImageSourceSheet());
                                }
                              })),
                ),
            ),
            if (state.hasError)
              Container(
                margin: const EdgeInsets.only(top: 16, left: 16),
                alignment: Alignment.centerLeft,
                child: Text(
                  state.errorText!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 13,
                  ),
                ),
              )
          ],
        );
      },
    );
  }
}
