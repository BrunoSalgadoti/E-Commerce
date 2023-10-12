import 'package:brn_ecommerce/common/button/custom_icon_button.dart';
import 'package:brn_ecommerce/common/cards/flexible_product_card.dart';
import 'package:brn_ecommerce/common/custom_text_form_field.dart';
import 'package:brn_ecommerce/common/miscellaneous/empty_page_indicator.dart';
import 'package:brn_ecommerce/common/sliding_up_panel/filters_sliding_up_panel.dart';
import 'package:brn_ecommerce/models/categories_of_products/product_category.dart';
import 'package:brn_ecommerce/models/categories_of_products/product_category_manager.dart';
import 'package:brn_ecommerce/models/product.dart';
import 'package:brn_ecommerce/models/product_manager.dart';
import 'package:brn_ecommerce/screens/product_categories/components/sub_categories_widget.dart';
import 'package:brn_ecommerce/screens/product_categories/components/utils_for_category.dart';
import 'package:decorated_text/decorated_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CategoryProductScreen extends StatefulWidget {
  const CategoryProductScreen({Key? key, required this.productCategory}) : super(key: key);

  final ProductCategory productCategory;

  @override
  CategoryProductScreenState createState() => CategoryProductScreenState();
}

class CategoryProductScreenState extends State<CategoryProductScreen> {
  final TextEditingController textController = TextEditingController();
  final PanelController panelController = PanelController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final productManager = Provider.of<ProductManager>(context, listen: false);
      productManager.filtersOn = false;
      productManager.search = '';
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Set<StatusOfProducts> selectedStatus = <StatusOfProducts>{};

    return Consumer2<ProductManager, ProductCategoryManager>(
        builder: (_, productManager, productCategoryManager, __) {
      final List<Product> recentProductsFromCategory =
          UtilsForCategory(productManager, widget.productCategory).loadRecentProducts();
      final categoryImage =
          UtilsForCategory(productManager, widget.productCategory).buildCategoryImage();

      List<Product> allProductsFromCategory =
          UtilsForCategory(productManager, widget.productCategory).loadCategoryProducts();

      void goSearch() {
        if (textController.text.isNotEmpty) {
          productManager.search = textController.text;
        }
        allProductsFromCategory = productManager.filteredProducts.toList();
      }

      return Scaffold(
          backgroundColor: Colors.white,
          body: allProductsFromCategory.isEmpty &&
                  productManager.filtersOn == false &&
                  productManager.search.isEmpty
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
                              padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
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
                                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                      child: Row(
                                        children: [
                                          CustomIconButton(
                                            iconData: Icons.search,
                                            size: 24,
                                            color: Colors.black,
                                            onTap: goSearch,
                                          ),
                                          Expanded(
                                            child: Padding(
                                                padding: const EdgeInsets.fromLTRB(6, 6, 0, 0),
                                                child: CustomTextFormField(
                                                  controller: textController,
                                                  focusedBorder: InputBorder.none,
                                                  textFormFieldSize: 16,
                                                  obscureText: false,
                                                  hintText:
                                                      'Procurar produtos na categoria...',
                                                  hintSize: 16,
                                                  onSubmitted: (value) => goSearch,
                                                )),
                                          ),
                                          CustomIconButton(
                                            iconData: Icons.close,
                                            color: productManager.search.isEmpty
                                                ? Colors.black
                                                : Colors.red,
                                            onTap: () {
                                              productManager.search = '';
                                              textController.clear();
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                if (productManager.search.isEmpty)
                                  const Align(
                                    alignment: Alignment(-1, 0),
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(10, 10, 0, 13),
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
                                if (productManager.search.isEmpty)
                                  SizedBox(
                                      width: double.infinity,
                                      height: 185,
                                      child: UtilsForCategory(
                                              productManager, widget.productCategory)
                                          .carouselRecentProducts(
                                              context, recentProductsFromCategory)),
                                FiltersSlidingUpPanel(
                                  textOfSlidingUpPanel: 'FILTRAR: Produtos na Categoria...',
                                  panelController: panelController,
                                  selectedStatus: selectedStatus,
                                  paddingContentCheckbox: const EdgeInsets.only(right: 30),
                                ),
                                widget.productCategory.subCategoryList!.isEmpty
                                    ? Container()
                                    : Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: ExpansionTile(
                                          title: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              const Icon(Icons.filter_list, size: 28),
                                              FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: DecoratedGoogleFontText(
                                                  'Seções de: '
                                                  '${widget.productCategory.categoryTitle}',
                                                  fontMethod: GoogleFonts.amaranth,
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
                                                  .productCategory.subCategoryList!
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
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.center,
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
                                if (allProductsFromCategory.isEmpty)
                                  productManager.filtersOn == true ||
                                          productManager.search.isNotEmpty
                                      ? EmptyPageIndicator(
                                          title: productManager.filtersOn == true
                                              ? 'Filtro sem retorno...'
                                              : 'Pesquisa não encontrada...',
                                          iconData: Icons.search_off,
                                          image: null,
                                          duration: null,
                                          titleColor: Colors.black,
                                          iconColor: Colors.black,
                                        )
                                      : const EmptyPageIndicator(
                                          title: 'Carregando Produtos...',
                                          image: "assets/images/await.gif",
                                          iconData: null,
                                          titleColor: Colors.black,
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
