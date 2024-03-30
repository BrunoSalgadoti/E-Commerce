import 'dart:io';

import 'package:brn_ecommerce/common/formatted_fields/format_values.dart';
import 'package:brn_ecommerce/common/miscellaneous/tag_for_cards.dart';
import 'package:brn_ecommerce/models/categories_of_products/product_category.dart';
import 'package:brn_ecommerce/models/product.dart';
import 'package:brn_ecommerce/models/product_manager.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UtilsForCategory {
  UtilsForCategory(this.productManager, this.productCategory);

  final ProductManager productManager;
  final ProductCategory productCategory;

  // Function to load recent products and sort by insertion date
  List<Product> loadRecentProducts() {
    List<Product> sortedProducts = productManager.allProducts
        .where((p) => p.isValid! && p.hasStock && p.categoryOfProduct == productCategory.categoryID)
        .take(10)
        .toList();

    //TODO: Inserir variável no produto changeDate não modificar a data de inserção do produto.
    //TODO: Ajustar verificação para comparação de data e mês, OBS: classificando por dia!!

    sortedProducts.sort((a, b) {
      // Verifica se a inserção de a e b é nula e, se for, retorna Timestamp.now()
      final aInsertion = a.insertionDate ?? Timestamp.now();
      final bInsertion = b.insertionDate ?? Timestamp.now();

      // Compara as datas de inserção
      return bInsertion.compareTo(aInsertion);
    });

    return sortedProducts;
  }

  // Load all products from the specific category
  List<Product> loadCategoryProducts() {
    List<Product> allCategoryProducts = productManager.filteredProducts
        .where((p) => p.categoryOfProduct == productCategory.categoryID)
        .toList();

    return allCategoryProducts;
  }

  Widget carouselRecentProducts(BuildContext context, List<Product> recentProductsFromCategory) {
    final CarouselController carouselController = CarouselController();

    return CarouselSlider(
        carouselController: carouselController,
        options: CarouselOptions(
          aspectRatio: 1 / 1,
          initialPage: 0,
          height: 280,
          viewportFraction: 0.5,
          disableCenter: true,
          enlargeCenterPage: true,
          enlargeFactor: 0.27,
          enableInfiniteScroll: true,
          scrollDirection: Axis.horizontal,
          autoPlay: true,
        ),
        items: recentProductsFromCategory.map<Widget>((product) {
          return Stack(
            fit: StackFit.expand,
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1.5,
                        blurRadius: 4,
                        offset: const Offset(0, 5),
                      ),
                    ]),
                clipBehavior: Clip.antiAlias,
                child: Image.network(
                  product.images!.first,
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: TagForCard(
                    data: 'A partir:\n '
                        '${formattedRealText(product.basePrice)}',
                    googleFonts: GoogleFonts.akayaTelivigala,
                    textFontSize: 16,
                    alignment: Alignment.bottomLeft,
                    backgroundColor: Colors.white,
                    containerWidth: 90,
                  )),
              Positioned(
                bottom: 10,
                right: 10,
                child: Material(
                    color: Theme.of(context).primaryColor.withAlpha(90),
                    child: IconButton(
                        icon: const Icon(Icons.open_in_new,
                            semanticLabel: 'Visualizar Produto', size: 20, color: Colors.white),
                        onPressed: () {
                          Navigator.pushNamed(context, "/product", arguments: product);
                        })),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: Container(),
              ),
            ],
          );
        }).toList());
  }

  // Build and verify category main image based on type
  Widget buildCategoryImage() {
    if (productCategory.categoryImg != null && productCategory.categoryImg != "") {
      if (productCategory.categoryImg is File) {
        return Image.file(
          productCategory.categoryImg as File,
          width: double.infinity,
          height: 270,
          fit: BoxFit.cover,
        );
      } else {
        return Image.network(
          productCategory.categoryImg!,
          width: double.infinity,
          height: 270,
          fit: BoxFit.cover,
        );
      }
    } else {
      return Image.asset(
        'assets/images/CategoriesBackground.jpg',
        width: double.infinity,
        height: 270,
        fit: BoxFit.cover,
      );
    }
  }
}
