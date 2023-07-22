import 'dart:io';
import 'package:brn_ecommerce/models/section.dart';
import 'package:brn_ecommerce/models/section_item.dart';
import 'package:brn_ecommerce/screens/product_edit/components/image_source_sheet.dart';
import 'package:brn_ecommerce/screens/product_edit/components/image_source_web.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:custom_universal_html/html.dart' as html;

class AddTileWidget extends StatelessWidget {
  const AddTileWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final section = context.watch<Section>();

    void onImageSelected(File file) {
      section.addItem(SectionItem(image: file));
      Navigator.of(context).pop();
    }

    void onImageSelectedList(List<File> files) {
      if (files.length > 1) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Está seção não permite seleção de várias imagens',
              style: TextStyle(fontSize: 18)),
          backgroundColor: Colors.red,
        ));
        Navigator.of(context).pop();
      } else {
        File file = files.first;
        section.addItem(SectionItem(image: file));
        Navigator.of(context).pop();
      }
    }

    void onImageSelectedWeb(List<html.File> files) {
      if (files.length > 1) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Está seção não permite seleção de várias imagens',
              style: TextStyle(fontSize: 18)),
          backgroundColor: Colors.red,
        ));
        Navigator.of(context).pop();
      } else {
        for (html.File file in files) {
          html.FileReader reader = html.FileReader();
          reader.readAsDataUrl(file);
          reader.onLoadEnd.listen((event) {
            section.addItem(SectionItem(image: reader.result));
            Navigator.of(context).pop();
          });
        }
      }
    }

    return AspectRatio(
      aspectRatio: 1,
      child: GestureDetector(
        onTap: () {
          if (kIsWeb) {
            showDialog(
                context: context,
                builder: (context) => ImageSourceWeb(
                      onImageSelectedWeb: onImageSelectedWeb,
                    ));
          } else if (Platform.isAndroid) {
            showModalBottomSheet(
                context: context,
                builder: (context) => ImageSourceSheet(
                      onImageSelected: onImageSelected,
                      onImageSelectedList: onImageSelectedList,
                    ));
          } else if (Platform.isIOS) {
            showCupertinoModalPopup(
                context: context,
                builder: (context) => ImageSourceSheet(
                      onImageSelected: onImageSelected,
                      onImageSelectedList: onImageSelectedList,
                    ));
          } else {
            showDialog(
                context: context,
                builder: (context) => ImageSourceSheet(
                      onImageSelected: onImageSelected,
                      onImageSelectedList: onImageSelectedList,
                    ));
          }
        },
        child: Container(
          color: Colors.white.withAlpha(30),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
