import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:ecommerce/models/product.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({Key? key, this.product}) : super(key: key);

  final Product? product;

  @override
  Widget build(BuildContext context) {

    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(product!.name),
          centerTitle: true,
        ),
        body: ListView(
            children: [
          FanCarouselImageSlider(
              imagesLink: product!.images!,
              isAssets: false,
              autoPlay: false,
              initalPageIndex: 0,
              sliderHeight: 320,
              slideViewportFraction: 0.8,
              sliderWidth: double.maxFinite,
              imageRadius: 10,
              imageFitMode: BoxFit.fill,
              indicatorActiveColor: primaryColor,
              expandImageWidth: double.maxFinite,
          ),
              Padding(
                  padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        product!.name,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        'A partir de: ',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[600]
                        ),
                      ),
                    ),
                    Text(
                      'R\$ 19.99',
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
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Text(
                      product!.description!,
                      style: const TextStyle(
                        fontSize: 16
                      ),
                    )
                  ],
                ),
              )
          ]
        )
    );
  }
}
