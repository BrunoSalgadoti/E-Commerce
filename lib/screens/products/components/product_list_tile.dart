import 'package:brn_ecommerce/models/product.dart';
import 'package:brn_ecommerce/models/users_manager.dart';
import 'package:flutter/material.dart';

import '../../../common/formated_fields/format_values.dart';

class ProductListTile extends StatelessWidget {
  const ProductListTile({Key? key, this.product}) : super(key: key);

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
          ? Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              child: Container(
                height: 100,
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: imageNotAvailable
                          ? Image.asset('assets/images/noImage.png',
                              fit: BoxFit.fitHeight)
                          : Image(
                              image: NetworkImage(product?.images?.first ?? ""),
                              fit: BoxFit.fitHeight,
                            ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product!.name!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: product!.hasStock
                                ? Text(
                                    'A partir de: ',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.grey[600]),
                                  )
                                : Text(
                                    'Aguadando reposição de estoque... ',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey[600]),
                                  )),
                        product!.hasStock
                            ? Text(
                                '${formattedRealText(basePrice)}',
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
            )
          : Container(),
    );
  }
}
