import 'package:brn_ecommerce/common/buttons/custom_icon_button.dart';
import 'package:brn_ecommerce/common/drawer/custom_drawer.dart';
import 'package:brn_ecommerce/common/miscellaneous/empty_page_indicator.dart';
import 'package:brn_ecommerce/common/sliding_up_panel/custom_sliding_up_painel.dart';
import 'package:brn_ecommerce/helpers/breakpoints.dart';
import 'package:brn_ecommerce/models/admin_area/admin_orders_manager.dart';
import 'package:brn_ecommerce/models/sales/order_client.dart';
import 'package:brn_ecommerce/views/orders/components/order_tile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminOrdersScreen extends StatelessWidget {
  const AdminOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Center(
      child: Padding(
        padding: kIsWeb ? const EdgeInsets.only(top: 0) : MediaQuery.of(context).padding,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: wildBreakpoint),
          child: Scaffold(
            backgroundColor: Colors.black45,
            drawer: const CustomDrawer(),
            appBar: AppBar(
              title: const Text('Pedido(s) Realizado(s)'),
              centerTitle: true,
            ),
            body: Center(
              child: Consumer<AdminOrdersManager>(
                builder: (_, adminOrdersManager, __) {
                  final filteredOrders = adminOrdersManager.filteredOrders.toList()
                    ..sort((a, b) => b.formattedId.compareTo(a.formattedId));

                  return ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: tabletBreakpoint),
                    child: customSlidingUpPainel(
                        context: context,
                        slidingTitleColor: primaryColor,
                        textOfSlidingUpPanel: 'Filtrar por status de entrega',
                        borderRadiosBottomLeft: 0,
                        borderRadiosBottomRight: 0,
                        borderRadiosTopLeft: 10,
                        borderRadiosTopRight: 10,
                        body: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: tabletBreakpoint),
                          child: Column(
                            children: [
                              if (adminOrdersManager.userFilter != null)
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 2),
                                  child: Row(
                                    children: [
                                      Flexible(
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
                                        semanticLabel: 'Fechar',
                                      )
                                    ],
                                  ),
                                ),
                              if (filteredOrders.isEmpty)
                                const Flexible(
                                    child: EmptyPageIndicator(
                                  title: 'Aguardando vendas...',
                                  iconData: Icons.border_clear,
                                  image: null,
                                  duration: null,
                                ))
                              else
                                Flexible(
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
                        ),
                        childrenOfPainel: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: StatusOfOrders.values.map((s) {
                            return CheckboxListTile(
                                title: Text(OrderClient.getStatusText(s)),
                                dense: true,
                                activeColor: primaryColor,
                                value: adminOrdersManager.statusFilter.contains(s),
                                onChanged: (v) {
                                  adminOrdersManager.setStatusFilter(status: s, enabled: v);
                                });
                          }).toList(),
                        )),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
