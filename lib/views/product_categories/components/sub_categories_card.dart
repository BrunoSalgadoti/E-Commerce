import 'package:brn_ecommerce/models/products/categories/product_sub_category.dart';
import 'package:flutter/material.dart';

class SubCategoriesCard extends StatelessWidget {
  const SubCategoriesCard({
    super.key,
    required this.subCategory,
  });

  final SubCategory subCategory;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //TODO: Rota para a tela da seção
      onTap: () => debugPrint('${subCategory.subCategoryTitle}'),
      child: Card(
        semanticContainer: true,
        elevation: 0.5,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: [
              subCategory.iconSubCategories == null || subCategory.iconSubCategories == ""
                  ? const Icon(
                      Icons.star,
                      size: 38,
                      color: Colors.black54,
                    )
                  : Text('${subCategory.iconSubCategories}'),
              const SizedBox(height: 10),
              SizedBox(
                width: 98,
                height: 50,
                child: Text(
                  '${subCategory.subCategoryTitle}',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
