import 'dart:async';
import 'package:custom_universal_html/html.dart' as html;
import 'package:flutter/material.dart';

class ImageSourceWeb extends StatefulWidget {
  const ImageSourceWeb({
    Key? key,
    this.onImageSelectedWeb,
  }) : super(key: key);

  final Function(List<html.File>)? onImageSelectedWeb;

  @override
  State<ImageSourceWeb> createState() => _ImageSourceWebState();
}

class _ImageSourceWebState extends State<ImageSourceWeb> {
  List<html.File> _files = [];
  bool _mounted = false;

  @override
  void initState() {
    super.initState();
    _mounted = true;
  }

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
    try {
      await pickFiles();
      if (_mounted && _files.isNotEmpty) {
        final List<html.File> files = _files;
        widget.onImageSelectedWeb!(files);
      }
    } catch (error) {
      return;
    }
  }

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
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
