import 'package:brn_ecommerce/common/app_bar/custom_bottom_navigator_bar.dart';
import 'package:brn_ecommerce/common/buttons/custom_icon_button.dart';
import 'package:brn_ecommerce/common/cards/flexible_product_card.dart';
import 'package:brn_ecommerce/common/cards/recently_added_products.dart';
import 'package:brn_ecommerce/common/formatted_fields/custom_text_form_field.dart';
import 'package:brn_ecommerce/common/functions/common_functions.dart';
import 'package:brn_ecommerce/common/images/root_assets.dart';
import 'package:brn_ecommerce/common/miscellaneous/empty_page_indicator.dart';
import 'package:brn_ecommerce/common/sliding_up_panel/components/controller.dart';
import 'package:brn_ecommerce/common/sliding_up_panel/components/filters_result.dart';
import 'package:brn_ecommerce/common/sliding_up_panel/components/sliding_filters_products.dart';
import 'package:brn_ecommerce/common/sliding_up_panel/custom_sliding_up_painel.dart';
import 'package:brn_ecommerce/models/products/categories/product_category.dart';
import 'package:brn_ecommerce/models/products/product.dart';
import 'package:brn_ecommerce/models/products/product_manager.dart';
import 'package:brn_ecommerce/views/product_categories/components/sub_categories_widget.dart';
import 'package:brn_ecommerce/views/product_categories/components/utils_for_category.dart';
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

    return Consumer<ProductManager>(
      builder: (_, productManager, __) {
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
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 13),
                                    child: Image.asset(
                                      RootAssets.storeImgLogo,
                                      width: 200,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: textForGoogleDecorations(
                                      titleForDecorations: 'Categoria:\n'
                                          '${widget.productCategory.categoryTitle}',
                                      fontMethod: GoogleFonts.croissantOne,
                                      fontSize: 26,
                                      fillColor: Colors.black,
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
                                    Align(
                                      alignment: Alignment(-1, 0),
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(10, 10, 0, 13),
                                        child: textForGoogleDecorations(
                                          titleForDecorations: 'Adicionados recentemente...',
                                          fontMethod: GoogleFonts.amaranth,
                                          borderWidth: 0.2,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  if (productManager.search.isEmpty)
                                    RecentlyAddedProducts(
                                      carrossel: true,
                                      productCategory: widget.productCategory,
                                    ),
                                  customSlidingUpPainel(
                                    slidingTitleColor: primaryColor,
                                    textOfSlidingUpPanel: 'FILTRAR: Produtos na Categoria...',
                                    context: context,
                                    childrenOfPainel: SlidingFiltersProducts(
                                      selectedStatus: selectedStatus,
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
                                                  child: textForGoogleDecorations(
                                                    titleForDecorations: 'Seções de: '
                                                        '${widget.productCategory.categoryTitle}',
                                                    borderColor: Colors.white,
                                                    fontSize: 20,
                                                    fillColor: Colors.black,
                                                    fontMethod: GoogleFonts.amaranth,
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
                                ],
                              ),
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
                              child: Column(
                                children: [
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
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
          bottomNavigationBar: customBottomNavigatorBar(context: context, withDrawer: true),
        );
      },
    );
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
