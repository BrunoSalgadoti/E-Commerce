import 'package:brn_ecommerce/common/buttons/custom_text_button.dart';
import 'package:brn_ecommerce/common/formatted_fields/format_timestamp.dart';
import 'package:brn_ecommerce/common/formatted_fields/format_values.dart';
import 'package:brn_ecommerce/common/messengers/custom_alertdialog_adaptive.dart';
import 'package:brn_ecommerce/models/sales/order_client.dart';
import 'package:brn_ecommerce/views/address/components/export_address_dialog.dart';
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

    final verificationNextStatusText = orderClient!.status == StatusOfOrders.transporting ||
        orderClient!.status == StatusOfOrders.delivered ||
        orderClient!.status == StatusOfOrders.keepingReturn;

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
                    formattedOrderId(orderId),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Text(formattedRealText(price),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      )),
                  Text(formattedDateString,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      )),
                ],
              ),
              Text(
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
            ],
          ),
          children: [
            Column(
              children: orderClient!.items!.map((e) {
                return OrderProductTile(e);
              }).toList(),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Qtd. Itens: ',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    '${orderClient!.totalQuantity}',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            const SizedBox(height: 8),
            if (showControls &&
                orderClient!.status != StatusOfOrders.canceled &&
                orderClient!.status != StatusOfOrders.returned)
              SizedBox(
                height: 90,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Modificar Status do Pedido:',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
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
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomTextButton(
                                          text: 'Sim',
                                          icon: null,
                                          fontColor: Colors.red,
                                          onPressed: () {
                                            orderClient?.cancelStatus();
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        CustomTextButton(
                                          text: 'NÃO',
                                          icon: null,
                                          fontSize: 18,
                                          fontColor: Colors.green,
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        )
                                      ],
                                    )
                                  ],
                                ).alertContent(context);
                              },
                            ),
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
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  CustomTextButton(
                                                    text: 'Sim',
                                                    icon: null,
                                                    fontColor: Colors.red,
                                                    onPressed: () {
                                                      orderClient?.advance!();
                                                      Navigator.of(context).pop();
                                                    },
                                                  ),
                                                  CustomTextButton(
                                                    text: 'NÃO',
                                                    icon: null,
                                                    fontSize: 18,
                                                    fontColor: Colors.green,
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
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
                        )
                      ],
                    )
                  ],
                ),
              )
          ]),
    );
  }
}
