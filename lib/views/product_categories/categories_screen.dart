import 'package:brn_ecommerce/common/buttons/custom_icon_button.dart';
import 'package:brn_ecommerce/common/drawer/custom_drawer.dart';
import 'package:brn_ecommerce/common/miscellaneous/empty_page_indicator.dart';
import 'package:brn_ecommerce/helpers/breakpoints.dart';
import 'package:brn_ecommerce/models/products/categories/product_category_manager.dart';
import 'package:brn_ecommerce/models/users/users_manager.dart';
import 'package:brn_ecommerce/views/product_categories/components/main_categories_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

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
                userManager.adminEnable && userManager.editingCategories == false
                    ? CustomIconButton(
                        padding: const EdgeInsets.only(right: 15, left: 15),
                        iconData: Icons.edit,
                        onTap: () {
                          userManager.editingCategories = true;
                        },
                  semanticLabel: 'Editar categorias',
                )
                    : userManager.adminEnable && userManager.editingCategories == true
                        ? CustomIconButton(
                            padding: const EdgeInsets.only(right: 15, left: 15),
                            iconData: Icons.check,
                            color: Colors.white,
                            size: 38,
                            onTap: () {
                              showMenu(
                                context: context,
                                position: const RelativeRect.fromLTRB(80, 80, 0, 0),
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
                  semanticLabel: 'Salvar categorias',
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
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: tabletBreakpoint),
                        child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            maxCrossAxisExtent: 255,
                            mainAxisExtent: 230,
                          ),
                          itemCount: productCategoryManager
                              .filterCategoriesActivated(
                                  userManager.adminEnable, userManager.editingCategories)
                              .length,
                          itemBuilder: (context, index) {
                            final category = productCategoryManager.filterCategoriesActivated(
                                userManager.adminEnable, userManager.editingCategories)[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed("/category_screen", arguments: category);
                              },
                              child: MainCategoriesCard(productCategory: category),
                            );
                          },
                        ),
                      ),
                    ),
                  ));
      },
    );
  }
}
