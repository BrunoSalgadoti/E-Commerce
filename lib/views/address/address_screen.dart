import 'package:brn_ecommerce/common/app_bar/complement_app_bar.dart';
import 'package:brn_ecommerce/common/app_bar/custom_app_bar.dart';
import 'package:brn_ecommerce/common/cards/recently_added_products.dart';
import 'package:brn_ecommerce/common/functions/common_functions.dart';
import 'package:brn_ecommerce/helpers/breakpoints.dart';
import 'package:brn_ecommerce/views/address/components/address_card.dart';
import 'package:brn_ecommerce/views/address/components/logic_price_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: kIsWeb ? const EdgeInsets.only(top: 0) : MediaQuery.of(context).padding,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = constraints.maxWidth;

            final isWide = screenWidth > mobileBreakpoint;
            final effectiveWidth = screenWidth > tabletBreakpoint ? tabletBreakpoint : screenWidth;

            return SingleChildScrollView(
              child: Column(
                children: [
                  const ComplementAppBar(asSliver: false),
                  SizedBox(
                    height: kIsWeb ? 10 : 0,
                  ),
                  SizedBox(
                    height: 60,
                    child: const CustomAppBar(
                      title: Text('Endereço de entrega:'),
                      showDrawerIcon: false,
                      showSearchButton: false,
                      removePadding: true,
                    ),
                  ),
                  SizedBox(
                    height: kIsWeb ? 10 : 8,
                  ),
                  Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: tabletBreakpoint),
                      child: Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        alignment: WrapAlignment.center,
                        children: [
                          SizedBox(
                            width: isWide
                                ? (effectiveWidth / 2) - 20 // grows to tabletBreakpoint
                                : screenWidth,
                            child: Column(
                              children: [
                                AddressCard(),
                                textForGoogleDecorations(
                                    titleForDecorations: 'Adicionados recentemente...'),
                                RecentlyAddedProducts(
                                  carrossel: false,
                                  productCategory: null,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: isWide ? 395 : 340,
                            width: isWide ? (effectiveWidth / 2) - 20 : screenWidth,
                            child: logicPriceCard(context: context),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
