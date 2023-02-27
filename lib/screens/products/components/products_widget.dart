import 'package:ecommerce/models/details_products.dart';
import 'package:ecommerce/models/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsWidget extends StatelessWidget {
  const ProductsWidget({Key? key, required this.details}) : super(key: key);

  final DetailsProducts details;

  @override
  Widget build(BuildContext context) {
    final product = context.watch<Product>();
    final selected = details == product.selectedDetails;

    Color color;
    if(!details.hasStock) {
      color = Colors.red.withAlpha(70);
    }else if(selected) {
      color = Theme.of(context).primaryColor;
    }else {
      color = Colors.grey;
    }

    return GestureDetector(
      onTap: () {
        if(details.hasStock) {
          product.selectedDetails = details;
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: color
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              color: color,
              child: Text(
                details.size,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'R\$ ${details.price.toStringAsFixed(2)}',
                style: TextStyle(
                  color: color,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
