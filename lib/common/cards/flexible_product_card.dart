import 'package:auto_size_text/auto_size_text.dart';
import 'package:brn_ecommerce/common/formatted_fields/format_values.dart';
import 'package:brn_ecommerce/common/images/root_assets.dart';
import 'package:brn_ecommerce/common/miscellaneous/freight_logo.dart';
import 'package:brn_ecommerce/common/miscellaneous/tag_for_cards.dart';
import 'package:brn_ecommerce/helpers/routes_navigator.dart';
import 'package:brn_ecommerce/helpers/themes/get_another_colors.dart';
import 'package:brn_ecommerce/models/products/product.dart';
import 'package:brn_ecommerce/models/users/users_manager.dart';
import 'package:brn_ecommerce/views/favorites/components/favorites_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// # Widgets of the cards reused in the project (Folder: common/cards)
/// ## FlexibleProductCard
/// A flexible product card widget that can be displayed vertically or horizontally.
class FlexibleProductCard extends StatelessWidget {
  // Determines whether the card should be displayed vertically or horizontally.
  final bool isVertical;
  final Product? product;
  final VoidCallback? onTap;
  final double iconsSize = 39;

  /// Creates a flexible product card.
  const FlexibleProductCard({
    super.key,
    required this.product,
    required this.isVertical,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final basePrice = product?.basePrice ?? 0.0;
    final imageNotAvailable = product?.images == null || product!.images!.isEmpty;
    const Color backgroundColor = Colors.white;
    final Color textColor = getTextColorBasedOnBackground(backgroundColor);
    UserManager userManager = UserManager();

    return GestureDetector(
      onTap: onTap ??
          () {
            // Default navigation only if there is no external onTap
            if (onTap == null) {
              if (imageNotAvailable && userManager.adminEnable) {
                Navigator.pushNamed(context, RoutesNavigator.editProductScreen, arguments: product);
              } else if (!imageNotAvailable) {
                Navigator.pushNamed(context, RoutesNavigator.productDetailsScreen,
                    arguments: product);
              }
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
                                        RootAssets.noImagePng,
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
                              ),
                              FavoritesWidget(
                                product: product!,
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
                                    product?.name ?? '',
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
                                    product?.description ?? '',
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
                  child: Container(
                    constraints: const BoxConstraints(maxHeight: 145, minWidth: 100),
                    color: Colors.white,
                    child: Row(
                      children: [
                        // Product Image
                        AspectRatio(
                          aspectRatio: 1,
                          child: imageNotAvailable
                              ? Image.asset(RootAssets.noImagePng, fit: BoxFit.fitHeight)
                              : Image.network(product?.images?.first ?? "", fit: BoxFit.cover),
                        ),

                        // Card content (text, price, and favorite)
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Product name + favorite
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: AutoSizeText(
                                        product!.name!,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                    FavoritesWidget(product: product ?? Product()),
                                  ],
                                ),

                                // Description
                                AutoSizeText(
                                  product?.description ?? '',
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),

                                // Mark
                                if (product?.brand != null && product!.brand.isNotEmpty)
                                  AutoSizeText(
                                    'Marca: ${product?.brand ?? ''}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),

                                // Price
                                Row(
                                  children: [
                                    product!.hasStock
                                        ? Text(
                                            'A partir de: ',
                                            style:
                                                TextStyle(fontSize: 15.0, color: Colors.grey[600]),
                                          )
                                        : Text(
                                            'Aguardando reposição de estoque...',
                                            style:
                                                TextStyle(fontSize: 14.0, color: Colors.grey[600]),
                                          ),
                                    const SizedBox(width: 5),
                                    product!.hasStock
                                        ? Text(
                                            formattedRealText(basePrice),
                                            style: TextStyle(
                                              fontSize: 17.0,
                                              fontWeight: FontWeight.bold,
                                              color: primaryColor,
                                            ),
                                          )
                                        : Text(
                                            'Fora de estoque',
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold,
                                              color: primaryColor,
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
                )
          : Container(),
    );
  }
}
