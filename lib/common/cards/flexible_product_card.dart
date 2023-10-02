import 'package:brn_ecommerce/common/formatted_fields/format_values.dart';
import 'package:brn_ecommerce/common/miscellaneous/freight_logo.dart';
import 'package:brn_ecommerce/common/miscellaneous/tag_for_cards.dart';
import 'package:brn_ecommerce/models/product.dart';
import 'package:brn_ecommerce/models/users_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FlexibleProductCard extends StatelessWidget {
  const FlexibleProductCard(
      {Key? key, this.product, required this.isVertical})
      : super(key: key);

  final bool isVertical; // Defines whether the card should be vertical
  final Product? product;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final basePrice = product?.basePrice ?? 0.0;
    final imageNotAvailable =
        product?.images == null || product!.images!.isEmpty;
    UserManager userManager = UserManager();

    return GestureDetector(
      onTap: () {
        if (imageNotAvailable && userManager.adminEnable) {
          Navigator.pushNamed(context, "/edit_product", arguments: product);
        }
        if (!imageNotAvailable) {
          Navigator.pushNamed(context, "/product", arguments: product);
        }
      },
      child: product!.isValid!
          ? isVertical == true
              ? Card(
                  semanticContainer: true,
                  color: primaryColor,
                  clipBehavior: Clip.antiAlias,
                  elevation: 7,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17)),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: imageNotAvailable
                                    ? Image.asset(
                                        'assets/images/noImage.png',
                                        fit: BoxFit.fill,
                                        width: double.infinity,
                                        height: 192,
                                      )
                                    : Image(
                                        image: NetworkImage(
                                          product?.images?.first ?? "",
                                        ),
                                        fit: BoxFit.fill,
                                        width: double.infinity,
                                        height: 192,
                                      ),
                              ),
                              FreightLogo(
                                product: product ?? Product(),
                                radiusTopLeft: Radius.zero,
                                radiusBottomLeft: const Radius.circular(9),
                                positionedTop: 0,
                                positionedRight: 0,
                                positionedBottom: null,
                                text: null,
                              ),
                              Positioned(
                                bottom: 0,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: TagForCard(
                                      data: !product!.hasStock
                                          ? 'Estoque\n Esgotado!'
                                          : 'A partir:\n '
                                              '${formattedRealText(product!.basePrice)}',
                                      googleFonts:
                                          GoogleFonts.akayaTelivigala,
                                      textFontSize: 23,
                                      alignment: Alignment.bottomLeft,
                                      backgroundColor:
                                          Colors.green.withAlpha(90),
                                      containerWidth: 100,
                                      containerHeight: 60),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          constraints: const BoxConstraints(maxHeight: 70),
                          color: const Color.fromARGB(255, 187, 32, 192),
                          padding: const EdgeInsets.fromLTRB(9, 3, 5, 9),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    product!.name!,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),
                              Align(
                                alignment: Alignment.center,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    product?.brand != ""
                                        ? 'Marca: ${product!.brand}'
                                        : ' ',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7)),
                  child: Stack(
                    children: [
                      Container(
                        height: 120,
                        width: double.infinity,
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          children: [
                            AspectRatio(
                              aspectRatio: 1,
                              child: imageNotAvailable
                                  ? Image.asset('assets/images/noImage.png',
                                      fit: BoxFit.fitHeight)
                                  : Image(
                                      image: NetworkImage(
                                          product?.images?.first ?? ""),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                                child: Column(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    product!.name!,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                                if (product?.brand != "")
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      'Marca: ${product!.brand}',
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: product!.hasStock
                                        ? Text(
                                            'A partir de: ',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey[600]),
                                          )
                                        : Text(
                                            'Aguardando reposição de estoque... ',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey[600]),
                                          )),
                                product!.hasStock
                                    ? Text(
                                        formattedRealText(basePrice),
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      )
                                    : Text(
                                        'Fora de estoque',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                              ],
                            ))
                          ],
                        ),
                      ),
                      FreightLogo(
                        product: product ?? Product(),
                        positionedRight: 0,
                        positionedBottom: 0,
                      )
                    ],
                  ),
                )
          : Container(),
    );
  }
}
