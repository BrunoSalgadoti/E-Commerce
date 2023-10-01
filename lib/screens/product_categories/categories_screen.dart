import 'package:brn_ecommerce/common/button/custom_icon_button.dart';
import 'package:brn_ecommerce/common/custom_drawer/custom_drawer.dart';
import 'package:brn_ecommerce/common/miscellaneous/empty_page_indicator.dart';
import 'package:brn_ecommerce/models/categories_of_products/product_category_manager.dart';
import 'package:brn_ecommerce/models/users_manager.dart';
import 'package:brn_ecommerce/screens/product_categories/components/main_categories_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<ProductCategoryManager, UserManager>(
      builder: (_, productCategoryManager, userManager, __) {
        return Scaffold(
            drawer: const CustomDrawer(),
            appBar: AppBar(
              title: userManager.editingCategories
                  ? const Text(
                      'Editando Categorias!',
                      style: TextStyle(color: Colors.yellow),
                    )
                  : const Text('Produtos por Categorias'),
              centerTitle: true,
              actions: [
                userManager.adminEnable &&
                        userManager.editingCategories == false
                    ? CustomIconButton(
                        padding: const EdgeInsets.only(right: 15, left: 15),
                        iconData: Icons.edit,
                        onTap: () {
                          userManager.editingCategories = true;
                        })
                    : userManager.adminEnable &&
                            userManager.editingCategories == true
                        ? CustomIconButton(
                            padding: const EdgeInsets.only(right: 15, left: 15),
                            iconData: Icons.check,
                            color: Colors.white,
                            size: 38,
                            onTap: () {
                              showMenu(
                                context: context,
                                position:
                                    const RelativeRect.fromLTRB(80, 80, 0, 0),
                                items: [
                                  const PopupMenuItem(
                                    value: 'Salvar',
                                    child: Text('Salvar'),
                                  ),
                                  const PopupMenuItem(
                                    value: 'Descartar',
                                    child: Text('Descartar'),
                                  ),
                                ],
                                elevation: 8.0,
                              ).then((value) async {
                                if (value == 'Salvar') {
                                  await productCategoryManager.updateCategory();
                                  productCategoryManager.filterCategoriesActivated(
                                      userManager.adminEnable, false);
                                  userManager.editingCategories = false;
                                } else {
                                  userManager.editingCategories = false;
                                }
                              });
                            },
                          )
                        : const SizedBox(width: 25),
              ],
            ),
            body: productCategoryManager.verifyCategoriesList()
                ? const EmptyPageIndicator(
                    title: 'Carregando...',
                    image: "assets/images/await.gif",
                    iconData: null,
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 3 / 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: productCategoryManager
                          .filterCategoriesActivated(userManager.adminEnable,
                              userManager.editingCategories)
                          .length,
                      itemBuilder: (context, index) {
                        final category =
                            productCategoryManager.filterCategoriesActivated(
                                userManager.adminEnable,
                                userManager.editingCategories)[index];
                        return GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  "/category_screen",
                                  arguments: category);
                            },
                            child:
                                MainCategoriesCard(productCategory: category));
                      },
                    ),
                  ));
      },
    );
  }
}
