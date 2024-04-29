import 'package:brn_ecommerce/common/buttons/custom_text_button.dart';
import 'package:brn_ecommerce/common/formatted_fields/format_timestamp.dart';
import 'package:brn_ecommerce/common/formatted_fields/format_values.dart';
import 'package:brn_ecommerce/common/messengers/custom_alertdialog_adaptive.dart';
import 'package:brn_ecommerce/helpers/breakpoints.dart';
import 'package:brn_ecommerce/models/admin_area/components/export_address_dialog.dart';
import 'package:brn_ecommerce/models/sales/order_client.dart';
import 'package:brn_ecommerce/views/orders/components/order_product_tile.dart';
import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {
  const OrderTile(this.orderClient, {super.key, this.showControls = false});

  final OrderClient? orderClient;
  final bool showControls;

  String get formattedDateString => formatTimestamp(orderClient!.date!);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final orderId = orderClient?.orderId;
    final price = orderClient?.price ?? 0.0;
    final clientName = orderClient?.userName ?? '';

    final verificationNextStatusText = orderClient!.status == StatusOfOrders.transporting ||
        orderClient!.status == StatusOfOrders.delivered ||
        orderClient!.status == StatusOfOrders.keepingReturn;

    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: tabletBreakpoint),
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: ExpansionTile(
              collapsedTextColor: Colors.indigoAccent,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(formattedOrderId(orderId),
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            )),
                        Text(clientName,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            )),
                        Text(formattedRealText(price),
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: primaryColor,
                            )),
                        Text(formattedDateString,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: primaryColor,
                            )),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Text(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      orderClient!.statusText,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: orderClient!.status == StatusOfOrders.canceled ||
                                orderClient!.status == StatusOfOrders.returned
                            ? Colors.red
                            : primaryColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              children: [
                Column(
                    children: orderClient!.items!.map((e) {
                  return OrderProductTile(e);
                }).toList()),
                Padding(
                  padding: const EdgeInsets.only(right: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Flexible(
                          child: Text(
                        'Qtd. Itens: ',
                        style: TextStyle(fontSize: 15),
                        overflow: TextOverflow.fade,
                      )),
                      Flexible(
                          child: Text(
                        '${orderClient!.totalQuantity}',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ))
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                if (showControls &&
                    orderClient!.status != StatusOfOrders.canceled &&
                    orderClient!.status != StatusOfOrders.returned)
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Modificar Status do Pedido:',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CustomTextButton(
                                  text: 'Cancelar',
                                  icon: null,
                                  fontColor: Colors.red,
                                  onPressed: () {
                                    orderClient?.status = StatusOfOrders.canceled;

                                    CustomAlertDialogAdaptive(
                                      titleText: 'A T E N Ç Ã O!',
                                      bodyText: orderClient!.bodyText,
                                      titleWeight: FontWeight.normal,
                                      actions: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: CustomTextButton(
                                                text: 'Sim',
                                                icon: null,
                                                fontColor: Colors.red,
                                                onPressed: () {
                                                  orderClient?.cancelStatus();
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ),
                                            Flexible(
                                              child: CustomTextButton(
                                                text: 'NÃO',
                                                icon: null,
                                                fontSize: 14,
                                                fontColor: Colors.green,
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ).alertContent(context);
                                  }),
                              Column(
                                children: [
                                  Text(orderClient!.previousStatusText),
                                  CustomTextButton(
                                    text: null,
                                    icon: const Icon(Icons.arrow_back),
                                    onPressed: orderClient?.back,
                                  ),
                                ],
                              ),
                              const SizedBox(width: 8),
                              Column(
                                children: [
                                  Text(orderClient!.nextStatusText),
                                  CustomTextButton(
                                    text: null,
                                    icon: const Icon(Icons.arrow_forward),
                                    onPressed: verificationNextStatusText
                                        ? () => CustomAlertDialogAdaptive(
                                              titleText: 'A T E N Ç Ã O!',
                                              bodyText: orderClient!.bodyText,
                                              actions: [
                                                Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Flexible(
                                                      child: CustomTextButton(
                                                        text: 'Sim',
                                                        icon: null,
                                                        fontColor: Colors.red,
                                                        onPressed: () {
                                                          orderClient?.advance!();
                                                          Navigator.of(context).pop();
                                                        },
                                                      ),
                                                    ),
                                                    Flexible(
                                                      child: CustomTextButton(
                                                        text: 'NÃO',
                                                        icon: null,
                                                        fontSize: 14,
                                                        fontColor: Colors.green,
                                                        onPressed: () {
                                                          Navigator.of(context).pop();
                                                        },
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ).alertContent(context)
                                        : orderClient?.advance,
                                  ),
                                ],
                              ),
                              CustomTextButton(
                                text: 'Endereço',
                                icon: null,
                                fontColor: Theme.of(context).primaryColor,
                                onPressed: () => ExportAddressDialog(
                                  address: orderClient?.address,
                                  orderClient: orderClient,
                                ).alertForShowAddress(context),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
