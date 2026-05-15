import 'package:cloud_firestore/cloud_firestore.dart';

DateTime firestoreTimestampToDateTime(Timestamp timestamp) {
  return timestamp.toDate();
}