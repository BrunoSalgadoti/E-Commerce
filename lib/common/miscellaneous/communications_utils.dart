import 'package:brn_ecommerce/common/custom_messengers/custom_scaffold_messenger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class CommunicationsUtils<T, U> {
  CommunicationsUtils({
    required this.parameterClass1Of2,
    this.parameterClass2Of2,
    this.hasError,
  });

  final T parameterClass1Of2;
  final U? parameterClass2Of2;
  bool? hasError = false;

  void alertForCall(BuildContext context, String message) {
    if (message.isEmpty) {
      message = 'Este dispositivo não suporta esta função!';
    }

    if (hasError == true) {
      CustomScaffoldMessenger(
        context: context,
        message: message,
        duration: const Duration(seconds: 10),
      ).msn();
      return;
    }
  }

  void alertForEmail(BuildContext context, String message) {
    if (message.isEmpty) {
      message = 'Este dispositivo não suporta esta função!';
    }

    if (hasError == true) {
      CustomScaffoldMessenger(
        context: context,
        message: message,
        duration: const Duration(seconds: 10),
      ).msn();
      return;
    }
  }

  void alertForMaps(BuildContext context, String message) {
    if (message.isEmpty) {
      message = 'Não foi encontrado nenhum APP de Mapas\n neste dispositivo!\n';
    }

    if (hasError == true) {
      CustomScaffoldMessenger(
        context: context,
        message: message,
        duration: const Duration(seconds: 10),
      ).msn();
      return;
    }
  }

  Future<void> openMap(
      BuildContext context, double lat, double long, String title, String description) async {
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
                      title: title,
                      description: description,
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
      hasError = true;
      // ignore: use_build_context_synchronously
      alertForMaps(context, '');
    }
  }

  Future<void> openPhone(BuildContext context, String phoneNumber) async {
    if (phoneNumber.isEmpty) {
      hasError = true;
      alertForCall(context, 'Número telefônico indisponível!');
    } else {
      try {
        if (await canLaunchUrl(Uri.parse('tel:$phoneNumber'))) {
          launchUrl(Uri.parse('tel:$phoneNumber'));
        }
      } catch (error) {
        hasError = true;
        // ignore: use_build_context_synchronously
        alertForCall(context, '');
      }
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
      hasError = true;
      // ignore: use_build_context_synchronously
      alertForEmail(context, '');
    }
  }
}
