import 'package:brn_ecommerce/common/drawer/custom_drawer.dart';
import 'package:brn_ecommerce/common/formatted_fields/format_values.dart';
import 'package:brn_ecommerce/common/images/root_assets.dart';
import 'package:brn_ecommerce/models/products/categories/product_sub_category.dart';
import 'package:brn_ecommerce/models/sales/order_client.dart';
import 'package:brn_ecommerce/views/orders/components/order_product_tile.dart';
import 'package:brn_ecommerce/views/sales_confirmation/components/sales_suggestion_widget.dart';
import 'package:flutter/material.dart';

class SalesConfirmationScreen extends StatelessWidget {
  final OrderClient? orderClient;
  final SubCategory? subCategories;

  const SalesConfirmationScreen(this.orderClient,
      {super.key, this.subCategories});

  @override
  Widget build(BuildContext context) {
    final orderId = orderClient?.orderId ?? '';
    final price = orderClient?.price ?? 0.0;

    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('Pedido Confirmado!'),
        centerTitle: true,
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Wrap(
          alignment: WrapAlignment.center,
          runAlignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            SalesSuggestionWidget(),
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
      )),
    );
  }
}
