import 'package:brn_ecommerce/common/formatted_fields/format_values.dart';
import 'package:brn_ecommerce/common/miscellaneous/tag_for_cards.dart';
import 'package:brn_ecommerce/models/product.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdvertisingCard extends StatelessWidget {
  const AdvertisingCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    //TODO: ajustar layout
    return GestureDetector(
      onTap: () {
        //TODO: Ir ao produto
      },
      child: Stack(
        children: [
          Card(
            //Card Principal
            elevation: 4,
            clipBehavior: Clip.antiAlias,
            semanticContainer: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                bottomRight: Radius.circular(16.0),
              ),
            ),
            child: Container(
              clipBehavior: Clip.antiAlias,
              width: double.infinity,
              height: double.infinity, // 16x9 aspect ratio
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/CategoriesBackground.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          //Container Foto
          Center(
            child: Container(
              clipBehavior: Clip.antiAlias,
              height: 280,
              width: 260,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50), bottomLeft: Radius.circular(50)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.network(
                  //TODO: Substituir pelo caminho da foto do produto == advertising true
                  product.images!.first,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          //TODO: Ajustar...
          Padding(
            padding: const EdgeInsets.only(left: 50, bottom: 20),
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
      ),
    );
  }
}
