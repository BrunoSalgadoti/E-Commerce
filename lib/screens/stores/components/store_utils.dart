import 'package:brn_ecommerce/common/button/custom_button.dart';
import 'package:brn_ecommerce/common/show_alert_dialog.dart';
import 'package:brn_ecommerce/models/address.dart';
import 'package:brn_ecommerce/models/stores.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class StoreUtils {
  StoreUtils({
    required this.store,
    required this.address,
  });

  final Stores store;
  final Address address;

  alertForCall(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
          'Este dispositivo não suporta está função!\n'
          'O Número da Loja é : ${store.phoneNumberStore}',
          style: const TextStyle(fontSize: 18)),
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 10),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(15),
    ));
    return;
  }

  alertForEmail(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
          'Este dispositivo não suporta está função!\n'
          'O E-mail da Loja é : ${store.emailStore}',
          style: const TextStyle(fontSize: 18)),
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 10),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(15),
    ));
    return;
  }

  alertForMaps(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text(
          'Não foi encontrado nenhum APP de Mapas '
          'neste dispositívo!\n',
          style: TextStyle(fontSize: 18)),
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 10),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(15),
    ));
    return;
  }

  alertForDeleteStore(
    BuildContext context,
  ) {
    showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return ShowAlertDialog(
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
                      fontSize: 12,
                      buttonColor: Colors.redAccent,
                      onPressed: () {
                        store.deleteStore(store, store.id);
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      }),
                  CustomButton(
                      text: 'NÃO',
                      textColor: Colors.white,
                      fontSize: 14,
                      buttonColor: Colors.greenAccent,
                      onPressed: () => Navigator.of(context).pop())
                ],
              )
            ],
          );
        });
  }

  Future<void> openMap(BuildContext context, double lat, double long) async {
    closeModal() => Navigator.pop(context);
    showModalContext() => context;

    try {
      final availableMap = await MapLauncher.installedMaps;

      showModalBottomSheet(
        context: showModalContext(),
        builder: (_) {
          return SafeArea(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final map in availableMap)
                ListTile(
                  onTap: () {
                    map.showMarker(
                      coords: Coords(lat, long),
                      title: store.nameStore!,
                      description: store.addressText,
                    );
                    closeModal();
                  },
                  title: Text(map.mapName),
                  leading: SvgPicture.asset(
                    map.icon,
                    width: 30,
                    height: 30,
                  ),
                )
            ],
          ));
        },
      );
    } catch (error) {
      alertForMaps(context);
    }
  }

  Future<void> openPhone(BuildContext context, String phoneNumber) async {
    try {
      if (await canLaunchUrl(Uri.parse('tel:$phoneNumber'))) {
        launchUrl(Uri.parse('tel:$phoneNumber'));
      }
    } catch (error) {
      alertForCall(context);
    }
  }

  Future<void> openEmail(BuildContext context, String emailAddress) async {
    try {
      final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: emailAddress,
      );
      if (await canLaunchUrl(emailLaunchUri)) {
        launchUrl(emailLaunchUri);
      }
    } catch (error) {
      alertForEmail(context);
    }
  }
}
