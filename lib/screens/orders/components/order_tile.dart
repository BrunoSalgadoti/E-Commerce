import 'package:ecommerce/models/order_client.dart';
import 'package:ecommerce/screens/orders/components/order_product_tile.dart';
import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {
  const OrderTile( this.orderClient, {Key? key,}) : super(key: key);

  final OrderClient? orderClient;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  orderClient!.formattedId,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  'R\$ ${orderClient!.price!.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 14,
                )
                ),
              ],
            ),
            Text(
              'Em construção',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: primaryColor,
                fontSize: 14,
            ),
            ),
          ],
        ),
        children: [
          Column(
            children: orderClient!.items!.map((e) {
              return OrderProductTile(e);
            }).toList(),
          )
        ],
      ),
    );
  }
}
