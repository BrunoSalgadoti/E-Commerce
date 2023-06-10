import 'dart:io';
import 'package:brn_ecommerce/common/button/custom_icon_button.dart';
import 'package:brn_ecommerce/common/empty_indicator.dart';
import 'package:brn_ecommerce/models/product.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:custom_universal_html/html.dart' as html;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

enum SocialMedia { facebook, twitter, instagram, whatsapp, email }

class ShareProductScreen extends StatefulWidget {
  const ShareProductScreen({Key? key, required this.product}) : super(key: key);

  final Product? product;

  @override
  ShareProductScreenState createState() => ShareProductScreenState();
}

class ShareProductScreenState extends State<ShareProductScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey repaintBoundaryKey = GlobalKey();

  // URL referring to the host of the website and the...
  // internal page of the shared product
  final String urlShare = 'https://brninfodev.page.link/products/';

  Future<Uint8List?> captureWidgetToImage(GlobalKey repaintBoundaryKey) async {
    try {
      RenderRepaintBoundary boundary = repaintBoundaryKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 1.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData?.buffer.asUint8List();
    } catch (e) {
      if (kDebugMode) {
        print('Error capturing widget to image: $e');
      }
      return null;
    }
  }

  Future<void> saveWidgetImage(BuildContext context) async {
    if (kDebugMode) {
      print('$urlShare${widget.product!.id}');
    }

    RenderRepaintBoundary boundary = repaintBoundaryKey.currentContext!
        .findRenderObject() as RenderRepaintBoundary;

    ui.Image image = await boundary.toImage(pixelRatio: 1.0);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List? widgetImage = byteData?.buffer.asUint8List();

    if (widgetImage != null) {
      String tempPath;
      if (kIsWeb) {
        // Create blob object with image
        html.Blob imageBlob = html.Blob([widgetImage], 'image/png');

        // Generate URL for image
        String imageUrl = html.Url.createObjectUrl(imageBlob);

        // Share image
        await Share.shareXFiles([XFile(imageUrl)],
            text: 'Visite o nosso Site: $urlShare${widget.product!.id}');
      } else {
        // Save the image to the device's temp directory
        Directory? tempDir = await getTemporaryDirectory();
        tempPath = tempDir.path;

        File imageFile = File('$tempPath/product_image.png');
        await imageFile.writeAsBytes(widgetImage);

        // Check file access permission
        PermissionStatus permissionStatus = await Permission.storage.status;
        if (!permissionStatus.isGranted) {
          permissionStatus = await Permission.storage.request();
          if (permissionStatus.isGranted) {
            //Share image
            await Share.shareXFiles([XFile(imageFile.path)],
                text: 'Visite o nosso Site: $urlShare${widget.product!.id}');
          }
        } else {
          //Share image
          await Share.shareXFiles([XFile(imageFile.path)],
              text: 'Visite o nosso Site: $urlShare${widget.product!.id}');
        }
      }
    }
  }

  Future<Uint8List?> captureAndShare(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      // Call the function to save the widget as an image
      await saveWidgetImage(context);
    }

    return null;
  }

  Future<void> share(SocialMedia socialPlatform) async {
    Uint8List? capturedImage = await captureAndShare(context);

    final shareText = capturedImage != null
        ? ''
        : 'Visite nossa Loja Virtual!\n '
            '${widget.product?.name} \n  '
            'A partir de: \n R\$ ${widget.product?.basePrice.toStringAsFixed(2)} \n '
            '${widget.product?.description}\n'
            '\n$urlShare${widget.product!.id}';

    // Handles the URL if opened in an APP
    final urls = {
      SocialMedia.facebook:
          'fb://post?text=$shareText&media=${widget.product!.id}',
      SocialMedia.whatsapp:
          'whatsapp://send?text=$shareText&media=${widget.product!.id}',
      SocialMedia.twitter:
          'twitter://post?message=$shareText&media=${widget.product!.id}',
      SocialMedia.email: _buildEmailBody(shareText),
      SocialMedia.instagram:
          'instagram://library?AssetPath=${widget.product!.id}&InstagramCaption=$shareText',
    };

    // Treat URL if opened by browser
    final defaultUrls = {
      SocialMedia.facebook:
          'https://www.facebook.com/sharer/sharer.php?t=$shareText&u=${widget.product!.id}',
      SocialMedia.whatsapp:
          'https://api.whatsapp.com/send?text=$shareText&image=${widget.product!.id}',
      SocialMedia.twitter:
          'https://twitter.com/intent/tweet?text=$shareText&url=${widget.product!.id}',
      SocialMedia.email: _buildEmailBody(shareText),
      SocialMedia.instagram:
          'https://www.instagram.com/share?text=$shareText&url=${widget.product!.id}',
    };

    final url = urls[socialPlatform];
    final defaultUrl = defaultUrls[socialPlatform];

    if (url != null) {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else if (defaultUrl != null &&
          await canLaunchUrl(Uri.parse(defaultUrl))) {
        await launchUrl(Uri.parse(defaultUrl));
      } else {
        // Fallback to sharing using share_plus library
        if (capturedImage != null && kIsWeb) {
          final imageBlob = html.Blob([capturedImage], 'image/png');
          final imageUrl = html.Url.createObjectUrl(imageBlob);

          html.window.open(imageUrl, '_blank');
        } else {
          await Share.share(shareText);
        }
      }
    }
  }

  String _buildEmailBody(String shareText) {
    const subject = 'Confira esta oferta incrível!';
    final body = 'Olá,\n\n'
        'Gostaria de compartilhar com você esta oferta incrível da '
        'nossa loja virtual.\n\n'
        'Detalhes do produto:\n\n'
        '$shareText\n\n'
        'Clique no link abaixo para visitar nossa loja virtual:\n\n'
        '$urlShare${widget.product!.id}\n\n'
        'Aproveite!\n\n'
        'Atenciosamente,\n'
        'Equipe da Loja Virtual';

    final encodedSubject = Uri.encodeComponent(subject);
    final encodedBody = Uri.encodeComponent(body);

    return 'mailto:?subject=$encodedSubject&body=$encodedBody';
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    Widget buildSocialButtons(BuildContext context) {
      return Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomIconButton(
              iconData: FontAwesomeIcons.squareFacebook,
              color: const Color(0xFF0075fc),
              onTap: () => share(SocialMedia.facebook),
            ),
            CustomIconButton(
              iconData: FontAwesomeIcons.twitter,
              color: const Color(0xFF1da1f2),
              onTap: () => share(SocialMedia.twitter),
            ),
            CustomIconButton(
              iconData: FontAwesomeIcons.instagram,
              color: const Color(0xffe2094e),
              onTap: () => share(SocialMedia.instagram),
            ),
            CustomIconButton(
              iconData: FontAwesomeIcons.whatsapp,
              color: const Color(0xff88f83f),
              onTap: () => share(SocialMedia.whatsapp),
            ),
            CustomIconButton(
              iconData: Icons.email_outlined,
              color: const Color(0xff0820c4),
              onTap: () => share(SocialMedia.email),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product!.id != null && !widget.product!.deleted
            ? 'Compartilhar Produto'
            : 'Produto Indisponível'),
        centerTitle: true,
        actions: [
          if (widget.product!.id != null)
            CustomIconButton(
              iconData: Icons.close,
              onTap: () {
                Navigator.of(context).pop();
              },
            )
        ],
      ),
      backgroundColor: !widget.product!.deleted ? Colors.white : primaryColor,
      body: !widget.product!.deleted
          ? Form(
              key: formKey,
              child: ListView(
                children: [
                  RepaintBoundary(
                    key: repaintBoundaryKey,
                    child: Card(
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Image(
                                image:
                                    NetworkImage(widget.product!.images!.first),
                                fit: BoxFit.fill,
                              ),
                              Image.asset(
                                'assets/logo/storeLogo.png',
                                width: 180,
                                height: 450,
                                alignment: Alignment.bottomRight,
                              ),
                            ],
                          ),
                          Text(
                            '${widget.product?.name}',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              'A partir de: ',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Text(
                            'R\$ '
                            '${widget.product?.basePrice.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 3),
                            child: Text(
                              'Aproveite esta Super Oferta!!',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            '${widget.product?.description}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          : const Center(
              child: EmptyIndicator(
                title: 'Produto Indisponível',
                iconData: Icons.border_clear,
                image: null,
              ),
            ),
      bottomNavigationBar: !widget.product!.deleted
          ? buildSocialButtons(context)
          : const SizedBox(),
    );
  }
}
