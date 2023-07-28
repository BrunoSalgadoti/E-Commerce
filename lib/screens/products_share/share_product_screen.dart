import 'dart:io';
import 'package:brn_ecommerce/common/button/custom_icon_button.dart';
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
import 'package:custom_universal_html/js.dart' as js;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

enum SocialMedia { facebook, instagram, whatsapp, email }

class ShareProductScreen extends StatefulWidget {
  const ShareProductScreen({Key? key, required this.product}) : super(key: key);

  final Product? product;

  @override
  ShareProductScreenState createState() => ShareProductScreenState();
}

class ShareProductScreenState extends State<ShareProductScreen> {
  GlobalKey repaintBoundaryKey = GlobalKey();

  final String urlShare = 'https://brn-ecommerce.web.app/';

  Future<Uint8List?> saveWidgetImage() async {
    RenderRepaintBoundary boundary = repaintBoundaryKey.currentContext!
        .findRenderObject() as RenderRepaintBoundary;

    ui.Image image = await boundary.toImage(pixelRatio: 1.0);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List? widgetImage = byteData?.buffer.asUint8List();

    if (widgetImage != null) {
      String tempPath;
      if (kIsWeb) {
        html.Blob imageBlob = html.Blob([widgetImage], 'image/png');
        String imageUrl = html.Url.createObjectUrl(imageBlob);
        await Share.shareXFiles([XFile(imageUrl)],
            text: 'Visite o nosso Site: $urlShare');
      } else {
        Directory? tempDir = await getTemporaryDirectory();
        tempPath = tempDir.path;

        File imageFile = File('$tempPath/product_image.png');
        await imageFile.writeAsBytes(widgetImage);

        PermissionStatus permissionStatus = await Permission.storage.status;
        if (!permissionStatus.isGranted) {
          permissionStatus = await Permission.storage.request();
          if (permissionStatus.isGranted) {
            await Share.shareXFiles([XFile(imageFile.path)],
                text: 'Visite o nosso Site: $urlShare');
          }
        } else {
          await Share.shareXFiles([XFile(imageFile.path)],
              text: 'Visite o nosso Site: $urlShare');
        }
      }
      return widgetImage; // Retorne a imagem capturada
    }
    return null; // Se a imagem não for capturada com sucesso, retorne null
  }

  Future<void> share(SocialMedia socialPlatform) async {
    Uint8List? capturedImage = await saveWidgetImage();

    final shareImage = capturedImage;

    final shareText = 'Visite nossa Loja Virtual!\n '
        '${widget.product?.name} \n  '
        'A partir de: \n R\$ ${widget.product?.basePrice.toStringAsFixed(2)} \n '
        '${widget.product?.description}\n'
        '\n$urlShare';

    // Handles the URL if opened in an APP
    final urls = {
      SocialMedia.facebook: 'fb://post?text=$shareImage&media=$urlShare',
      SocialMedia.whatsapp: 'whatsapp://send?text=$shareImage&media=$urlShare',
      SocialMedia.email: _buildEmailBody(shareImage!, urlShare),
      SocialMedia.instagram:
          'instagram://library?AssetPath=$shareImage&InstagramCaption=$urlShare',
    };

    // Treat URL if opened by browser
    final defaultUrls = {
      SocialMedia.facebook:
          'https://www.facebook.com/sharer/sharer.php?t=$shareImage&u=$urlShare',
      SocialMedia.whatsapp:
          'https://api.whatsapp.com/send?text=$shareImage&image=$urlShare',
      SocialMedia.email: _buildEmailBody(shareImage, urlShare),
      SocialMedia.instagram:
          'https://www.instagram.com/share?text=$shareImage&url=$urlShare',
    };

    final url = urls[socialPlatform];
    final defaultUrl = defaultUrls[socialPlatform];

    // Handles sharing on the web
    if (kIsWeb) {
      try {
        // Tenta compartilhar usando js.context.callMethod
        await js.context.callMethod('navigator', [
          'share',
          {
            'title': 'Compartilhar Produto',
            'text': shareText,
            'url': urlShare,
            'image': shareImage,
          },
        ]);
      } catch (error) {
        try {
          // Tenta compartilhar usando html.window.navigator.share
          await html.window.navigator.share({
            'text': '$shareText\n$urlShare',
            'title': 'Compartilhar Produto',
            'url': urlShare,
            'image': shareImage,
          });
        } catch (error) {
          // Trate erros ao chamar a API de compartilhamento
          debugPrint('Erro ao compartilhar: $error');
        }
      }
    } else {
      // Se não estiver na web, continue com a lógica atual de compartilhamento
      if (url != null) {
        if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrl(Uri.parse(url));
        } else if (defaultUrl != null &&
            await canLaunchUrl(Uri.parse(defaultUrl))) {
          await launchUrl(Uri.parse(defaultUrl));
        } else {
          try {
            // Compartilha usando share_plus
            await Share.share(shareText);
          } catch (error) {
            debugPrint('Erro ao compartilhar: $error');
          }
        }
      }
    }
  }

  String _buildEmailBody(Uint8List shareImage, String urlShare) {
    const subject = 'Confira esta oferta incrível!';
    final body = '''
    <html>
    <body>
      <p>Olá,</p>
      <p>Gostaria de compartilhar com você esta oferta incrível da nossa loja virtual.</p>
      <p>Detalhes do produto:</p>
      <img src="$shareImage" alt="Produto">
      <p>Clique no link abaixo para visitar nossa loja virtual:</p>
      <p><a href="$urlShare">Link para a loja virtual</a></p>
      <p>Aproveite!</p>
      <p>Atenciosamente,</p>
      <p>Equipe da Loja Virtual</p>
    </body>
    </html>
  ''';

    return 'mailto:?subject=$subject&body=$body';
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    Widget buildSocialButtons(BuildContext context) {
      return Card(
        child: kIsWeb
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomIconButton(
                    iconData: FontAwesomeIcons.facebook,
                    color: const Color(0xFF0075fc),
                    onTap: () => share(SocialMedia.facebook),
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
              )
            : Container(
                color: Theme.of(context).primaryColor,
                child: CustomIconButton(
                  iconData: FontAwesomeIcons.share,
                  color: Colors.white,
                  onTap: () => share(SocialMedia.whatsapp),
                ),
              ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Compartilhar Produto'),
          centerTitle: true,
          actions: [
            CustomIconButton(
              iconData: Icons.close,
              onTap: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            RepaintBoundary(
              key: repaintBoundaryKey,
              child: Card(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Image(
                          image: NetworkImage(widget.product!.images!.first),
                          fit: BoxFit.fill,
                        ),
                        Image.asset(
                          "assets/logo/storeLogo.png",
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
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: buildSocialButtons(context));
  }
}
