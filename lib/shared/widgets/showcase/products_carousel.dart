import 'dart:ui';

import 'package:brn_ecommerce/common/miscellaneous/tag_for_cards.dart';
import 'package:brn_ecommerce/helpers/breakpoints.dart';
import 'package:brn_ecommerce/helpers/routes_navigator.dart';
import 'package:brn_ecommerce/models/products/product.dart';
import 'package:brn_ecommerce/shared/utils/formatters/format_values.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget carouselForProducts({
  required BuildContext context,
  required List<Product> productsForCarousel,
}) {
  final CarouselSliderControllerImpl carouselController = CarouselSliderControllerImpl();

  double screenWidth = MediaQuery.of(context).size.width;

  // Valores padrão (desktop grande)
  double viewportFraction = 0.24;
  double height = 280;
  double enlargeFactor = 0.27;
  bool disableCenter = true;

  // Breakpoint adjustments
  if (screenWidth <= mobileBreakpoint) {
    // Mobile: ≤600px
    viewportFraction = 0.55; // 1-2 visible cards
    height = 180;
    enlargeFactor = 0.15;
    disableCenter = false;
  } else if (screenWidth <= intermediateBreakpoint) {
    // Intermediate: 601 - 800px → 2 cards
    viewportFraction = 0.48;
    height = 200;
    enlargeFactor = 0.17;
    disableCenter = false;
  } else if (screenWidth <= staggeredBreakpoint) {
    // Staggered: 801 - 980px → 3 cards
    viewportFraction = 0.32;
    height = 230;
    enlargeFactor = 0.2;
    disableCenter = true;
  } else if (screenWidth <= tabletBreakpoint) {
    // Tablet: 981 - 1240px → 3-4 cards
    viewportFraction = 0.28;
    height = 260;
    enlargeFactor = 0.25;
    disableCenter = true;
  } else {
    // Large desktop: >1240px → 4+ cards
    viewportFraction = 0.24;
    height = 280;
    enlargeFactor = 0.27;
    disableCenter = true;
  }

  return CarouselSlider(
      carouselController: carouselController,
      options: CarouselOptions(
        aspectRatio: 1 / 1,
        initialPage: 0,
        height: height,
        viewportFraction: viewportFraction,
        disableCenter: disableCenter,
        enlargeCenterPage: true,
        enlargeFactor: enlargeFactor,
        enableInfiniteScroll: true,
        scrollDirection: Axis.horizontal,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 4),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
      ),
      items: productsForCarousel.map<Widget>((product) {
        return Stack(
          fit: StackFit.expand,
          children: [
            // Transparent Diffuse Background
            Positioned.fill(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      product.images!.first,
                      fit: BoxFit.fill,
                    ),
                    // Blur and transparency
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        color: Colors.white.withAlpha(50),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Main image with fitHeight and elevation
            Center(
              child: Material(
                elevation: 7,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: height - 12, // ensures that it never exceeds the bottom
                      maxWidth: screenWidth * viewportFraction, //respect the card
                    ),
                    child: Image.network(
                      product.images!.first,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),
            ),
            // Price tag
            Padding(
              padding: const EdgeInsets.all(10),
              child: TagForCard(
                data: 'A partir:\n ${formattedRealText(product.basePrice)}',
                googleFonts: GoogleFonts.akayaTelivigala,
                textFontSize: 16,
                alignment: Alignment.bottomLeft,
                backgroundColor: Colors.white,
                containerWidth: 90,
              ),
            ),
            // Open product button
            Positioned(
              bottom: 10,
              right: 10,
              child: Material(
                color: Theme.of(context).primaryColor.withAlpha(90),
                child: IconButton(
                  icon: const Icon(
                    Icons.open_in_new,
                    semanticLabel: 'Visualizar Produto',
                    size: 36,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      RoutesNavigator.productDetailsScreen,
                      arguments: product,
                    );
                  },
                ),
              ),
            ),
          ],
        );
      }).toList());
}