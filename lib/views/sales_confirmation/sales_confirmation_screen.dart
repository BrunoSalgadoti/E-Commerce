import 'package:auto_size_text/auto_size_text.dart' show AutoSizeText;
import 'package:brn_ecommerce/common/app_bar/custom_app_bar.dart';
import 'package:brn_ecommerce/common/app_bar/custom_bottom_navigator_bar.dart';
import 'package:brn_ecommerce/common/buttons/custom_text_button.dart';
import 'package:brn_ecommerce/common/formatted_fields/format_values.dart';
import 'package:brn_ecommerce/common/functions/common_functions.dart';
import 'package:brn_ecommerce/common/images/root_assets.dart';
import 'package:brn_ecommerce/common/messengers/components/text_of_alerts_and_messengers.dart';
import 'package:brn_ecommerce/helpers/breakpoints.dart';
import 'package:brn_ecommerce/helpers/themes/get_another_colors.dart';
import 'package:brn_ecommerce/models/products/categories/product_sub_category.dart';
import 'package:brn_ecommerce/models/sales/order_client.dart';
import 'package:brn_ecommerce/views/orders/components/order_product_tile.dart';
import 'package:brn_ecommerce/common/cards/sales_suggestion_visited_products.dart';
import 'package:flutter/material.dart';

class SalesConfirmationScreen extends StatelessWidget {
  final OrderClient? orderClient;
  final SubCategory? subCategories;

  const SalesConfirmationScreen(this.orderClient, {super.key, this.subCategories});

  @override
  Widget build(BuildContext context) {
    final orderId = orderClient?.orderId ?? '';
    final price = orderClient?.price ?? 0.0;

    return Scaffold(
        appBar: CustomAppBar(
          title: 'Pedido Confirmado!',
          showDrawerIcon: false,
          showSearchButton: false,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Center(
            child: Container(
              constraints: BoxConstraints(maxWidth: tabletBreakpoint),
              child: SingleChildScrollView(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    SalesSuggestionVisitedProducts(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AutoSizeText(
                          AlertsMessengersText.salesSuggestionMessage,
                          maxFontSize: 25,
                          minFontSize: 12,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.fade,
                        ),
                        CustomTextButton(
                          buttonStyle: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(getButtonColor()),
                            shadowColor: WidgetStateProperty.all(getButtonColor().withAlpha(90)),
                            overlayColor: WidgetStateProperty.resolveWith<Color?>(
                              (states) {
                                if (states.contains(WidgetState.pressed)) {
                                  return Colors.orange; // cor ao pressionar
                                }
                                return null; // usa padrão quando não estiver pressionado
                              },
                            ),
                            elevation: WidgetStateProperty.all(20),
                          ),
                          text: 'Meus Pedidos',
                          fontColor: getTextColor(),
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                          onPressed: () => navigateToPageWithDrawer(context: context, pageIndex: 3),
                        ),
                      ],
                    ),
                    Center(
                        child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: mobileBreakpoint),
                      child: Card(
                        margin: const EdgeInsets.all(16),
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            Image.asset(
                              RootAssets.shoppingHappyGif,
                              width: 80,
                              height: 80,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    formattedOrderId(orderId),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  Text(
                                    formattedRealText(price),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: orderClient!.items!.map((e) {
                                return OrderProductTile(e);
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: customBottomNavigatorBar(context: context, withDrawer: false));
  }
}
