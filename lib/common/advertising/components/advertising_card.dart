import 'package:brn_ecommerce/common/formatted_fields/format_values.dart';
import 'package:brn_ecommerce/common/miscellaneous/tag_for_cards.dart';
import 'package:brn_ecommerce/models/products/product.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// ## AdvertisingCard  (Folder: common/advertising/components)
/// ### Components of Advertising Widget
/// Widget that represents an advertising card to be reused on different views.
class AdvertisingCard extends StatelessWidget {
  final Product product;

  const AdvertisingCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/product", arguments: product);
      },
      child: LayoutBuilder(builder: (context, constraints) {
        return Stack(
          children: [
            ///Card Background wallpaper
            Card(
              elevation: 7,
              clipBehavior: Clip.antiAlias,
              semanticContainer: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
              ),
              //TODO: Place and configure a class to manage the background of ADS in storage
              child: Container(
                clipBehavior: Clip.antiAlias,
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/CategoriesBackground.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            ///Container Product Photo
            Center(
              child: Container(
                clipBehavior: Clip.antiAlias,
                height: double.infinity,
                width: 350,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50), bottomLeft: Radius.circular(50)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Image.network(
                    product.images!.first,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),

            ///Ad price tag
            Padding(
              padding: EdgeInsets.only(left: constraints.maxWidth * 0.15, bottom: 25),
              child: TagForCard(
                data: 'A partir:\n '
                    '${formattedRealText(product.basePrice)}',
                googleFonts: GoogleFonts.akayaTelivigala,
                textFontSize: 25,
                alignment: Alignment.bottomLeft,
                backgroundColor: Colors.white,
                containerHeight: 100,
                containerWidth: 150,
              ),
            )
          ],
        );
      }),
    );
  }
}
