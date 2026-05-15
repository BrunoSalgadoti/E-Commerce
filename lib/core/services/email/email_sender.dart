
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

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


