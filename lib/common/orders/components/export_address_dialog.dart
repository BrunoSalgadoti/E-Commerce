import 'dart:io';
import 'package:brn_ecommerce/common/button/custom_text_button.dart';
import 'package:brn_ecommerce/common/show_alert_dialog.dart';
import 'package:brn_ecommerce/models/address.dart';
import 'package:brn_ecommerce/models/order_client.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

class ExportAddressDialog extends StatelessWidget {
  ExportAddressDialog(this.address, this.orderClient,
      {Key? key,})
      : super(key: key);

  final Address? address;
  final OrderClient? orderClient;

  final ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return ShowAlertDialog(
      titleText: 'Endereço de Entrega',
      titleSize: 19,
      content: Screenshot(
        controller: screenshotController,
        child: Container(
          padding: const EdgeInsets.all(8),
          width: 270,
          child: Text(
              'Pedido: ${orderClient!.formattedId}\n'
              '\n---------------- Destinatário ----------------\n'
              'Nome: ${orderClient?.userName ?? ''}\n'
              '${address!.street ?? ''}, ${address!.number ?? 'S/N'},\n'
              '${address!.district ?? ''}\n'
              '${address!.city ?? ''}-${address!.state ?? ''}\n'
              '${address!.zipCode ?? ''}\n'
              '${address?.complement ?? ''}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.start),
        ),
      ),
      contentPadding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      actions: [
        CustomTextButton(
          text: 'Exportar',
          color: Theme.of(context).primaryColor,
          icon: null,
          onPressed: () async {
            Navigator.of(context).pop();

            ///Capture and saving to a file
            screenshotController.capture().then((value) async {
              var image = value;

              final dir = await getApplicationDocumentsDirectory();
              final imagePath =
                  await File('${dir.path}/ ${orderClient!.formattedId}.png')
                      .create();
              await imagePath.writeAsBytes(image!);

              ///Save a widget Capture to a Gallery
              await GallerySaver.saveImage(imagePath.path);
            });
          },
        )
      ],
      bodyText: null,
    );
  }
}
