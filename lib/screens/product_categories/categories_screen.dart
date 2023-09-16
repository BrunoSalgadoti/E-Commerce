import 'package:brn_ecommerce/common/button/custom_icon_button.dart';
import 'package:brn_ecommerce/common/custom_drawer/custom_drawer.dart';
import 'package:brn_ecommerce/common/functions/common_functions.dart';
import 'package:brn_ecommerce/models/product_category.dart';
import 'package:brn_ecommerce/models/product_category_manager.dart';
import 'package:brn_ecommerce/models/users_manager.dart';
import 'package:brn_ecommerce/screens/product_categories/componets/main_categories_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ProductCategoryManager, UserManager>(
      builder: (_, productCategory, userManager, __) {
        final List<ProductCategory>? categoriesListToScreen =
            productCategory.categoriesList?.toList();

        return Scaffold(
          drawer: const CustomDrawer(),
          appBar: AppBar(
            title: userManager.editingCategories
                ? const Text('Editando Categorias !',
              style: TextStyle(
                color: Colors.yellow
              ),
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
                      })
                  : userManager.adminEnable &&
                          userManager.editingCategories == true
                      ? CustomIconButton(
                          padding: const EdgeInsets.only(right: 15, left: 15),
                          iconData: Icons.check,
                          color: Colors.white,
                          size: 38,
                          onTap: () {
                            userManager.editingCategories = false;
                          })
                      : const SizedBox(width: 25),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: filteredCategories(categoriesListToScreen,
                      userManager.adminEnable, userManager.editingCategories)
                  .length,
              itemBuilder: (context, index) {
                final category = filteredCategories(
                    categoriesListToScreen,
                    userManager.adminEnable,
                    userManager.editingCategories)[index];
                return GestureDetector(
                    onTap: () {
                      //TODO: go to subcategories list
                      debugPrint(category.categoryTitle);
                    },
                    child: MainCategoriesCard(productCategory: category));
              },
            ),
          ),
        );
      },
    );
  }
}
