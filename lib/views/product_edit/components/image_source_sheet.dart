import 'dart:async';
import 'dart:io';

import 'package:brn_ecommerce/common/buttons/custom_text_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceSheet extends StatelessWidget {
  ImageSourceSheet({
    super.key,
    this.onImageSelected,
    this.onImageSelectedList,
  });

  final ImagePicker picker = ImagePicker();

  final Function(File)? onImageSelected;
  final Function(List<File>)? onImageSelectedList;

  @override
  Widget build(BuildContext context) {
    Future<void> editImage(String? path) async {
      if (path != null) {
        final croppedFile = await ImageCropper().cropImage(
          sourcePath: path,
          compressFormat: ImageCompressFormat.jpg,
          compressQuality: 100,
          uiSettings: [
            AndroidUiSettings(
                toolbarTitle: 'Editar Imagem',
                toolbarColor: Theme.of(context).primaryColor,
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.original,
                lockAspectRatio: false),
            IOSUiSettings(
              title: 'Editar Imagem',
              cancelButtonTitle: 'Cancelar',
              doneButtonTitle: 'Concluir',
            ),
          ],
        );
        if (croppedFile != null) {
          final originalFile = File(path);
          await originalFile.writeAsBytes(await croppedFile.readAsBytes());
          onImageSelected!(originalFile);
        }
      }
    }

    Future<void> imgGallery() async {
      final List<XFile> xFile = await picker.pickMultiImage();
      final List<File> files = xFile.map((xFile) => File(xFile.path)).toList();
      if (files.length == 1) {
        File file = files.first;
        editImage(file.path);
      } else {
        onImageSelectedList!(files);
      }
    }

    Future<void> imgCamera() async {
      XFile? photo = await picker.pickImage(source: ImageSource.camera);
      editImage(photo?.path);
    }

    if (Platform.isAndroid) {
      return BottomSheet(
        builder: (_) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextButton(
              onPressed: () {
                imgCamera();
              },
              text: 'Câmera',
              fontSize: 18,
              icon: null,
            ),
            const Divider(
              height: 5,
            ),
            CustomTextButton(
              onPressed: () {
                imgGallery();
              },
              text: 'Galeria',
              fontSize: 18,
              icon: null,
            ),
            //const SizedBox(height: 8,),
            const Divider(
              height: 2,
              thickness: 2,
            ),
            CustomTextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              text: 'Cancelar',
              fontColor: Colors.red,
              fontSize: 18,
              icon: null,
            ),
          ],
        ),
        onClosing: () {},
      );
    } else if (Platform.isIOS) {
      return CupertinoActionSheet(
        title: const Text('Selecionar a foto para o item:'),
        message: const Text('Escolha a origem da foto!'),
        cancelButton: CupertinoActionSheetAction(
          onPressed: Navigator.of(context).pop,
          child: const Text('Cancelar'),
        ),
        actions: [
          CupertinoActionSheetAction(
            isDefaultAction: true,
            child: const Text('Câmera'),
            onPressed: () {
              imgCamera();
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Galeria'),
            onPressed: () {
              imgGallery();
            },
          ),
        ],
      );
    } else {
      return AlertDialog(
        title: const Text('Plataforma Não suportada'),
        content: const Text('Este App não é compatível com esse plataforma\n'
            'plataformas compatíveis: Ios / Android / Web'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancelar'),
          )
        ],
      );
    }
  }
}
