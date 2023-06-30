import 'package:flutter/material.dart';
import 'package:brn_ecommerce/models/colors_products.dart';
import 'package:brn_ecommerce/models/details_products.dart';
import 'package:provider/provider.dart';

class ColorsWidget extends StatelessWidget {
  const ColorsWidget({
    Key? key,
    this.colorsProducts,
  }) : super(key: key);

  final ColorsProducts? colorsProducts;

  @override
  Widget build(BuildContext context) {
    final detailsProducts = context.watch<DetailsProducts>();
    final selected = colorsProducts == detailsProducts.selectedColors;

    Color color;
    if (!colorsProducts!.hasAmount) {
      color = Colors.red.withAlpha(70);
    } else if (selected) {
      color = Theme.of(context).primaryColor;
    } else {
      color = Colors.grey;
    }

    return GestureDetector(
        onTap: () {
          if (colorsProducts!.hasAmount) {
            detailsProducts.selectedColors = colorsProducts;
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  color: color,
                  child: colorsProducts!.hasAmount
                      ? const Text(
                          'Cor:',
                          style: TextStyle(color: Colors.white),
                        )
                      : const Text(
                          'XX:',
                          style: TextStyle(color: Colors.white),
                        )),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                  decoration: BoxDecoration(
                    color: colorsProducts!.realColor!.withAlpha(255),
                  ),
                  width: 45,
                  height: 20,
                ),
              ),
            ],
          ),
        ));
  }
}
