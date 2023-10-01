import 'package:brn_ecommerce/common/cards/flexible_product_card.dart';
import 'package:brn_ecommerce/common/custom_text_form_field.dart';
import 'package:brn_ecommerce/common/formatted_fields/format_values.dart';
import 'package:brn_ecommerce/common/miscellaneous/empty_page_indicator.dart';
import 'package:brn_ecommerce/common/miscellaneous/tag_for_cards.dart';
import 'package:brn_ecommerce/common/sliding_up_panel/filters_sliding_up_panel.dart';
import 'package:brn_ecommerce/models/product.dart';
import 'package:brn_ecommerce/models/categories_of_products/product_category.dart';
import 'package:brn_ecommerce/models/categories_of_products/product_category_manager.dart';
import 'package:brn_ecommerce/models/product_manager.dart';
import 'package:brn_ecommerce/screens/product_categories/components/sub_categories_widget.dart';
import 'package:brn_ecommerce/screens/product_categories/components/utils_for_category.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:decorated_text/decorated_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CategoryProductScreen extends StatefulWidget {
  const CategoryProductScreen({Key? key, required this.productCategory})
      : super(key: key);

  final ProductCategory productCategory;

  @override
  CategoryProductScreenState createState() => CategoryProductScreenState();
}

class CategoryProductScreenState extends State<CategoryProductScreen> {
  final TextEditingController textController = TextEditingController();
  final CarouselController carouselController = CarouselController();
  final PanelController panelController = PanelController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final productManager =
          Provider.of<ProductManager>(context, listen: false);
      productManager.disableFilter();
      productManager.filtersOn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Set<StatusOfProducts> selectedStatus = <StatusOfProducts>{};

