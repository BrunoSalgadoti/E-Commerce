import 'dart:io';

import 'package:brn_ecommerce/common/buttons/custom_icon_button.dart';
import 'package:brn_ecommerce/common/messengers/custom_scaffold_messenger.dart';
import 'package:brn_ecommerce/models/views/stores.dart';
import 'package:brn_ecommerce/views/product_edit/components/image_source_sheet.dart';
import 'package:brn_ecommerce/views/product_edit/components/image_source_web.dart';
import 'package:custom_universal_html/html.dart' as html;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class StoreImageWidget extends StatelessWidget {
  const StoreImageWidget({super.key, required this.store});

  final Stores store;

  @override
  Widget build(BuildContext context) {
    final storeImage = store.imageStore != null && store.imageStore != ""
        ? Image.network(store.imageStore!, fit: BoxFit.cover)
        : Image.asset('assets/images/noImage.png', fit: BoxFit.cover);
    backScreen() => Navigator.of(context).pop();

    void onImageSelected(File file) {
      store.updateStoreImage(file, store.id ?? "");
      backScreen();
    }

    void onImageSelectedList(List<File> files) {
      if (files.length > 1) {
        CustomScaffoldMessenger(
          context: context,
          message: 'Esta seção não permite a seleção de diversas imagens',
        ).alertScaffold();
        backScreen();
      } else {
        File file = files.first;
        store.updateStoreImage(file, store.id ?? "");
        backScreen();
      }
    }

    void onImageSelectedWeb(List<html.File> files) {
      if (files.length > 1) {
        CustomScaffoldMessenger(
          context: context,
          message: 'Esta seção não permite a seleção de diversas imagens',
        ).alertScaffold();
        backScreen();
      } else {
        for (html.File file in files) {
          html.FileReader reader = html.FileReader();
          reader.readAsDataUrl(file);
          reader.onLoadEnd.listen((event) {
            store.updateStoreImage(reader.result, store.id ?? "");
            backScreen();
          });
        }
      }
    }

    return Stack(
      children: [
        SizedBox(width: double.infinity, height: 230, child: storeImage),
        Align(
            alignment: Alignment.topLeft,
            child: CustomIconButton(
              onTap: () async {
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
              iconData: Icons.change_circle_outlined,
              color: Colors.blue,
              size: 45,
            )),
      ],
    );
  }
}
