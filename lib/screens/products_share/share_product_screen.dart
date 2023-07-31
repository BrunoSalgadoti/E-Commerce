import 'package:brn_ecommerce/common/button/custom_icon_button.dart';
import 'package:brn_ecommerce/models/product.dart';
import 'package:brn_ecommerce/screens/products_share/components/share_product.dart';
import 'package:brn_ecommerce/screens/products_share/components/share_product_web.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class ShareProductScreen extends StatefulWidget {
  ShareProductScreen({Key? key, required this.product}) : super(key: key);

  final Product? product;
  final GlobalKey repaintBoundaryKey = GlobalKey();

  Future<Uint8List?> captureImage() async {
    RenderRepaintBoundary boundary = repaintBoundaryKey.currentContext!
        .findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData?.buffer.asUint8List();
  }

  @override
  ShareProductScreenState createState() => ShareProductScreenState();
}

class ShareProductScreenState extends State<ShareProductScreen> {
  void _onShareButtonPressed() {
    if (kIsWeb) {
      _shareProductWeb().then((value) {}).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao compartilhar: $error')),
        );
      });
    } else {
      _shareProduct().then((value) {}).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao compartilhar: $error')),
        );
      });
    }
  }

  Future<void> _shareProductWeb([SocialMediaWeb? socialPlatform]) async {
    final shareProductWeb = ShareProductWeb(widget);
    if (socialPlatform != null) {
      try {
        await shareProductWeb.shareProductOnWeb(context, socialPlatform);
      } catch (error) {
        rethrow;
      }
    }
  }

  Future<void> _shareProduct() async {
    final shareProduct = ShareProduct(widget);
    try {
      await shareProduct.shareProductOnMobly(context, SocialMedia.whatsapp);
    } catch (error) {
      rethrow;
    }
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
                    iconData: FontAwesomeIcons.whatsapp,
                    color: const Color(0xff88f83f),
                    onTap: () => _shareProductWeb(SocialMediaWeb.whatsapp),
                  ),
                ],
              )
            : Container(
                color: Theme.of(context).primaryColor,
                child: GestureDetector(
                  child: CustomIconButton(
                      iconData: FontAwesomeIcons.share,
                      color: Colors.white,
                      onTap: _onShareButtonPressed),
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
              key: widget.repaintBoundaryKey,
              child: Card(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        SizedBox(
                          width: 350,
                          height: 350,
                          child: Image(
                            image: NetworkImage(widget.product!.images!.first),
                            fit: BoxFit.fill,
                          ),
                        ),
                        Positioned(
                          bottom: 8,
                          left: 8,
                          child: Image.asset(
                            "assets/logo/storeLogo.png",
                            width: 150,
                            height: 150,
                          ),
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
                      padding: EdgeInsets.only(top: 3, bottom: 7),
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
