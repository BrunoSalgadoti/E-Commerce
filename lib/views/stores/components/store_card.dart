import 'package:brn_ecommerce/common/buttons/custom_icon_button.dart';
import 'package:brn_ecommerce/common/formatted_fields/format_values.dart';
import 'package:brn_ecommerce/common/miscellaneous/communications_utils.dart';
import 'package:brn_ecommerce/models/users/users_manager.dart';
import 'package:brn_ecommerce/models/views/stores.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StoreCard extends StatelessWidget {
  const StoreCard(this.store, {super.key});

  final Stores store;

  @override
  Widget build(BuildContext context) {
    //Keeping context out of async methods
    final primaryColor = Theme.of(context).primaryColor;
    final storeImage = store.imageStore != null && store.imageStore != ""
        ? Image.network(store.imageStore, fit: BoxFit.cover)
        : Image.asset('assets/images/noImage.png', fit: BoxFit.cover);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      clipBehavior: Clip.antiAlias,
      elevation: 7,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 2),
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(width: double.infinity, height: 230, child: storeImage),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(9))),
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      store.statusText,
                      style: TextStyle(
                        color: store.colorsForOpenStore,
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Consumer<UserManager>(
                    builder: (_, userManager, __) {
                      if (userManager.adminEnable) {
                        return IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.blue,
                            size: 40,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, "/edit_stores", arguments: store);
                          },
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ],
            ),
            Container(
              height: 180,
              padding: const EdgeInsets.only(top: 9, right: 13, left: 13, bottom: 12),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          store.nameStore ?? '',
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          store.addressText ?? '',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                        ),
                        Text(
                          store.openingText,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomIconButton(
                            iconData: Icons.map_outlined,
                            color: primaryColor,
                            onTap: () {
                              CommunicationsUtils(
                                      parameterClass1Of2: store, parameterClass2Of2: store.address!)
                                  .openMap(
                                context,
                                store.address!.lat!,
                                store.address!.long!,
                                store.nameStore ?? '',
                                store.addressText ?? '',
                              );
                              CommunicationsUtils(parameterClass1Of2: store)
                                  .alertForMaps(context, '');
                            },
                          semanticLabel: 'Abrir mapas'),
                        CustomIconButton(
                            iconData: Icons.phone,
                            color: primaryColor,
                            onTap: () {
                              CommunicationsUtils(parameterClass1Of2: store)
                                  .openPhone(context, unFormatPhone(store.phoneNumberStore ?? ''));
                              CommunicationsUtils(parameterClass1Of2: store).alertForCall(
                                context,
                                'Este dispositivo não suporta esta função!\n'
                                'O Número da Loja é : '
                                '${formattedPhoneNumber(store.phoneNumberStore)}',
                              );
                            },
                          semanticLabel: 'Abrir telefone'),
                        CustomIconButton(
                            iconData: Icons.email_outlined,
                            color: primaryColor,
                            onTap: () {
                              CommunicationsUtils(parameterClass1Of2: store)
                                  .openEmail(context, store.emailStore ?? '');
                              CommunicationsUtils(parameterClass1Of2: store).alertForEmail(
                                context,
                                'Este dispositivo não suporta esta função!\n'
                                'O E-mail da Loja é : ${store.emailStore}',
                              );
                            }, semanticLabel: 'Abrir e-mail'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
