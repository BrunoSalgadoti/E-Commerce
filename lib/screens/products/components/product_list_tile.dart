import 'package:brn_ecommerce/models/product.dart';
import 'package:flutter/material.dart';

class ProductListTile extends StatelessWidget {
  const ProductListTile({Key? key, this.product}) : super(key: key);

  final Product? product;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/product', arguments: product);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        child: Container(
          height: 100,
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Image(
                  image: NetworkImage(product!.images!.first),
                  fit: BoxFit.fill,
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
                                'R\$ ${product!.basePrice.toStringAsFixed(2)}',
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
      ),
    );
  }
}
