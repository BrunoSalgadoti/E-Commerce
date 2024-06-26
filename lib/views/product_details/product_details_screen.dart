import 'package:brn_ecommerce/common/buttons/custom_button.dart';
import 'package:brn_ecommerce/common/images/root_assets.dart';
import 'package:brn_ecommerce/common/miscellaneous/empty_page_indicator.dart';
import 'package:brn_ecommerce/helpers/routes_navigator.dart';
import 'package:brn_ecommerce/models/products/details_products.dart';
import 'package:brn_ecommerce/models/products/product.dart';
import 'package:brn_ecommerce/models/sales/cart_manager.dart';
import 'package:brn_ecommerce/models/users/users_manager.dart';
import 'package:brn_ecommerce/views/products/components/colors_widget.dart';
import 'package:brn_ecommerce/views/products/components/products_widget.dart';
import 'package:collection/collection.dart';
import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';

import '../../common/formatted_fields/format_values.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({
    super.key,
    this.product,
    this.selectedSizeIndex,
  });

  final Product? product;
  final int? selectedSizeIndex;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int? selectedSizeIndex;

  @override
  void initState() {
    selectedSizeIndex = widget.selectedSizeIndex;
    super.initState();
  }

  void updateSelectedSizeIndex(int index) {
    final detailsProducts = context.read<DetailsProducts>();
    final selectedSize = widget.product!.itemProducts![index];
    clearSelectedColors();
    setState(() {
      selectedSizeIndex = index;
    });

    final transparentColorProduct = selectedSize.colorProducts!.firstWhereOrNull(
      (colors) => colors.realColor == Colors.transparent,
    );

    if (transparentColorProduct != null) {
      detailsProducts.selectedColors = transparentColorProduct;
    }
  }

  void clearSelectedColors() {
    final detailsProducts = context.read<DetailsProducts>();
    detailsProducts.selectedColors = null;
  }

  @override
  Widget build(BuildContext context) {
    final basePrice = widget.product?.basePrice ?? 0.0;
    final primaryColor = Theme.of(context).primaryColor;

    return ChangeNotifierProvider.value(
      value: widget.product,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(widget.product!.name ?? ''),
            centerTitle: true,
            actions: [
              if (widget.product!.hasStock)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: IconButton(
                      icon: const Icon(Icons.share_outlined),
                      onPressed: () {
                        Navigator.pushNamed(context, RoutesNavigator.shareProductScreen,
                            arguments: widget.product);
                      }),
                ),
              const SizedBox(width: 16),
              Consumer<UserManager>(
                builder: (_, userManager, __) {
                  if (userManager.adminEnable && !widget.product!.deleted) {
                    return IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, RoutesNavigator.editProductScreen,
                            arguments: widget.product);
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
          body: widget.product == null ||
                  widget.product!.images == null ||
                  widget.product!.images!.isEmpty
              ? const EmptyPageIndicator(
                  title: 'Carregando...',
                  titleColor: Colors.black,
                  iconData: null,
                  iconColor: Colors.black,
                  image: RootAssets.cartAwaitGif)
              : Consumer<DetailsProducts>(
                  builder: (_, detailsProducts, __) {
                    return ListView(children: [
                      FanCarouselImageSlider.sliderType2(
                        imagesLink: widget.product!.images!.map((url) {
                          return NetworkImage(url).url;
                        }).toList(),
                        isAssets: false,
                        autoPlay: kIsWeb ? true : false,
                        initalPageIndex: 0,
                        indicatorActiveColor: primaryColor,
                        indicatorDeactiveColor: Colors.blueGrey,
                        sliderHeight: 400,
                        slideViewportFraction: 0.8,
                        sliderWidth: double.maxFinite,
                        imageRadius: 10,
                        imageFitMode: BoxFit.fill,
                        expandImageWidth: double.maxFinite,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              widget.product!.name ?? '',
                              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: widget.product!.hasStock
                                    ? Text(
                                        'A partir de: ',
                                        style: TextStyle(fontSize: 15, color: Colors.grey[600]),
                                      )
                                    : Text(
                                        widget.product!.deleted
                                            ? 'Esgotado...!'
                                            : 'Aguardando reposição de estoque...',
                                        style: TextStyle(fontSize: 15, color: Colors.grey[600]),
                                      )),
                            widget.product!.hasStock
                                ? Text(
                                    formattedRealText(basePrice),
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  )
                                : Text(
                                    widget.product!.deleted
                                        ? 'Produto não Disponível!'
                                        : 'Fora de estoque',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                            const Padding(
                              padding: EdgeInsets.only(top: 16, bottom: 8),
                              child: Text(
                                'Descrição',
                                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                            ),
                            MarkdownBody(
                              data: widget.product?.description ?? '',
                              shrinkWrap: true,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 16, bottom: 8),
                              child: Text(
                                'Tamanhos',
                                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              alignment: WrapAlignment.spaceEvenly,
                              children: widget.product!.itemProducts!.map((d) {
                                return ProductsWidget(
                                  details: d,
                                  onSizeSelected: updateSelectedSizeIndex,
                                );
                              }).toList(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16, bottom: 8),
                              child: Visibility(
                                visible: (widget.product!.deleted ||
                                        detailsProducts.areAllColorsEmpty(widget.product))
                                    ? false
                                    : true,
                                child: const Text(
                                  'Cor(es) do Produto:',
                                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              alignment: WrapAlignment.spaceEvenly,
                              children: widget
                                  .product!.itemProducts![selectedSizeIndex ?? 0].colorProducts!
                                  .asMap() // Convert to Map<int, ColorsProducts>
                                  .entries
                                  .map((entry) {
                                final index = entry.key;
                                final colorProduct = entry.value;
                                return detailsProducts.areAllColorsEmpty(widget.product)
                                    ? Container()
                                    : ColorsWidget(
                                        key: ValueKey(index),
                                        colorsProducts: colorProduct,
                                        selectedSizeIndex: selectedSizeIndex,
                                      );
                              }).toList(),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            if (widget.product!.hasStock)
                              Consumer2<UserManager, Product>(
                                  builder: (_, userManager, product, __) {
                                return CustomButton(
                                  text: userManager.isLoggedIn
                                      ? 'Adicionar ao Carrinho'
                                      : 'Entre para Comprar',
                                  onPressed: (detailsProducts.areAllColorsEmpty(product) &&
                                              product.selectedDetails != null) ||
                                          (!detailsProducts.areAllColorsEmpty(product) &&
                                              product.selectedDetails != null &&
                                              detailsProducts.selectedColors != null)
                                      ? () {
                                          if (userManager.isLoggedIn) {
                                            context
                                                .read<CartManager>()
                                                .addToCart(product, detailsProducts);
                                            Navigator.pushNamed(
                                                context, RoutesNavigator.cartScreen);
                                          } else {
                                            Navigator.pushNamed(
                                                context, RoutesNavigator.loginScreen);
                                          }
                                        }
                                      : null,
                                );
                              }),
                            if (!widget.product!.hasStock)
                              SizedBox(
                                height: 44,
                                child: CustomButton(
                                  text: widget.product!.deleted
                                      ? 'Esgotado!'
                                      : 'Produto fora de estoque!',
                                  onPressed: null,
                                ),
                              )
                          ],
                        ),
                      )
                    ]);
                  },
                )),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
