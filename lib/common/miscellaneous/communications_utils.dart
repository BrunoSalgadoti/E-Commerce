import 'package:brn_ecommerce/common/messengers/components/text_of_alerts_and_messengers.dart';
import 'package:brn_ecommerce/common/messengers/custom_scaffold_messenger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

/// # Utility class for communication-related functionalities (Folder: common/miscellaneous)
/// ## CommunicationsUtils (Folder: common/miscellaneous)
/// A utility class that provides methods for handling communication functionalities such as alerts, map opening, phone calling, and email sending.
///
/// This class is generic, taking two type parameters `T` and `U`.
class CommunicationsUtils<T, U> {
  /// The first type parameter of the utility class.
  final T parameterClass1Of2;

  /// The second type parameter of the utility class.
  final U? parameterClass2Of2;

  /// Indicates if an error has occurred.
  bool? hasError = false;

  /// Creates a [CommunicationsUtils] instance with the specified parameters.
  ///
  /// The [parameterClass1Of2] parameter is required and represents the first type parameter.
  ///
  /// The [parameterClass2Of2] parameter is optional and represents the second type parameter.
  ///
  /// The [hasError] parameter indicates if an error has occurred, defaulting to `false`.
  CommunicationsUtils({
    required this.parameterClass1Of2,
    this.parameterClass2Of2,
    this.hasError,
  });

  /// Displays an alert for a call action.
  ///
  /// The [context] parameter is required and represents the build context.
  ///
  /// The [message] parameter is the message to be displayed in the alert.
  void alertForCall(BuildContext context, String message) {
    if (message.isEmpty) {
      message = 'Este dispositivo não suporta esta função!';
    }

    if (hasError == true) {
      CustomScaffoldMessenger(
        context: context,
        message: message,
        duration: const Duration(seconds: 10),
      ).alertScaffold();
      return;
    }
  }

  /// Displays an alert for an email action.
  ///
  /// The [context] parameter is required and represents the build context.
  ///
  /// The [message] parameter is the message to be displayed in the alert.
  void alertForEmail(BuildContext context, String message) {
    if (message.isEmpty) {
      message = 'Este dispositivo não suporta esta função!';
    }

    if (hasError == true) {
      CustomScaffoldMessenger(
        context: context,
        message: message,
        duration: const Duration(seconds: 10),
      ).alertScaffold();
      return;
    }
  }

  /// Sends an email with the specified user email, user name, and recipient emails.
  ///
  /// The [userEmail] parameter is the user's email address.
  ///
  /// The [userName] parameter is the user's name, if available.
  ///
  /// The [emails] parameter is a list of recipient email addresses.
  ///
  /// This method constructs an email launch URI with the specified subject and body,
  /// then launches the email application to send the email.
  Future<void> sendEmail(String? userEmail, String? userName, List<String>? emails) {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((MapEntry<String, String> e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join("&");
    }

    final Uri emailLaunchUri = Uri(
        scheme: "mailto",
        path: userEmail ?? emails.toString().replaceAll(RegExp(r"[\[\]]"), ""),
        query: encodeQueryParameters(<String, String>{
          "subject": AlertsMessengersText.subjectOfTheEmail,
          "body": userName == null
              ? AlertsMessengersText.bodyMessangersEmailWithowtUserName
              : "$userName,\n ${AlertsMessengersText.bodyMessangersEmailWithUserName}",
        }));
    return launchUrl(emailLaunchUri);
  }

  /// Displays an alert message for map-related actions.
  ///
  /// The [context] parameter is required and represents the build context.
  ///
  /// The [message] parameter is the message to be displayed in the alert.
  ///
  /// If [message] is empty, a default message indicating no map application is found
  /// on the device will be displayed.
  ///
  /// If [hasError] is `true`, a custom scaffold messenger alert with the specified
  /// message and duration will be displayed.
  void alertForMaps(BuildContext context, String message) {
    if (message.isEmpty) {
      message = 'Não foi encontrado nenhum APP de Mapas\n neste dispositivo!\n';
    }

    if (hasError == true) {
      CustomScaffoldMessenger(
        context: context,
        message: message,
        duration: const Duration(seconds: 10),
      ).alertScaffold();
      return;
    }
  }

  /// Opens a map with the specified coordinates, title, and description.
  ///
  /// The [context] parameter is required and represents the build context.
  ///
  /// The [lat] parameter is the latitude coordinate.
  ///
  /// The [long] parameter is the longitude coordinate.
  ///
  /// The [title] parameter is the title of the map marker.
  ///
  /// The [description] parameter is the description of the map marker.
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
            ),
          );
        },
      );
    } catch (error) {
      hasError = true;
      // ignore: use_build_context_synchronously
      alertForMaps(context, '');
    }
  }

  /// Opens a phone call with the specified phone number.
  ///
  /// The [context] parameter is required and represents the build context.
  ///
  /// The [phoneNumber] parameter is the phone number to be called.
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

  /// Opens an email composition with the specified email address.
  ///
  /// The [context] parameter is required and represents the build context.
  ///
  /// The [emailAddress] parameter is the email address for composing the email.
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
