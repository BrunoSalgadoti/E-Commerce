import 'package:brn_ecommerce/helpers/extensions.dart';
import 'package:brn_ecommerce/models/stores/stores.dart';

import '../common/functions/common_functions.dart';

//TODO: Configure sending parameters after activating firebase functions EMAIL HANDLE ERROS
/// # Handle Erros (Folder: helpers).
/// A class to handle errors and send email notifications when error limits are reached.
///
/// The [HandleErrors] class provides functionality to track errors, count occurrences, and send email notifications
/// when error thresholds are exceeded within a specified time duration.
class HandleErrors {
  /// Stores associated with the errors.
  Stores? stores;

  /// The email address to which error notifications will be sent.
  final String? recipientEmail;

  /// The subject of the error notification email.
  final String? emailSubject;

  /// The default message for error notifications.
  String emailMessage;

  /// The count of errors that have occurred.
  int errorCount = 0;

  /// The timestamp of the last error occurrence.
  DateTime? lastErrorTime;

  /// Creates a [HandleErrors] instance with optional parameters.
  ///
  /// The [recipientEmail] parameter specifies the email address to which error notifications will be sent.
  ///
  /// The [emailSubject] parameter specifies the subject of the error notification email.
  ///
  /// The [emailMessage] parameter sets the default message for error notifications.
  ///
  /// The [stores] parameter represents the stores associated with the errors, defaulting to a new instance of [Stores].
  HandleErrors({
    this.recipientEmail,
    this.emailSubject,
    this.emailMessage = '',
    this.stores,
  }) {
    stores = stores ?? Stores();
  }

  /// Creates a [HandleErrors] instance with an initial email message.
  ///
  /// The [recipientEmail] parameter specifies the email address to which error notifications will be sent.
  ///
  /// The [emailSubject] parameter specifies the subject of the error notification email.
  ///
  /// The [emailMessage] parameter sets the initial message for error notifications.
  HandleErrors.withEmailMessage({
    required this.recipientEmail,
    required this.emailSubject,
    this.emailMessage = '',
  });

  /// Handles errors and sends email notifications when error limits are reached.
  ///
  /// The [error] parameter represents the error object or message.
  ///
  /// The [errorLimit] parameter specifies the maximum number of errors allowed within the specified time duration.
  ///
  /// The [durationErrorInMinutes] parameter sets the time duration (in minutes) within which error limits are checked.
  void handleErrorAndSendToEmail(dynamic error, int errorLimit, int durationErrorInMinutes) {
    final currentTimeOccurrence = DateTime.now();
    final formattedDateTime = currentTimeOccurrence.formatted();

    emailMessage = 'Foram identificados:\n $errorCount erros em $durationErrorInMinutes minutos.'
        '\n Hora: $formattedDateTime Tipo de Erro: $error\n '
        'Na loja Virtual: ${stores?.nameStore ?? 'de sua propriedade!'}';

    // If it is the first error or if you have exceeded the minutes limit
    // since the last error, we reset the error counter.
    if (lastErrorTime == null ||
        currentTimeOccurrence.difference(lastErrorTime!) >
            Duration(minutes: durationErrorInMinutes)) {
      resetErrorCount();
    }

    errorCount++;

    // Activates email sending if the error limit is reached.
    if (errorCount >= errorLimit) {
      sendEmailNotification(
        recipientEmail: recipientEmail ?? '',
        subject: emailSubject ?? '',
        messageText: emailMessage,
      );
      resetErrorCount();
    }
    lastErrorTime = currentTimeOccurrence;
  }

  /// Resets the error count and last error time.
  void resetErrorCount() {
    errorCount = 0;
    lastErrorTime = null;
  }
}
