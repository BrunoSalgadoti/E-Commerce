import 'package:ecommerce/common/custom_drawer/custom_drawer.dart';
import 'package:ecommerce/common/empty_indicator.dart';
import 'package:ecommerce/models/admin_orders_manager.dart';
import 'package:ecommerce/common/order_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminOrdersScreen extends StatelessWidget {
  const AdminOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('Pedidos Realizados'),
        centerTitle: true,
      ),
      body: Consumer<AdminOrdersManager>(
        builder: (_, adminOrdersManager, __) {
          if (adminOrdersManager.orders.isEmpty) {
            return const Center(
              child: EmptyIndicator(
                title: 'Aguardando vendas...',
                iconData: Icons.border_clear,
                image: null,
              ),
            );
          }
          return ListView.builder(
              itemCount: adminOrdersManager.orders.length,
              itemBuilder: (_, index) {
                return OrderTile(
                    adminOrdersManager.orders.reversed.toList()[index]);
              });
        },
      ),
    );
  }
}
