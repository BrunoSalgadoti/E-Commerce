import 'package:brn_ecommerce/screens/products_share/share_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/formatted_fields/format_values.dart';

enum SocialMediaWeb { whatsapp }

class ShareProductWeb {
  ShareProductWeb(this.shareProductScreen);

  ShareProductScreen shareProductScreen;
  String urlShare = 'https://brn-ecommerce.web.app/';

  Future<void> shareProductOnWeb(BuildContext context, SocialMediaWeb socialPlatform) async {
    try {
      String productName = 'A Loja Virtual BRN Info-Dev\n Convida você a conferir '
          'uma de nossas Super Promoções!'
          '\n\n ${shareProductScreen.product!.name}';
      String sharedImageUrl = '\n **Confira a foto do produto**: \n '
          '${shareProductScreen.product!.images!.first}\n';
      String productPrice = '\nA partir de: '
          '${formattedRealText(shareProductScreen.product!.basePrice).toString()}\n';
      String productText = '\nDescrição do produto... '
          '\n ${shareProductScreen.product!.description} \n\n '
          '__Visite a nossa Loja Virtual!__';
      String sharedUrl = '\n$urlShare';

      String formattedMessage = '$productName$productPrice$sharedImageUrl$productText$sharedUrl';

      String shareLink = Uri.encodeComponent(formattedMessage);

      // Handles the URL if opened in an APP
      final urls = {
        SocialMediaWeb.whatsapp: 'whatsapp://send?text=$shareLink',
      };

      // Treat URL if opened by browser
      final defaultUrls = {
        SocialMediaWeb.whatsapp: 'https://api.whatsapp.com/send?text=$shareLink',
      };

      final url = urls[socialPlatform];
      final defaultUrl = defaultUrls[socialPlatform];
      try {
        if (url != null) {
          if (await canLaunchUrl(Uri.parse(url))) {
            await launchUrl(Uri.parse(url));
          } else if (defaultUrl != null && await canLaunchUrl(Uri.parse(defaultUrl))) {
            await launchUrl(Uri.parse(defaultUrl));
          }
        }
      } catch (error) {
        rethrow;
      }
    } catch (error) {
      rethrow;
    }
  }
}