    return Consumer2<ProductManager, ProductCategoryManager>(
        builder: (_, productManager, productCategoryManager, __) {

      //TODO:  Ajustar o layout com base no tamanho da tela
      final screenSize = MediaQuery.of(context).size;
      final isSmallScreen = screenSize.width < 600;
      final isMediumScreen =
          screenSize.width >= 600 && screenSize.width < 1200;

      final List<Product> recentProductsFromCategory =
          UtilsForCategory(productManager, widget.productCategory)
              .loadRecentProducts();
      final List<Product> allProductsFromCategory =
          UtilsForCategory(productManager, widget.productCategory)
              .loadCategoryProducts();
      final categoryImage =
          UtilsForCategory(productManager, widget.productCategory)
              .buildCategoryImage(isSmallScreen, isMediumScreen);

      return Scaffold(
          backgroundColor: Colors.white,
          body: allProductsFromCategory.isEmpty
              ? const EmptyPageIndicator(
                  title: 'Carregando...',
                  titleColor: Colors.black,
                  iconData: null,
                  iconColor: Colors.black,
                  image: "assets/images/await.gif")
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: categoryImage,
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 30, 20, 0),
                              child: Column(children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 13),
                                  child: Image.asset(
                                    'assets/logo/storeLogo.png',
                                    width: 155,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: DecoratedGoogleFontText(
                                    'Categoria:\n'
                                    '${widget.productCategory.categoryTitle}',
                                    fontMethod: GoogleFonts.croissantOne,
                                    fillColor: Colors.black,
                                    fontSize: 26,
                                    fontWeight: FontWeight.w800,
                                    borderWidth: 0.8,
                                    borderColor: Colors.white,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Container(
                                    width: double.infinity,
                                    height: 52,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 0, 15, 0),
                                      child: Row(
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              //TODO:  Implemente a lógica de pesquisa aqui
                                            },
                                            child: const Icon(
                                              Icons.search,
                                              color: Colors.black,
                                              size: 24,
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        6, 6, 0, 0),
                                                child: CustomTextFormField(
                                                  controller: textController,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  textFormFieldSize: 16,
                                                  obscureText: false,
                                                  hintText:
                                                      'Procurar produtos na categoria...',
                                                  hintSize: 16,
                                                  onSubmitted: (_) async {
                                                    //TODO: Implemente a lógica de pesquisa aqui
                                                  },
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const Align(
                                  alignment: Alignment(-1, 0),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(10, 10, 0, 13),
                                    child: DecoratedGoogleFontText(
                                      'Adicionados Recentemente!',
                                      fontMethod: GoogleFonts.amaranth,
                                      fillColor: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      borderWidth: 0.8,
                                      borderColor: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  height: 185,
                                  child: CarouselSlider(
                                      carouselController: carouselController,
                                      options: CarouselOptions(
                                        initialPage: 0,
                                        viewportFraction: 0.5,
                                        disableCenter: true,
                                        enlargeCenterPage: true,
                                        enlargeFactor: 0.25,
                                        enableInfiniteScroll: true,
                                        scrollDirection: Axis.horizontal,
                                        autoPlay: true,
                                      ),
                                      items: recentProductsFromCategory
                                          .map<Widget>((image) {
                                        return Stack(
                                          fit: StackFit.expand,
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  30),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  30)),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      spreadRadius: 1.5,
                                                      blurRadius: 4,
                                                      offset:
                                                          const Offset(0, 5),
                                                    ),
                                                  ]),
                                              clipBehavior: Clip.antiAlias,
                                              child: Image.network(
                                                image.images!.first,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(10),
                                              child: TagForCard(
                                                  data: 'A partir:\n '
                                                      '${formattedRealText(image.basePrice)}',
                                                  googleFonts: GoogleFonts
                                                      .akayaTelivigala,
                                                  textFontSize: 16,
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  backgroundColor:
                                                      Colors.white,
                                                  containerWidth: 90),
                                            ),
                                            Positioned(
                                              bottom: 10,
                                              right: 10,
                                              child: Material(
                                                  color: Theme.of(context)
                                                      .primaryColor
                                                      .withAlpha(90),
                                                  child: IconButton(
                                                      icon: const Icon(
                                                          Icons.open_in_new,
                                                          semanticLabel:
                                                              'Visualizar Produto',
                                                          size: 20,
                                                          color:
                                                              Colors.white),
                                                      onPressed: () {})),
                                            ),
                                            Positioned(
                                              bottom: 10,
                                              right: 10,
                                              child: Container(),
                                            ),
                                          ],
                                        );
                                      }).toList()),
                                ),
                                FiltersSlidingUpPanel(
                                  textOfSlidingUpPanel:
                                      'Filtre por produtos na Categoria...',
                                  panelController: panelController,
                                  selectedStatus: selectedStatus,
                                  paddingContentCheckbox:
                                      const EdgeInsets.only(right: 30),
                                ),
                                widget.productCategory.subCategoryList!
                                        .isEmpty
                                    ? Container()
                                    : Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10),
                                        child: ExpansionTile(
                                          title: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              const Icon(Icons.filter_list,
                                                  size: 30),
                                              FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child:
                                                    DecoratedGoogleFontText(
                                                  'Seções de: '
                                                  '${widget.productCategory.categoryTitle}',
                                                  fontMethod:
                                                      GoogleFonts.amaranth,
                                                  fillColor: Colors.black,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w800,
                                                  borderWidth: 0.8,
                                                  borderColor: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                          children: [
                                            SubCategoriesWidget(
                                              subCategories: widget
                                                  .productCategory
                                                  .subCategoryList!
                                                  .toList(),
                                            ),
                                          ],
                                        )),
                              ]),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(children: [
                                if (productManager.filtersOn == true)
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Filtro Ativo:',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                          color: Colors.redAccent,
                                        ),
                                      ),
                                      Text(
                                        '${productManager.activeFilterName}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Colors.black,
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.close,
                                          size: 20,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {
                                          productManager.disableFilter();
                                        },
                                      ),
                                    ],
                                  ),
                                if (productManager.filteredProducts.isEmpty)
                                  productManager.filtersOn == true
                                      ? const EmptyPageIndicator(
                                          title: 'Pesquisa não encontrada...',
                                          iconData: Icons.search_off,
                                          image: null,
                                          duration: null,
                                        )
                                      : const EmptyPageIndicator(
                                          title: 'Carregando Produtos...',
                                          image: "assets/images/await.gif",
                                          iconData: null,
                                        )
                                else
                                  Builder(
                                    builder: (context) {
                                      final categoryItens = allProductsFromCategory;
                                      return ListView.builder(
                                        padding: EdgeInsets.zero,
                                        primary: false,
                                        shrinkWrap: true,
                                        itemCount: categoryItens.length,
                                        itemBuilder: (context, index) {
                                          final categoryItens = allProductsFromCategory[index];
                                          return FlexibleProductCard(
                                            product: categoryItens,
                                            isVertical: false,
                                          );
                                        },
                                      );
                                    },
                                  )
                              ]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Theme.of(context).primaryColor,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.category),
                label: 'Categorias',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: 'Carrinho',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Meus Favoritos',
              ),
            ],
            showUnselectedLabels: true,
            selectedItemColor: Colors.black54,
            unselectedItemColor: Colors.black54,
            onTap: (index) {
              switch (index) {
                case 0:
                  Navigator.of(context).pop();
                  break;
                case 1:
                  Navigator.of(context).pushNamed('/cart');
                  break;
                case 2:
                  //TODO: Rota para a tela
                  // Navigator.of(context).pushNamed('/favoritos');
                  break;
              }
            },
          ));
    });
  }
}
