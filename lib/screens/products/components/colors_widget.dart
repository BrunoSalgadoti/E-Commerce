import 'package:flutter/material.dart';
import 'package:brn_ecommerce/models/colors_products.dart';
import 'package:brn_ecommerce/models/details_products.dart';
import 'package:provider/provider.dart';

class ColorsWidget extends StatelessWidget {
  const ColorsWidget({
    Key? key,
    this.colorsProducts, required this.selectedSizeIndex,
  }) : super(key: key);

  final ColorsProducts? colorsProducts;
  final int? selectedSizeIndex;


  @override
  Widget build(BuildContext context) {

    return Consumer<DetailsProducts>(
      builder: (_, detailsProducts, __) {
        final selected = detailsProducts.selectedColors == colorsProducts;

        Color color;
        if (!colorsProducts!.hasAmount ||
            colorsProducts!.realColor == colorsProducts!.realColor!.withAlpha(0)) {
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
                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  color: color,
                  child: colorsProducts!.hasAmount
                      ? const Text(
                    'Disponível:',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  )
                      : const Text(
                    'Indisponível:',
                    style: TextStyle(color: Colors.black, fontSize: 9),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: colorsProducts?.realColor,
                      ),
                      width: 45,
                      height: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
