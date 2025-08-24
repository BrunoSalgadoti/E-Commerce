import 'package:auto_size_text/auto_size_text.dart' show AutoSizeText;
import 'package:brn_ecommerce/common/app_bar/custom_app_bar.dart';
import 'package:brn_ecommerce/common/app_bar/custom_bottom_navigator_bar.dart';
import 'package:brn_ecommerce/common/buttons/custom_text_button.dart';
import 'package:brn_ecommerce/common/formatted_fields/format_values.dart';
import 'package:brn_ecommerce/common/functions/common_functions.dart';
import 'package:brn_ecommerce/common/images/root_assets.dart';
import 'package:brn_ecommerce/common/messengers/components/text_of_alerts_and_messengers.dart';
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
        child: SingleChildScrollView(
          child: Wrap(
            alignment: WrapAlignment.center,
            runAlignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              SalesSuggestionVisitedProducts(),
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
                text: 'Meus Pedidos',
                fontColor: Colors.lightGreen,
                fontWeight: FontWeight.w900,
                fontSize: 20,
                onPressed: () => navigateToPageWithDrawer(context: context, pageIndex: 3),
              ),
              Card(
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
                                fontWeight: FontWeight.w600, color: Theme.of(context).primaryColor),
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
            ],
          ),
        ),
      ),
        bottomNavigationBar: customBottomNavigatorBar(context: context, withDrawer: false));
  }
}
