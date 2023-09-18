import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

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

String getHexColor(Color color) {
  String hexColor =
      '#${color.value.toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}';
  return hexColor;
}

Color getTextColorBasedOnBackground(Color backgroundColor) {
  // Calculates the luminosity of the background color.
  final luminance = backgroundColor.computeLuminance();

  // Sets the text color based on luminosity.
  final textColor = luminance > 0.2 ? Colors.black : Colors.white;

  return textColor;
}

//TODO: Configure sending parameters after activating firebase functions
Future<void> sendEmailNotification({
  required String recipientEmail, // Recipient email as parameter
  required String subject, // Subject as parameter
  required String messageText, // Message as a parameter
}) async {
  final smtpServer = gmail('suporte@brninfodev.com',
      'sua-senha'); // Replace with Firebase SMTP credentials

  final message = Message()
    ..from = const Address(
        'seu-email@gmail.com', 'Seu Nome') // Your email address and name
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

