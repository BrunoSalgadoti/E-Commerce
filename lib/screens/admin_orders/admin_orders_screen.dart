import 'package:brn_ecommerce/common/button/custom_icon_button.dart';
import 'package:brn_ecommerce/common/custom_drawer/custom_drawer.dart';
import 'package:brn_ecommerce/common/empty_indicator.dart';
import 'package:brn_ecommerce/common/orders/order_tile.dart';
import 'package:brn_ecommerce/models/admin_orders_manager.dart';
import 'package:brn_ecommerce/models/order_client.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class AdminOrdersScreen extends StatefulWidget {
  const AdminOrdersScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AdminOrdersScreen> createState() => _AdminOrdersScreenState();
}

class _AdminOrdersScreenState extends State<AdminOrdersScreen> {
  final PanelController _panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('Pedido(s) Realizado(s)'),
        centerTitle: true,
      ),
      body: Consumer<AdminOrdersManager>(
        builder: (_, adminOrdersManager, __) {
          final filteredOrders = adminOrdersManager.filteredOrders;

          return SlidingUpPanel(
            controller: _panelController,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            minHeight: 35,
            maxHeight: 360,
            body: Column(
              children: [
                if (adminOrdersManager.userFilter != null)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 2),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Pedidos de: '
                            '${adminOrdersManager.userFilter!.userName ?? ''}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        CustomIconButton(
                          iconData: Icons.close,
                          color: Colors.white,
                          onTap: () {
                            adminOrdersManager.setUserFilter(null);
                          },
                        )
                      ],
                    ),
                  ),
                if (filteredOrders.isEmpty)
                  const Expanded(
                      child: EmptyIndicator(
                    title: 'Aguardando vendas...',
                    iconData: Icons.border_clear,
                    image: null,
                  ))
                else
                  Expanded(
                    child: ListView.builder(
                        itemCount: filteredOrders.length,
                        itemBuilder: (_, index) {
                          return OrderTile(
                            filteredOrders[index],
                            showControls: true,
                          );
                        }),
                  ),
                const SizedBox(height: 125)
              ],
            ),
            panel: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: () {
                    if (_panelController.isPanelClosed) {
                      _panelController.open();
                    } else {
                      _panelController.close();
                    }
                  },
                  child: Container(
                    height: 40,
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: Text(
                      'F I L T R O S',
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: Status.values.map((s) {
                    return CheckboxListTile(
                        title: Text(OrderClient.getStatusText(s)),
                        dense: true,
                        activeColor: primaryColor,
                        value: adminOrdersManager.statusFilter.contains(s),
                        onChanged: (v) {
                          adminOrdersManager.setStatusFilter(
                              status: s, enabled: v);
                        });
                  }).toList(),
                )),
              ],
            ),
          );
        },
      ),
    );
  }
}
