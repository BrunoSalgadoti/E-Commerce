import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart' show DateFormat;

/// # Function for formatting date and time fields in Brazil format (Folder: common/formatted_fields)
/// ## formatTimestamp
String formatTimestamp(Timestamp timestamp) {
  DateTime dateTime = timestamp.toDate();
  String formattedDate = DateFormat("dd/MM/yyyy HH:mm").format(dateTime);
  return formattedDate;
}
