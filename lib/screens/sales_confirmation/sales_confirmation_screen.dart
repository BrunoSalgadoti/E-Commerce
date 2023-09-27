import 'package:brn_ecommerce/models/order_client.dart';
import 'package:brn_ecommerce/screens/orders/components/order_product_tile.dart';
import 'package:flutter/material.dart';

import '../../common/formatted_fields/format_values.dart';

class SalesConfirmationScreen extends StatelessWidget {
  const SalesConfirmationScreen(
    this.orderClient, {
    Key? key,
  }) : super(key: key);

  final OrderClient? orderClient;

  @override
  Widget build(BuildContext context) {
    final orderId = orderClient?.orderId ?? '';
    final price = orderClient?.price ?? 0.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedido Confirmado'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(16),
          child: ListView(
            shrinkWrap: true,
            children: [
              Image.asset(
                "assets/images/shoppingHappy.gif",
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
      ),
    );
  }
}
