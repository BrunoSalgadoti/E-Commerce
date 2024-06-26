import 'package:brn_ecommerce/common/buttons/custom_icon_button.dart';
import 'package:brn_ecommerce/common/cards/flexible_product_card.dart';
import 'package:brn_ecommerce/common/drawer/components/page_manager.dart';
import 'package:brn_ecommerce/common/formatted_fields/custom_text_form_field.dart';
import 'package:brn_ecommerce/common/images/root_assets.dart';
import 'package:brn_ecommerce/common/miscellaneous/empty_page_indicator.dart';
import 'package:brn_ecommerce/common/sliding_up_panel/components/controller.dart';
import 'package:brn_ecommerce/common/sliding_up_panel/components/filters_result.dart';
import 'package:brn_ecommerce/common/sliding_up_panel/components/sliding_filters_products.dart';
import 'package:brn_ecommerce/common/sliding_up_panel/custom_sliding_up_painel.dart';
import 'package:brn_ecommerce/helpers/routes_navigator.dart';
import 'package:brn_ecommerce/models/products/categories/product_category.dart';
import 'package:brn_ecommerce/models/products/categories/product_category_manager.dart';
import 'package:brn_ecommerce/models/products/product.dart';
import 'package:brn_ecommerce/models/products/product_manager.dart';
import 'package:brn_ecommerce/views/product_categories/components/sub_categories_widget.dart';
import 'package:brn_ecommerce/views/product_categories/components/utils_for_category.dart';
import 'package:decorated_text/decorated_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CategoryProductScreen extends StatefulWidget {
  const CategoryProductScreen({super.key, required this.productCategory});

  final ProductCategory productCategory;

  @override
  CategoryProductScreenState createState() => CategoryProductScreenState();
}

class CategoryProductScreenState extends State<CategoryProductScreen> {
  final TextEditingController textController = TextEditingController();
  final Set<StatusOfProducts> selectedStatus = <StatusOfProducts>{};

  @override
  void initState() {
    if (!mounted) {
      Future.delayed(Duration.zero, () {
        final productManager = Provider.of<ProductManager>(context, listen: false);
        productManager.disableFilter();
        ControlsSlidingPanel.panelController.close();
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;

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
                  image: RootAssets.cartAwaitGif,
                )
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
                              padding: const EdgeInsets.fromLTRB(20, 30, 30, 0),
                              child: Column(children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 13),
                                  child: Image.asset(
                                    RootAssets.storeImgLogo,
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
                                            semanticLabel: 'Pesquisar na categoria',
                                          ),
                                          Expanded(
                                            child: Padding(
                                                padding: const EdgeInsets.fromLTRB(6, 6, 0, 0),
                                                child: CustomTextFormField(
                                                  controller: textController,
                                                  focusedBorder: InputBorder.none,
                                                  textFormFieldSize: 14,
                                                  obscureText: false,
                                                  hintText: 'Procurar produtos na categoria...',
                                                  hintSize: 14,
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
                                            semanticLabel: 'Limpar busca',
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
                                      child:
                                          UtilsForCategory(productManager, widget.productCategory)
                                              .carouselRecentProducts(
                                                  context, recentProductsFromCategory)),
                                customSlidingUpPainel(
                                  slidingTitleColor: primaryColor,
                                  textOfSlidingUpPanel: 'FILTRAR: Produtos na Categoria...',
                                  context: context,
                                  // panelController: controlsSlidingPanel.panelController,
                                  childrenOfPainel: SlidingFiltersProducts(
                                    selectedStatus: selectedStatus,
                                    // panelController: controlsSlidingPanel.panelController,
                                  ),
                                  body: null,
                                ),
                                widget.productCategory.subCategoryList!.isEmpty
                                    ? Container()
                                    : Padding(
                                        padding: const EdgeInsets.only(
                                          top: 10,
                                        ),
                                        child: ExpansionTile(
                                          title: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              const Icon(Icons.filter_list, size: 20),
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
                                              subCategories:
                                                  widget.productCategory.subCategoryList!.toList(),
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
                                if (productManager.filtersOn == true) filtersResult(),
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
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
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
                  Navigator.of(context).pushReplacementNamed(RoutesNavigator.cartScreen);
                  break;
                case 2:
                //TODO or not TODO: Tela e Rota para a tela
                // Navigator.of(context).pushNamed('/favoritos');
                case 3:
                  context.read<PageManager>().setPage(0);
                  Navigator.of(context).pop();
                  break;
              }
            },
          ));
    });
  }

  @override
  void dispose() {
    Future.delayed(Duration.zero, () {
      if (mounted) {
        final productManager = Provider.of<ProductManager>(context, listen: false);
        productManager.disableFilter();
        ControlsSlidingPanel.panelController.close();
      }
    });
    super.dispose();
  }
}
