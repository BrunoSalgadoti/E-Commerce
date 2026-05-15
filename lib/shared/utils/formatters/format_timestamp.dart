import 'package:intl/intl.dart' show DateFormat;

String formatTimestamp(DateTime dateTime) {
  return DateFormat("dd/MM/yyyy HH:mm").format(dateTime);
}