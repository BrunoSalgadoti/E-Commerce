import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:flutter/material.dart';

class ShowFanCarousel extends StatelessWidget {
  const ShowFanCarousel({Key? key,
    required this.imagesLink,
    required this.isAssets,
  }) : super(key: key);

   final List<String> imagesLink;
   final bool isAssets;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Stack(
      children: [
        FanCarouselImageSlider(
          imagesLink: imagesLink,
          isAssets: isAssets,
          autoPlay: false,
          initalPageIndex: 0,
          sliderHeight: 400,
          slideViewportFraction: 0.8,
          sliderWidth: double.maxFinite,
          imageRadius: 10,
          imageFitMode: BoxFit.cover,
          indicatorActiveColor: primaryColor,
          expandImageWidth: double.maxFinite,
        ),
      ]
    );
  }
}
