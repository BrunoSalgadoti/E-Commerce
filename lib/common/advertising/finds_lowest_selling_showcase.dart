import 'package:auto_size_text/auto_size_text.dart';
import 'package:brn_ecommerce/common/formatted_fields/format_values.dart';
import 'package:brn_ecommerce/common/functions/common_functions.dart';
import 'package:brn_ecommerce/common/miscellaneous/tag_for_cards.dart';
import 'package:brn_ecommerce/helpers/breakpoints.dart';
import 'package:brn_ecommerce/helpers/routes_navigator.dart';
import 'package:brn_ecommerce/models/products/product.dart';
import 'package:brn_ecommerce/models/products/product_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FindsLowestSellingShowcase extends StatelessWidget {
  final bool isSilver;

  const FindsLowestSellingShowcase({super.key, this.isSilver = false});

  @override
  Widget build(BuildContext context) {
    final productManager = Provider.of<ProductManager>(context);
    final products = productManager.lowestSellingProductsManager
        ?.getLowestSellingProducts(count: 15) ??
        [];

    if (products.isEmpty) return const SizedBox.shrink();

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: tabletBreakpoint),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            textForGoogleDecorations(titleForDecorations: 'Achadinhos especiais pra você'),
            const SizedBox(height: 10),
            Wrap(
              spacing: 13,
              runSpacing: 13,
              alignment: WrapAlignment.center,
              children: products.map((product) {
                return _FindsItem(
                  product: product,
                  isSilver: isSilver,
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _FindsItem extends StatefulWidget {
  final Product product;
  final bool isSilver;

  const _FindsItem({
    required this.product,
    this.isSilver = false,
  });

  @override
  State<_FindsItem> createState() => _FindsItemState();
}

class _FindsItemState extends State<_FindsItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final bgColor = widget.isSilver ? Colors.grey[200]! : Colors.white;
    final borderColor = widget.isSilver ? Colors.grey[400]! : Colors.orange;

    final double width = 190 * 1.1;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            width: width,
            height: 80,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: borderColor, width: 1.5),
              boxShadow: [
                if (_hovered)
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 12,
                    offset: const Offset(0, 9),
                  ),
              ],
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(50),
              onTap: () {
                Navigator.of(context).pushNamed(
                  RoutesNavigator.productDetailsScreen,
                  arguments: widget.product,
                );
              },
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 7,
                          offset: const Offset(5, 0),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(50),
                      ),
                      child: Image.network(
                        widget.product.images?.first ?? '',
                        width: 90,
                        height: 80,
                        fit: BoxFit.fill,
                        errorBuilder: (_, __, ___) => Container(
                          width: 90,
                          height: 80,
                          color: Colors.grey[300],
                          alignment: Alignment.center,
                          child: const Icon(Icons.image_not_supported, size: 30),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8, height: 10),
                  Expanded(
                    child: AutoSizeText(
                      widget.product.name ?? '',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 2,
                      maxFontSize: 18,
                      minFontSize: 11,
                    ),
                  ),
                  const SizedBox(width: 7),
                ],
              ),
            ),
          ),
          Positioned(
            top: -7,
            right: 15,
            child: TagForCard(
              data: "Somente: ${formattedRealText(widget.product.basePrice)}",
              alignment: Alignment.center,
              backgroundColor: Colors.orange,
              containerWidth: 90,
              containerHeight: 28,
              textFontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
