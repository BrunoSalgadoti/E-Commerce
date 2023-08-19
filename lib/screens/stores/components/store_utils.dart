import 'package:brn_ecommerce/common/button/custom_button.dart';
import 'package:brn_ecommerce/common/custom_messengers/custom_alert_dialog.dart';
import 'package:brn_ecommerce/common/custom_messengers/custom_scaffold_messenger.dart';
import 'package:brn_ecommerce/common/formated_fields/format_values.dart';
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

  void alertForCall(BuildContext context) {
    CustomScaffoldMessenger(
      context: context,
      message: 'Este dispositivo não suporta está função!\n'
          'O Número da Loja é : ${formattedPhoneNumber(store.phoneNumberStore)}',
      duration: const Duration(seconds: 10),
    ).msn();
    return;
  }

  void alertForEmail(BuildContext context) {
    CustomScaffoldMessenger(
      context: context,
      message: 'Este dispositivo não suporta está função!\n'
          'O E-mail da Loja é : ${store.emailStore}',
      duration: const Duration(seconds: 10),
    ).msn();
    return;
  }

  void alertForMaps(BuildContext context) {
    CustomScaffoldMessenger(
      context: context,
      message: 'Não foi encontrado nenhum APP de Mapas '
          'neste dispositívo!\n',
      duration: const Duration(seconds: 10),
    ).msn();
    return;
  }

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
      // ignore: use_build_context_synchronously
      alertForMaps(context);
    }
  }

  Future<void> openPhone(BuildContext context, String phoneNumber) async {
    try {
      if (await canLaunchUrl(Uri.parse('tel:$phoneNumber'))) {
        launchUrl(Uri.parse('tel:$phoneNumber'));
      }
    } catch (error) {
      // ignore: use_build_context_synchronously
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
      // ignore: use_build_context_synchronously
      alertForEmail(context);
    }
  }
}
