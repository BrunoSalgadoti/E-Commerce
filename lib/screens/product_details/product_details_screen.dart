import 'package:ecommerce/common/button/custom_button.dart';
import 'package:ecommerce/models/cart_manager.dart';
import 'package:ecommerce/models/users_manager.dart';
import 'package:ecommerce/screens/products/components/products_widget.dart';
import 'package:ecommerce/models/product.dart';
import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({
    Key? key,
    this.product
  }) : super(key: key);

  final Product? product;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return ChangeNotifierProvider.value(
      value: product,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(product!.name!),
            centerTitle: true,
            actions: [
              Consumer<UserManager>(
                builder: (_, userManager, __) {
                  if (userManager.adminEnable) {
                    return IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/edit_product',
                            arguments: product);
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
          body: ListView(children: [
            FanCarouselImageSlider(
              imagesLink: product!.images!.map((url) {
                return NetworkImage(url).url;
              }).toList(),
              isAssets: false,
              autoPlay: kIsWeb ? true : false,
              initalPageIndex: 0,
              sliderHeight: 400,
              slideViewportFraction: 0.8,
              sliderWidth: double.maxFinite,
              imageRadius: 10,
              imageFitMode: BoxFit.cover,
              indicatorActiveColor: primaryColor,
              expandImageWidth: double.maxFinite,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    product!.name!,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      'A partir de: ',
                      style: TextStyle(fontSize: 15, color: Colors.grey[600]),
                    ),
                  ),
                  Text(
                    'R\$ ${product!.basePrice.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      'Descrição',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    product!.description!,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      'Tamanhos',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    alignment: WrapAlignment.spaceEvenly,
                    children: product!.itemProducts!.map((d) {
                      return ProductsWidget(details: d);
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (product!.hasStock)
                    Consumer2<UserManager, Product>(
                        builder: (_, userManager, product, __) {
                      return CustomButton(
                          texto: userManager.isLoggedIn
                              ? 'Adicionar ao Carrinho'
                              : 'Entre para Comprar',
                          onPressed: product.selectedDetails != null
                              ? () {
                                  if (userManager.isLoggedIn) {
                                    context
                                        .read<CartManager>()
                                        .addToCart(product);
                                    Navigator.pushNamed(context, '/cart');
                                  } else {
                                    Navigator.pushNamed(context, '/login');
                                  }
                                }
                              : null,
                      );
                    }),
                  if (!product!.hasStock)
                    const SizedBox(
                      height: 44,
                      child: CustomButton(
                        texto: 'Produto fora de estoque!',
                        onPressed: null,
                      ),
                    )
                ],
              ),
            )
          ])),
    );
  }
}
