import 'package:brn_ecommerce/common/functions/common_functions.dart';
import 'package:brn_ecommerce/helpers/breakpoints.dart';
import 'package:brn_ecommerce/helpers/routes_navigator.dart' show RoutesNavigator;
import 'package:brn_ecommerce/helpers/themes/get_another_colors.dart';
import 'package:brn_ecommerce/models/products/categories/product_category.dart';
import 'package:brn_ecommerce/models/products/categories/product_category_manager.dart';
import 'package:brn_ecommerce/models/users/users_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CategoriesShowcase extends StatelessWidget {
  const CategoriesShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    final userManager = context.watch<UserManager>();
    final categoryManager = context.watch<ProductCategoryManager>();

    final activeCategories = categoryManager.filterCategoriesActivated(
      userManager.adminEnable,
      false,
    );

    if (activeCategories.isEmpty) return const SizedBox.shrink();

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: tabletBreakpoint,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            textForGoogleDecorations(titleForDecorations: 'Visite nossas categorias'),
            const SizedBox(height: 10),
            LayoutBuilder(
              builder: (context, constraints) {
                final screenWidth = constraints.maxWidth;

                // Define o número mínimo de cards por linha
                int cardsPerLine = 2;
                if (screenWidth >= 600) cardsPerLine = 4;
                if (screenWidth >= 900) cardsPerLine = 5;

                // Calcula a largura e altura proporcional de cada card
                final cardWidth = (screenWidth - (20 * (cardsPerLine - 1))) / cardsPerLine;
                final cardHeight = cardWidth / 2; // semicirculo = metade da largura

                return Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 20,
                  runSpacing: 2,
                  children: activeCategories.map((category) {
                    return HoverableCategoryItem(
                      productCategory: category,
                      cardWidth: cardWidth,
                      cardHeight: cardHeight,
                    );
                  }).toList(),
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class HoverableCategoryItem extends StatefulWidget {
  final ProductCategory? productCategory;
  final double? cardWidth;
  final double? cardHeight;

  const HoverableCategoryItem({
    super.key,
    this.productCategory,
    this.cardWidth,
    this.cardHeight,
  });

  @override
  State<HoverableCategoryItem> createState() => _HoverableCategoryItemState();
}

class _HoverableCategoryItemState extends State<HoverableCategoryItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final width = widget.cardWidth ?? 210;
    final height = widget.cardHeight ?? width / 2;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Column(
        children: [
          AnimatedScale(
            scale: _isHovered ? 1.15 : 1.0,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            child: SizedBox(
              width: width,
              height: height,
              child: Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(99),
                    topRight: Radius.circular(99),
                  ),
                ),
                clipBehavior: Clip.hardEdge,
                elevation: 6,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      RoutesNavigator.categoryProductsScreen,
                      arguments: widget.productCategory!,
                    );
                  },
                  child: buildCategoryImage(productCategory: widget.productCategory!),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          textForGoogleDecorations(
            titleForDecorations: widget.productCategory?.categoryTitle ?? "",
            fontMethod: GoogleFonts.rancho,
            fillColor: getTextColorBasedOnBackground(Colors.yellow.withAlpha(90)),
            fontSize: 20,
            fontWeight: FontWeight.w500,
            borderColor: getBorderColorInvertedTextColor(Colors.orange),
          ),
        ],
      ),
    );
  }
}
