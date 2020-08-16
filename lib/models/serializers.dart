import 'package:cloud_firestore/cloud_firestore.dart';

DateTime timeStampToDateTime(dynamic timestamp) {
  if (timestamp is Timestamp && timestamp != null) {
    return timestamp.toDate();
  }
  return null;
}
