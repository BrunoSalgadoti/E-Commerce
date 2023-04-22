import 'dart:async';
import 'package:universal_html/html.dart' as html;

import 'package:flutter/material.dart';

class ImageSourceWeb extends StatelessWidget {
  ImageSourceWeb({Key? key,
    this.onImageSelectedWeb,
    this.oneWebFile
  }) : super(key: key);

  final Function(List<html.File>)? onImageSelectedWeb;

  List<html.File> _files = [];

  String? oneWebFile;

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
    _files = await completer.future;
  }

  Future<void> pickImages() async {
    bool mounted = true;
    try {
      await pickFiles();
      if (mounted && _files.isNotEmpty) {
        final List<html.File> files = List.from(_files);
        onImageSelectedWeb?.call(files);
      }
    } finally {
      mounted = false;
    }
  }

  @override
  Widget build(BuildContext context) {
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
