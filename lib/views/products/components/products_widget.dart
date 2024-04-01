import 'package:brn_ecommerce/models/products/details_products.dart';
import 'package:brn_ecommerce/models/products/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/formatted_fields/format_values.dart';

class ProductsWidget extends StatelessWidget {
  const ProductsWidget({
    super.key,
    this.details,
    this.onSizeSelected,
  });

  final DetailsProducts? details;
  final Function(int)? onSizeSelected;

  @override
  Widget build(BuildContext context) {
    final price = details?.price ?? 0.0;
    final product = context.watch<Product>();
    final selected = details == product.selectedDetails;

    Color color;
    if (!details!.hasStock) {
      color = Colors.red.withAlpha(70);
    } else if (selected) {
      color = Theme.of(context).primaryColor;
    } else {
      color = Colors.grey;
    }

    return GestureDetector(
      onTap: () {
        if (details!.hasStock) {
          product.selectedDetails = details;
          if (onSizeSelected != null) {
            final sizeIndex = product.itemProducts!.indexOf(details!);
            onSizeSelected!(sizeIndex);
          }
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: color),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              color: color,
              child: Text(
                details!.size!,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                formattedRealText(price),
                style: TextStyle(
                  color: color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
