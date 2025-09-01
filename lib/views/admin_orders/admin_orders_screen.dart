import 'package:brn_ecommerce/common/app_bar/custom_app_bar.dart';
import 'package:brn_ecommerce/common/buttons/custom_icon_button.dart';
import 'package:brn_ecommerce/common/drawer/components/drawer_pages_enum.dart';
import 'package:brn_ecommerce/common/drawer/components/page_manager.dart';
import 'package:brn_ecommerce/common/drawer/custom_drawer.dart';
import 'package:brn_ecommerce/common/miscellaneous/empty_page_indicator.dart';
import 'package:brn_ecommerce/common/sliding_up_panel/custom_sliding_up_painel.dart';
import 'package:brn_ecommerce/helpers/breakpoints.dart';
import 'package:brn_ecommerce/helpers/themes/get_another_colors.dart';
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
            drawer: const CustomDrawer(),
            appBar: CustomAppBar(
              title: 'Pedido(s) Realizado(s)',
              showDrawerIcon: true,
              showSearchButton: false,
            ),
            body: Center(
              child: Container(
                constraints: BoxConstraints(maxWidth: mobileBreakpoint),
                child: Consumer<AdminOrdersManager>(
                  builder: (_, adminOrdersManager, __) {
                    final filteredOrders = adminOrdersManager.filteredOrders.toList()
                      ..sort((a, b) => b.formattedId.compareTo(a.formattedId));

                    return customSlidingUpPainel(
                      context: context,
                      slidingTitleColor: primaryColor,
                      textOfSlidingUpPanel: 'Filtrar por status de entrega',
                      borderRadiosBottomLeft: 0,
                      borderRadiosBottomRight: 0,
                      borderRadiosTopLeft: 10,
                      borderRadiosTopRight: 10,
                      body: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: mobileBreakpoint),
                        child: ListView(
                          padding: EdgeInsets.zero,
                          children: [
                            if (adminOrdersManager.userFilter != null)
                              Padding(
                                padding: const EdgeInsets.fromLTRB(16, 0, 16, 2),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        'Pedidos de: '
                                        '${adminOrdersManager.userFilter!.userName ?? ''}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          color: getEspecialColor(),
                                        ),
                                      ),
                                    ),
                                    CustomIconButton(
                                      iconData: Icons.close,
                                      color: getEspecialColor(),
                                      onTap: () {
                                        adminOrdersManager.setUserFilter(null);
                                        context.read<PageManager>().setPage(DrawerPages.adminUsers);
                                      },
                                      semanticLabel: 'Fechar',
                                    )
                                  ],
                                ),
                              ),
                            if (filteredOrders.isEmpty)
                              const EmptyPageIndicator(
                                title: 'Aguardando vendas...',
                                iconData: Icons.border_clear,
                                image: null,
                                duration: null,
                              )
                            else
                              ...filteredOrders.map(
                                (order) => Center(
                                  child: Container(
                                    constraints: BoxConstraints(maxWidth: mobileBreakpoint),
                                    child: OrderTile(order, showControls: true),
                                  ),
                                ),
                              ),
                            const SizedBox(height: 80), // final margin
                          ],
                        ),
                      ),
                      childrenOfPainel: Center(
                        child: Container(
                          constraints: BoxConstraints(maxWidth: mobileBreakpoint),
                          child: ListView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: StatusOfOrders.values.map((s) {
                              return CheckboxListTile(
                                title: Text(OrderClient.getStatusText(s)),
                                dense: true,
                                activeColor: primaryColor,
                                value: adminOrdersManager.statusFilter.contains(s),
                                onChanged: (v) {
                                  adminOrdersManager.setStatusFilter(status: s, enabled: v);
                                },
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
