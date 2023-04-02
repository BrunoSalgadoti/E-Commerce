import 'package:ecommerce/common/button/custom_text_button.dart';
import 'package:flutter/material.dart';

class ImageSourceSheet extends StatelessWidget {
  const ImageSourceSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
        builder: (_) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
           CustomTextButton(
                onPressed: () {

                },
             text: 'Câmera',
             fontSize: 18,

            ),
            CustomTextButton(
              onPressed: () {

              },
              text: 'Galeria',
              fontSize: 18,

            ),

          ],
        ),
        onClosing: () {},
    );
  }
}
