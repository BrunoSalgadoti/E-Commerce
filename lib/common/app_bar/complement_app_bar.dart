import 'package:auto_size_text/auto_size_text.dart';
import 'package:brn_ecommerce/common/images/root_assets.dart' show RootAssets;
import 'package:brn_ecommerce/common/search/search_products_field.dart';
import 'package:brn_ecommerce/helpers/breakpoints.dart';
import 'package:brn_ecommerce/helpers/themes/get_another_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ComplementAppBar extends StatelessWidget {
  final bool asSliver;
  final EdgeInsets? padding;

  const ComplementAppBar({
    super.key,
    required this.asSliver,
    this.padding, //by default it keeps as sliver
  });

  Widget _buildContent(BuildContext context) {
    return Center(
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: Container(
          clipBehavior: Clip.antiAlias,
          height: kIsWeb ? 120 : 85,
          width: tabletBreakpoint,
          decoration: BoxDecoration(
            color: getComplementAppBarCollor(),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo
              FittedBox(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                  child: Image.asset(
                    RootAssets.storeImgLogo,
                    width: 120,
                    height: 120,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              // Title + Search + Ad
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Flexible(
                      child: AutoSizeText(
                        "Em Construção",
                        minFontSize: 10,
                        maxFontSize: 20,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 9),

                    // Search Field/Icon (responsive)
                    const SearchProductsField(),

                    const SizedBox(width: 3),

                    // Ad space (placeholder)
                    Flexible(
                      child: Container(
                        color: Colors.black,
                        width: 200,
                        height: double.infinity,
                        alignment: Alignment.center,
                        child: const AutoSizeText(
                          "Implementar \n Anuncio",
                          maxFontSize: 20,
                          minFontSize: 10,
                          maxLines: 1,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (asSliver == true) {
      return SliverToBoxAdapter(child: _buildContent(context));
    } else {
      return _buildContent(context);
    }
  }
}
