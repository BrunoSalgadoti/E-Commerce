import 'package:auto_size_text/auto_size_text.dart';
import 'package:brn_ecommerce/common/images/root_assets.dart' show RootAssets;
import 'package:brn_ecommerce/common/search/search_products_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:brn_ecommerce/helpers/breakpoints.dart';
import 'package:brn_ecommerce/helpers/themes/factory_colors/get_another_colors.dart';

class ComplementHomeAppBar extends StatelessWidget {
  const ComplementHomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Center(
        child: Container(
          clipBehavior: Clip.antiAlias,
          height: kIsWeb ? 90 : 60,
          width: tabletBreakpoint,
          decoration: BoxDecoration(
            color: getComplementHomeAppBarCollor(),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Store logo
                FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                    child: Image.asset(
                      RootAssets.storeImgLogo,
                      width: 120,
                      height: 100,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                // Title + search box
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: const AutoSizeText(
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
                      SizedBox(width: 9),

                      // Search field
                      SearchProductsField(),

                      Expanded(child: const SizedBox(width: 3)),

                      // Advertising placeholder area
                      Flexible(
                        child: Container(
                          color: Colors.black,
                          width: 200,
                          height: double.infinity,
                          alignment: Alignment.center,
                          child: AutoSizeText(
                            maxFontSize: 20,
                            minFontSize: 10,
                            maxLines: 2,
                            "Implementar \n Anuncio",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
