import 'package:brn_ecommerce/common/drawer/components/page_manager.dart';
import 'package:brn_ecommerce/common/formatted_fields/format_values.dart';
import 'package:brn_ecommerce/common/miscellaneous/tag_for_cards.dart';
import 'package:brn_ecommerce/helpers/routes_navigator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:decorated_text/decorated_text.dart' show DecoratedGoogleFontText;
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:provider/provider.dart';

import '../../models/products/product.dart' show Product;

/// # Utility functions and methods (Folder: common/functions)
/// ## getColorFromString
/// Converts a hexadecimal color string to a Color object.
///
/// Takes a [color] string in the format "#RRGGBB" and returns the corresponding Color object.
/// If the input string is not in the correct format, returns Colors.transparent.
Color getColorFromString(String color) {
  if (color.length != 7 || color[0] != "#") {
    // Check if the color string is not the expected length (7 characters)
    // or if it doesn't start with '#'. In this case, return a default color or null.
    return Colors.transparent;
  }

  try {
    final int value = int.parse(color.substring(1, 7), radix: 16);
    return Color(value).withOpacity(1.0);
  } catch (error) {
    // If an exception occurs when trying to parse the color, return a default color or null.
    return Colors.transparent;
  }
}

/// ## getHexColor
/// Converts a Color object to a hexadecimal color string.
///
/// Takes a [color] object and returns the corresponding hexadecimal color string.
String getHexColor(Color color) {
  String hexColor = '#${color.value.toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}';
  return hexColor;
}

/// ## sendEmailNotification
/// Sends an email notification using Firebase functions.
///
/// Takes required parameters: [recipientEmail], [subject], and [messageText].

//TODO: Configure sending parameters after activating firebase functions EMAIL
Future<void> sendEmailNotification({
  required String recipientEmail, // Recipient email as parameter
  required String subject, // Subject as parameter
  required String messageText, // Message as a parameter
}) async {
  final smtpServer =
      gmail('suporte@brninfodev.com', 'sua-senha'); // Replace with Firebase SMTP credentials

  final message = Message()
    ..from = const Address('seu-email@gmail.com', 'Seu Nome') // Your email address and name
    ..recipients.add(recipientEmail)
    ..subject = subject
    ..text = messageText;

  try {
    final sendReport = await send(message, smtpServer);
    debugPrint('Mensagem enviada: ${sendReport.toString()}');
  } catch (error) {
    debugPrint('Erro ao enviar e-mail: $error');
  }
}

/// ## reportNoFatalErrorToCrashlytics
/// Reports non-fatal errors to Firebase Crashlytics for monitoring.
///
/// Takes required parameters: [error], [stackTrace], and [information].
Future<void> reportNoFatalErrorToCrashlytics(
    {required String error,
    String? reason,
    required StackTrace stackTrace,
    required String information}) async {
  await FirebaseCrashlytics.instance.recordError(
    error,
    stackTrace,
    reason: reason ?? 'Monitoramento Try-Catch',
    information: [information, 'version 1.0'],
  );
}

/// Creates a custom progress indicator widget that can be used for various loading scenarios.
///
/// The [color] parameter sets the color of the progress indicator. If not provided, it defaults to
/// `Colors.blue`.
///
/// The [strokeWidth] parameter specifies the width of the circular indicator's stroke. If not
/// provided, it defaults to `6.0`.
///
/// The [stopAnimationColor] parameter sets the color of the circular indicator's animation when
/// stopped. If not provided, it defaults to `Colors.blue`.
///
/// The [linearBackgroundColor] parameter sets the background color of the linear progress indicator.
/// If not provided, it defaults to `Colors.transparent`.
///
/// The [isCircular] parameter determines whether to use a circular or linear progress indicator.
/// If set to `true`, a circular progress indicator is used; otherwise, a linear progress
/// indicator is used.
///
/// Returns a [Widget] representing the custom progress indicator based on the provided parameters.

//TODO: customProgressIndicator - Implementar testar e Substituir outros indicators
Widget customProgressIndicator(
    {Color? color,
    double? strokeWidth,
    Color? stopAnimationColor,
    Color? linearBackgroundColor,
    required bool isCircular,
    required bool isLoading}) {
  if (isCircular == true && isLoading == true) {
    return Center(
      child: CircularProgressIndicator(
        color: color ?? Colors.blue,
        strokeWidth: strokeWidth ?? 6,
        valueColor: AlwaysStoppedAnimation(stopAnimationColor ?? Colors.blue),
      ),
    );
  } else if (isCircular == false && isLoading == true) {
    return LinearProgressIndicator(
      valueColor: AlwaysStoppedAnimation(color ?? Colors.blue),
      backgroundColor: linearBackgroundColor ?? Colors.transparent,
    );
  } else {
    return const SizedBox.shrink();
  }
}

void navigateToPageWithDrawer({required BuildContext context, required int pageIndex}) {
  Navigator.popAndPushNamed(context, RoutesNavigator.homeScreen);
  WidgetsBinding.instance.addPostFrameCallback((_) {
    context.read<PageManager>().setPage(pageIndex);
  });
}

Widget carouselForProducts(
    {required BuildContext context, required List<Product> productsForCarousel}) {
  final CarouselSliderControllerImpl carouselController = CarouselSliderControllerImpl();

  return CarouselSlider(
      carouselController: carouselController,
      options: CarouselOptions(
        aspectRatio: 1 / 1,
        initialPage: 0,
        height: 280,
        viewportFraction: 0.5,
        disableCenter: true,
        enlargeCenterPage: true,
        enlargeFactor: 0.27,
        enableInfiniteScroll: true,
        scrollDirection: Axis.horizontal,
        autoPlay: true,
      ),
      items: productsForCarousel.map<Widget>((product) {
        return Stack(
          fit: StackFit.expand,
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1.5,
                    blurRadius: 4,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.network(
                product.images!.first,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TagForCard(
                data: 'A partir:\n '
                    '${formattedRealText(product.basePrice)}',
                googleFonts: GoogleFonts.akayaTelivigala,
                textFontSize: 16,
                alignment: Alignment.bottomLeft,
                backgroundColor: Colors.white,
                containerWidth: 90,
              ),
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: Material(
                color: Theme.of(context).primaryColor.withAlpha(90),
                child: IconButton(
                  icon: const Icon(
                    Icons.open_in_new,
                    semanticLabel: 'Visualizar Produto',
                    size: 20,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, RoutesNavigator.productDetailsScreen,
                        arguments: product);
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: Container(),
            ),
          ],
        );
      }).toList());
}

Widget textForGoogleDecorations(
    {required String titleForDecorations,
    double? fontSize,
    double? borderWidth,
    dynamic fontMethod,
    dynamic fontWeight,
    Color? fillColor,
    Color? borderColor}) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(8, 1, 8, 0),
    child: DecoratedGoogleFontText(
      titleForDecorations,
      fontMethod: fontMethod ?? GoogleFonts.bungeeSpice,
      fillColor: fillColor ?? Colors.transparent,
      borderColor: borderColor ?? Colors.transparent,
      fontSize: fontSize ?? 22,
      fontWeight: fontWeight ?? FontWeight.w800,
      borderWidth: borderWidth ?? 0.8,
    ),
  );
}
