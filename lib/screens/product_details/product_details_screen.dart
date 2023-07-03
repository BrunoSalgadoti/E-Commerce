import 'package:brn_ecommerce/common/button/custom_button.dart';
import 'package:brn_ecommerce/models/cart_manager.dart';
import 'package:brn_ecommerce/models/product.dart';
import 'package:brn_ecommerce/models/users_manager.dart';
import 'package:brn_ecommerce/screens/products/components/colors_widget.dart';
import 'package:brn_ecommerce/screens/products/components/products_widget.dart';
import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({Key? key, this.product, this.selectedSizeIndex})
      : super(key: key);

  final Product? product;
  final int? selectedSizeIndex;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int? selectedSizeIndex;

  @override
  void initState() {
    super.initState();
    selectedSizeIndex = widget.selectedSizeIndex;
  }

  void updateSelectedSizeIndex(int index) {
    setState(() {
      selectedSizeIndex = index;
      widget.product?.selectedSize = widget.product?.itemProducts?[index].size;
      widget.product?.selectedColors =
          null; // Reinicia as cores selecionadas ao alterar o tamanho
    });
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return ChangeNotifierProvider.value(
      value: widget.product,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(widget.product!.name!),
            centerTitle: true,
            actions: [
              IconButton(
                  icon: const Icon(Icons.share_outlined),
                  onPressed: () {
                    Navigator.pushNamed(context, '/share_product',
                        arguments: widget.product);
                  }),
              Consumer<UserManager>(
                builder: (_, userManager, __) {
                  if (userManager.adminEnable && !widget.product!.deleted) {
                    return IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        Navigator.pushNamed(context, '/edit_product',
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
          body: ListView(children: [
            FanCarouselImageSlider(
              imagesLink: widget.product!.images!.map((url) {
                return NetworkImage(url).url;
              }).toList(),
              isAssets: false,
              autoPlay: kIsWeb ? true : false,
              initalPageIndex: 0,
              showIndicator: true,
              indicatorActiveColor: primaryColor,
              indicatorDeactiveColor: Colors.blueGrey,
              sliderHeight: 400,
              slideViewportFraction: 0.8,
              sliderWidth: double.maxFinite,
              imageRadius: 10,
              imageFitMode: BoxFit.cover,
              expandImageWidth: double.maxFinite,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    widget.product!.name!,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: widget.product!.hasStock
                          ? Text(
                              'A partir de: ',
                              style: TextStyle(
                                  fontSize: 15, color: Colors.grey[600]),
                            )
                          : Text(
                              widget.product!.deleted
                                  ? 'Esgotado...!'
                                  : 'Aguadando reposição de estoque...',
                              style: TextStyle(
                                  fontSize: 15, color: Colors.grey[600]),
                            )),
                  widget.product!.hasStock
                      ? Text(
                          'R\$ ${widget.product!.basePrice.toStringAsFixed(2)}',
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
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
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
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
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
                  const Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      'Cor(es) do Produto:',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    alignment: WrapAlignment.spaceEvenly,
                    children: widget.product!
                        .itemProducts![selectedSizeIndex ?? 0].colorProducts!
                        .asMap() // Converter para Map<int, ColorsProducts>
                        .entries
                        .map((entry) {
                      final index = entry.key;
                      final colorProduct = entry.value;
                      return ColorsWidget(
                        key: ValueKey(index), // Usar o índice como chave única
                        colorsProducts: colorProduct,
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
          ])),
    );
  }
}
