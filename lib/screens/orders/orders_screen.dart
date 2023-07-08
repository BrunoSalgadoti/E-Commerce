import 'package:brn_ecommerce/common/custom_drawer/custom_drawer.dart';
import 'package:brn_ecommerce/common/empty_indicator.dart';
import 'package:brn_ecommerce/common/login_card.dart';
import 'package:brn_ecommerce/common/orders/order_tile.dart';
import 'package:brn_ecommerce/models/orders_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('Meus Pedidos'),
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
            return const EmptyIndicator(
              title: 'Nenhuma compra encontrada!\n'
                  'Vamos a compra!',
              image: 'assets/images/waitingSales.gif',
              iconData: null,
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
