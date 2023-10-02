import 'package:brn_ecommerce/common/button/custom_button.dart';
import 'package:brn_ecommerce/common/custom_messengers/custom_alert_dialog.dart';
import 'package:brn_ecommerce/models/address.dart';
import 'package:brn_ecommerce/models/stores.dart';
import 'package:flutter/material.dart';

class StoreUtils {
  StoreUtils({
    required this.store,
    required this.address,
  });

  final Stores store;
  final Address address;

  void alertForDeleteStore(BuildContext context) {
    showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return CustomAlertDialog(
            titleText: 'A T E N Ç Ã O',
            bodyText: 'Tem certeza que deseja deletar a loja:\n '
                '${store.nameStore}\n'
                'do seu catálogo de lojas?! ',
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomButton(
                      text: 'sim',
                      textColor: Colors.white,
                      buttonColor: Colors.redAccent,
                      onPressed: () {
                        store.deleteStore(store, store.id);
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      }),
                  CustomButton(
                      text: 'NÃO',
                      textColor: Colors.white,
                      buttonColor: Colors.greenAccent,
                      onPressed: () => Navigator.of(context).pop())
                ],
              )
            ],
          );
        });
  }
}
