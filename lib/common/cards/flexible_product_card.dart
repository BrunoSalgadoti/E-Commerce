import 'package:auto_size_text/auto_size_text.dart';
import 'package:brn_ecommerce/common/formatted_fields/format_values.dart';
import 'package:brn_ecommerce/common/functions/common_functions.dart';
import 'package:brn_ecommerce/common/miscellaneous/freight_logo.dart';
import 'package:brn_ecommerce/common/miscellaneous/tag_for_cards.dart';
import 'package:brn_ecommerce/models/products/product.dart';
import 'package:brn_ecommerce/models/users/users_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// # Widgets of the cards reused in the project (Folder: common/cards)
/// ## FlexibleProductCard
/// A flexible product card widget that can be displayed vertically or horizontally.
class FlexibleProductCard extends StatelessWidget {
  // Determines whether the card should be displayed vertically or horizontally.
  final bool isVertical;
  final Product? product;

  /// Creates a flexible product card.
  const FlexibleProductCard({super.key, this.product, required this.isVertical});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final basePrice = product?.basePrice ?? 0.0;
    final imageNotAvailable = product?.images == null || product!.images!.isEmpty;
    const Color backgroundColor = Colors.white;
    final Color textColor = getTextColorBasedOnBackground(backgroundColor);
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

              /// Widget content for vertical card
              ? Card(
                  semanticContainer: true,
                  color: primaryColor,
                  clipBehavior: Clip.antiAlias,
                  elevation: 7,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Column(
                      children: [
                        Container(
                          constraints: const BoxConstraints(maxHeight: 185),
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
                                        height: 250,
                                      )
                                    : Image(
                                        image: NetworkImage(
                                          product?.images?.first ?? "",
                                        ),
                                        fit: BoxFit.fill,
                                        width: double.infinity,
                                        height: 250,
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
                                    googleFonts: GoogleFonts.akayaTelivigala,
                                    textFontSize: 23,
                                    alignment: Alignment.bottomLeft,
                                    backgroundColor: Colors.green.withAlpha(90),
                                    containerWidth: 125,
                                    containerHeight: 80,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          constraints: const BoxConstraints(maxHeight: 120),
                          color: backgroundColor,
                          padding: const EdgeInsets.fromLTRB(9, 5, 9, 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Align(
                                  alignment: Alignment.center,
                                  child: AutoSizeText(
                                    overflow: TextOverflow.ellipsis,
                                    maxFontSize: 17,
                                    maxLines: 2,
                                    minFontSize: 12,
                                    product!.name!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: textColor),
                                  )),
                              //TODO: Implementar MarkdownText
                              Align(
                                  alignment: Alignment.center,
                                  child: AutoSizeText(
                                    overflow: TextOverflow.ellipsis,
                                    maxFontSize: 17,
                                    maxLines: 3,
                                    minFontSize: 10,
                                    product!.description!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 15, color: textColor),
                                  )),
                              Align(
                                alignment: Alignment.center,
                                child: AutoSizeText(
                                  overflow: TextOverflow.ellipsis,
                                  maxFontSize: 15,
                                  maxLines: 1,
                                  minFontSize: 10,
                                  product?.brand != "" ? 'Marca: ${product!.brand}' : ' ',
                                  style: TextStyle(
                                      fontSize: 12, fontWeight: FontWeight.w600, color: textColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )

              /// Widget content for horizontal card
              : Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAlias,
                  elevation: 7,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: Stack(
                    children: [
                      Container(
                        constraints: const BoxConstraints(maxHeight: 145, minWidth: 100),
                        color: Colors.white,
                        child: Row(
                          children: [
                            AspectRatio(
                              aspectRatio: 1,
                              child: imageNotAvailable
                                  ? Image.asset('assets/images/noImage.png', fit: BoxFit.fitHeight)
                                  : Image(
                                      image: NetworkImage(product?.images?.first ?? ""),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AutoSizeText(
                                      overflow: TextOverflow.ellipsis,
                                      maxFontSize: 18,
                                      maxLines: 2,
                                      minFontSize: 15,
                                      product!.name!,
                                      style: const TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    AutoSizeText(
                                      overflow: TextOverflow.ellipsis,
                                      maxFontSize: 16,
                                      maxLines: 4,
                                      minFontSize: 10,
                                      product!.description!,
                                      style: const TextStyle(
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    if (product?.brand != "")
                                      AutoSizeText(
                                        overflow: TextOverflow.ellipsis,
                                        maxFontSize: 16,
                                        maxLines: 1,
                                        minFontSize: 10,
                                        'Marca: ${product!.brand}',
                                        style: const TextStyle(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    Row(
                                      children: [
                                        product!.hasStock
                                            ? Flexible(
                                                child: AutoSizeText(
                                                  overflow: TextOverflow.ellipsis,
                                                  maxFontSize: 18,
                                                  maxLines: 1,
                                                  minFontSize: 10,
                                                  'A partir de: ',
                                                  style: TextStyle(
                                                      fontSize: 15.0, color: Colors.grey[600]),
                                                ),
                                              )
                                            : Flexible(
                                                child: AutoSizeText(
                                                  overflow: TextOverflow.ellipsis,
                                                  maxFontSize: 17,
                                                  maxLines: 2,
                                                  minFontSize: 10,
                                                  'Aguardando reposição de estoque... ',
                                                  style: TextStyle(
                                                      fontSize: 14.0, color: Colors.grey[600]),
                                                ),
                                              ),
                                        product!.hasStock
                                            ? Flexible(
                                                child: AutoSizeText(
                                                  overflow: TextOverflow.ellipsis,
                                                  maxFontSize: 20,
                                                  maxLines: 1,
                                                  minFontSize: 10,
                                                  formattedRealText(basePrice),
                                                  style: TextStyle(
                                                    fontSize: 17.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: primaryColor,
                                                  ),
                                                ),
                                              )
                                            : Flexible(
                                                child: AutoSizeText(
                                                  overflow: TextOverflow.ellipsis,
                                                  maxFontSize: 18,
                                                  maxLines: 2,
                                                  minFontSize: 10,
                                                  'Fora de estoque',
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: primaryColor,
                                                  ),
                                                ),
                                              ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
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
