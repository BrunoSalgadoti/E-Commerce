import 'dart:io';
import 'dart:typed_data';

import 'package:brn_ecommerce/screens/products_share/share_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

enum SocialMedia { facebook, instagram, whatsapp }

class ShareProduct {
  ShareProductScreen shareProductScreen;

  ShareProduct(this.shareProductScreen);

  Future<Uint8List?> saveWidgetImage() async {
    Uint8List? widgetImage = await shareProductScreen.captureImage();

    if (widgetImage != null) {
      String tempPath;
      Directory? tempDir = await getTemporaryDirectory();
      tempPath = tempDir.path;

      File imageFile = File('$tempPath/product_image.png');
      await imageFile.writeAsBytes(widgetImage);

      PermissionStatus permissionStatus = await Permission.storage.status;
      if (!permissionStatus.isGranted) {
        permissionStatus = await Permission.storage.request();
        if (permissionStatus.isGranted) {
          await Share.shareXFiles([XFile(imageFile.path)],
              text: 'Visite o nosso Site: https://brn-ecommerce.web.app/');
        }
      } else {
        await Share.shareXFiles([XFile(imageFile.path)],
            text: 'Visite o nosso Site: https://brn-ecommerce.web.app/');
      }

      return widgetImage; // Retorne a imagem capturada
    }
    return widgetImage;
  }

  Future<void> shareProductOnMobly(
      BuildContext context, SocialMedia socialPlatform) async {
    Uint8List? capturedImage = await saveWidgetImage();

    final shareImage = capturedImage;

    // Handles the URL if opened in an APP
    final urls = {
      SocialMedia.facebook: 'fb://post?text=$shareImage',
      SocialMedia.whatsapp: 'whatsapp://send?text=$shareImage',
      SocialMedia.instagram: 'instagram://library?AssetPath=$shareImage',
    };

    // Treat URL if opened by browser
    final defaultUrls = {
      SocialMedia.facebook:
          'https://www.facebook.com/sharer/sharer.php?t=$shareImage',
      SocialMedia.whatsapp: 'https://api.whatsapp.com/send?text=$shareImage',
      SocialMedia.instagram:
          'https://www.instagram.com/share?text=$shareImage',
    };

    final url = urls[socialPlatform];
    final defaultUrl = defaultUrls[socialPlatform];
    try {
      if (url != null) {
        if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrl(Uri.parse(url));
        } else if (defaultUrl != null &&
            await canLaunchUrl(Uri.parse(defaultUrl))) {
          await launchUrl(Uri.parse(defaultUrl));
        }
      }
    } catch (error) {
      debugPrint('Erro ao compartilhar: $error');
    }
  }
}
