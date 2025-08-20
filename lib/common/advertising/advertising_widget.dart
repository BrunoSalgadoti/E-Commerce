import 'dart:async';

import 'package:brn_ecommerce/common/advertising/components/advertising_card.dart';
import 'package:brn_ecommerce/common/advertising/components/content_type.dart';
import 'package:brn_ecommerce/common/advertising/components/utils_for_advertising.dart';
import 'package:brn_ecommerce/helpers/breakpoints.dart';
import 'package:brn_ecommerce/helpers/themes/get_another_colors.dart';
import 'package:brn_ecommerce/models/products/product.dart';
import 'package:brn_ecommerce/models/products/product_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// # Widgets of the advertising reused in the project (Folder: common/advertising)
/// ## AdvertisingWidget
/// Stateful widget to display an ad carousel (PageView)
class AdvertisingWidget extends StatefulWidget {
  const AdvertisingWidget({super.key});

  @override
  AdvertisingWidgetState createState() => AdvertisingWidgetState();
}

class AdvertisingWidgetState extends State<AdvertisingWidget> {
  final ProductManager productManager = ProductManager();
  final PageController _pageController = PageController();

  late Timer _timer; // Timer for automatic carousel control
  int _currentPage = 0; // Carousel Home

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });

    /// Starts the timer to automatically advance the carousel pages
    _timer = Timer.periodic(const Duration(seconds: 9), (timer) {
      if (_currentPage <
          UtilsForAdvertising().loadAdvertisingProducts(productManager).length +
              UtilsForAdvertising().loadAdminSelectedImages().length -
              1) {
        _pageController.nextPage(
          duration: const Duration(seconds: 2),
          curve: Curves.ease,
        );
      } else {
        _pageController.jumpToPage(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Product product = context.watch<Product>(); // Product obtained from context
    final ProductManager productManager = context.watch<ProductManager>();
    final Color padEndsColor = getTextColorBasedOnBackground(Theme.of(context).primaryColor);

    final List<AdvertisingCarouselContent> cardContents = UtilsForAdvertising()
        .loadAdvertisingProducts(productManager)
        .where((p) => p.product!.hasStock)
        .toList(); // Carousel content (product cards)
    final List<AdvertisingCarouselContent> imageContents = UtilsForAdvertising()
        .loadAdminSelectedImages()
        .where((p) => p.product!.hasStock)
        .toList(); // Carousel content (selected images)
    final totalItems = cardContents.length + imageContents.length - 1; //Total items in the carousel
    final totalPages = totalItems.ceil(); // Total number of pages in the carousel

    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: [
          SizedBox(
            height: constraints.maxWidth < mobileBreakpoint
                ? 280
                : constraints.maxWidth >= wildBreakpoint
                    ? 580
                    : 390,
            width: double.infinity,
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Stack(children: [
                PageView(
                  controller: _pageController,
                  padEnds: true,
                  children: [
                    //Selection of map content to be displayed on the Advertising Card...
                    // (cardContents or imageContents)
                    ...cardContents.map<Widget>((content) {
                      if (content.type == ContentType.productCard) {
                        return AdvertisingCard(product: content.product!);
                      } else {
                        return AdvertisingCard(product: product);
                      }
                    }),
                    ...imageContents.map<Widget>(
                      (content) => Image.network(content.imageUrl!),
                    ),
                  ],
                ),

                //Content of the FloatingActionButton pageview controller in web mode only
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (kIsWeb)
                      Center(
                        child: FloatingActionButton(
                          heroTag: 'previousButton',
                          mini: true,
                          onPressed: () {
                            if (_currentPage > 0) {
                              _pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.ease,
                              );
                            }
                          },
                          backgroundColor: Colors.white,
                          elevation: 4.0,
                          child: const FittedBox(
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.black,
                              size: 14,
                            ),
                          ),
                        ),
                      ),
                    if (kIsWeb)
                      Center(
                        child: FloatingActionButton(
                          heroTag: 'nextButton',
                          mini: true,
                          onPressed: () {
                            if (_currentPage < cardContents.length + imageContents.length - 1) {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.ease,
                              );
                            } else {
                              _pageController.jumpToPage(0);
                            }
                          },
                          backgroundColor: Colors.white,
                          elevation: 4.0,
                          child: const FittedBox(
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.black,
                              size: 14,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ]),
            ),
          ),
          if (totalPages > 1)
            FittedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(totalPages, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 3),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentPage == index ? padEndsColor : Colors.black45,
                      ),
                      width: 9,
                      height: 9,
                    ),
                  );
                }),
              ),
            ),
        ],
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose(); // Releases the page controller
    _timer.cancel(); // Cancels the timer when the state ends
    super.dispose();
  }
}
