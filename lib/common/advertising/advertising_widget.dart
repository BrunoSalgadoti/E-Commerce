import 'dart:async';

import 'package:brn_ecommerce/common/advertising/components/advertising_card.dart';
import 'package:brn_ecommerce/common/advertising/components/content_type.dart';
import 'package:brn_ecommerce/common/advertising/components/utils_for_advertising.dart';
import 'package:brn_ecommerce/models/product.dart';
import 'package:brn_ecommerce/models/product_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdvertisingWidget extends StatefulWidget {
  const AdvertisingWidget({super.key});

  @override
  AdvertisingWidgetState createState() => AdvertisingWidgetState();
}

class AdvertisingWidgetState extends State<AdvertisingWidget> {
  final ProductManager productManager = ProductManager();
  final PageController _pageController = PageController();

  late Timer _timer;

  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });

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
  void dispose() {
    _pageController.dispose();
    _timer.cancel(); // Cancel Timer on disposal
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Product product = context.watch<Product>();
    final ProductManager productManager = context.watch<ProductManager>();

    final List<AdvertisingCarouselContent> cardContents =
        UtilsForAdvertising().loadAdvertisingProducts(productManager).toList();
    final List<AdvertisingCarouselContent> imageContents =
        UtilsForAdvertising().loadAdminSelectedImages().toList();
    final totalItems = cardContents.length + imageContents.length - 1;
    final totalPages = totalItems.ceil();

    return SizedBox(
      width: double.infinity,
      height: 300,
      child: Column(
        children: [
          Expanded(
            child: Stack(children: [
              PageView(
                controller: _pageController,
                padEnds: true,
                children: [
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
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                          size: 14,
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
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                          size: 14,
                        ),
                      ),
                    ),
                ],
              ),
            ]),
          ),
          if (totalPages > 1)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(totalPages, (index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 3),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentPage == index
                          ? Theme.of(context).primaryColor
                          : Colors.white12,
                    ),
                    width: 6,
                    height: 6,
                  ),
                );
              }),
            ),
        ],
      ),
    );
  }
}
