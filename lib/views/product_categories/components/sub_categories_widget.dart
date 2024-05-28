import 'package:brn_ecommerce/models/products/categories/product_sub_category.dart';
import 'package:brn_ecommerce/views/product_categories/components/sub_categories_card.dart';
import 'package:flutter/material.dart';

class SubCategoriesWidget extends StatefulWidget {
  final List<SubCategory> subCategories;

  const SubCategoriesWidget({
    super.key,
    required this.subCategories,
  });

  @override
  State<SubCategoriesWidget> createState() => _SubCategoriesWidgetState();
}

class _SubCategoriesWidgetState extends State<SubCategoriesWidget> {
  final int itemsPerPage = 6;
  int currentPage = 0;
  PageController pageController = PageController();

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final totalItems = widget.subCategories.length;
    final totalPages = (totalItems / itemsPerPage).ceil();

    return Column(
      children: [
        SizedBox(
          height: 250,
          child: PageView.builder(
            itemCount: totalPages,
            controller: pageController,
            onPageChanged: (page) {
              setState(() {
                currentPage = page;
              });
            },
            itemBuilder: (context, pageIndex) {
              final startIndex = pageIndex * itemsPerPage;
              final endIndex = (startIndex + itemsPerPage).clamp(0, totalItems);

              final pageItems = widget.subCategories.sublist(startIndex, endIndex);

              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 0.0,
                  mainAxisSpacing: 0.0,
                ),
                itemCount: pageItems.length,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  final item = pageItems[index];
                  return SubCategoriesCard(
                    subCategory: item,
                  );
                },
              );
            },
          ),
        ),
        if (totalPages > 1)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(totalPages, (index) {
              return Padding(
                padding: const EdgeInsets.only(top: 5, right: 5),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentPage == index ? Colors.blue : Colors.grey,
                  ),
                  width: 10,
                  height: 10,
                ),
              );
            }),
          ),
      ],
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
