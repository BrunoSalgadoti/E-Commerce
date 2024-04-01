import 'package:brn_ecommerce/common/buttons/custom_button.dart';
import 'package:brn_ecommerce/common/messengers/custom_alertdialog_adaptive.dart';
import 'package:brn_ecommerce/models/address_n_cep/address.dart';
import 'package:brn_ecommerce/models/screens/stores.dart';
import 'package:flutter/material.dart';

class StoreUtils {
  StoreUtils({
    required this.store,
    required this.address,
  });

  final Stores store;
  final Address address;

  void alertForDeleteStore(BuildContext context) {
    CustomAlertDialogAdaptive(
      titleText: 'A T E N Ç Ã O',
      bodyText: 'Tem certeza que deseja deletar a loja:\n '
          '${store.nameStore}\n'
          'Localizada: ${address.city}, ${address.street}, ${address.number}'
          'do seu catálogo de lojas?! ',
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomButton(
                text: 'Sim',
                textColor: Colors.white,
                buttonColor: Colors.redAccent,
                widthButton: 100,
                heightButton: 40,
                onPressed: () {
                  store.deleteStore(store, store.id);
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                }),
            CustomButton(
                text: 'NÃO',
                textColor: Colors.black,
                buttonColor: Colors.greenAccent,
                widthButton: 100,
                heightButton: 40,
                onPressed: () => Navigator.of(context).pop()),
          ],
        ),
      ],
    ).alertContent(context);
  }
}
