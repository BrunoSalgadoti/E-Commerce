import 'package:brn_ecommerce/common/orders/components/order_product_tile.dart';
import 'package:brn_ecommerce/models/order_client.dart';
import 'package:flutter/material.dart';

class SalesConfirmationScreen extends StatelessWidget {
  const SalesConfirmationScreen(
    this.orderClient, {
    Key? key,
  }) : super(key: key);

  final OrderClient? orderClient;

  @override
  Widget build(BuildContext context) {
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
                'assets/images/shoppingHappy.gif',
                width: 80,
                height:80,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      orderClient!.formattedId,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).primaryColor),
                    ),
                    Text(
                      'R\$ ${orderClient?.price!.toStringAsFixed(2)}',
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
