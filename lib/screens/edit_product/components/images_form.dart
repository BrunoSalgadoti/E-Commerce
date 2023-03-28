import 'dart:io';
import 'package:ecommerce/common/button/custom_icon_button.dart';
import 'package:ecommerce/common/show_fan_carousel.dart';
import 'package:ecommerce/models/product.dart';
import 'package:flutter/material.dart';

class ImagesForm extends StatelessWidget {
   const ImagesForm({Key? key, required this.product} ) : super(key: key);

 final Product product;

  @override
  Widget build(BuildContext context) {

    bool assents = false;

    return Stack(
      children: [
        FormField<List<dynamic>>(
            initialValue: product.images,
            builder: (state) {
              return  ShowFanCarousel(
                  imagesLink: state.value!.map((image) {
                    if(image is String) {
                      Image.network(image);
                      assents = false;
                    } else {
                    Image.file(image as File);
                      assents = true;
                    }
                    return image as String;
                  }).toList(),
                  isAssets: assents,
                );
            }
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 60),
             child: Align(
              alignment: Alignment.topRight,
              child: CustomIconButton(
                iconData: Icons.delete,
                size: 40,
                color: Colors.red,
                onTap: () {

                },
              ),
            ),
          ),
      ]
    );
  }
}
