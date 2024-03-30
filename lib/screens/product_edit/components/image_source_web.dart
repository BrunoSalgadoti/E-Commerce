import 'dart:async';

import 'package:custom_universal_html/html.dart' as html;
import 'package:flutter/material.dart';

class ImageSourceWeb extends StatelessWidget {
  const ImageSourceWeb({
    super.key,
    this.onImageSelectedWeb,
  });

  final Function(List<html.File>)? onImageSelectedWeb;

  @override
  Widget build(BuildContext context) {
    List<html.File> imagens = [];

    Future<void> pickFiles() async {
      final completer = Completer<List<html.File>>();
      final html.FileUploadInputElement input = html.FileUploadInputElement()
        ..accept = 'image/*'
        ..multiple = true;

      input.onChange.listen((e) {
        final files = input.files!;
        completer.complete(files);
      });
      input.click();
      imagens = await completer.future;
    }

    Future<void> pickImages() async {
      try {
        await pickFiles();
        if (imagens.isNotEmpty) {
          final List<html.File> files = imagens;
          onImageSelectedWeb!(files);
        }
      } catch (error) {
        return;
      }
    }

    return AlertDialog(
      title: const Text('Selecionar fotos:'),
      content: const Text('Escolha as fotos do seu dispositivo!'),
      actions: [
        TextButton(
          onPressed: () async {
            await pickImages();
          },
          child: const Text('Carregar...'),
        ),
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
