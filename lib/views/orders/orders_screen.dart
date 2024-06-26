import 'package:brn_ecommerce/common/cards/login_card.dart';
import 'package:brn_ecommerce/common/drawer/custom_drawer.dart';
import 'package:brn_ecommerce/common/miscellaneous/empty_page_indicator.dart';
import 'package:brn_ecommerce/models/sales/orders_manager.dart';
import 'package:brn_ecommerce/views/orders/components/order_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('Meus pedidos'),
        centerTitle: true,
      ),
      body: Consumer<OrdersManager>(
        builder: (_, ordersManager, __) {
          final sortedOrders = ordersManager.orders.toList()
            ..sort((a, b) => b.formattedId.compareTo(a.formattedId));

          if (ordersManager.users!.id == null) {
            return const LoginCard();
          }
          if (ordersManager.orders.isEmpty) {
            return const EmptyPageIndicator(
              title: 'Nenhuma compra encontrada!\n'
                  'Vamos a compra!',
              image: "assets/images/waitingSales.gif",
              iconData: null,
              duration: null,
            );
          }
          return ListView.builder(
              itemCount: sortedOrders.length,
              itemBuilder: (_, index) {
                return OrderTile(sortedOrders[index]);
              });
        },
      ),
    );
  }
}
