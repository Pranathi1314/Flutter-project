import 'package:cloud_firestore/cloud_firestore.dart';

//return formatted data as a string

String formatDate(Timestamp timestamp) {
  DateTime dateTime = timestamp.toDate();
  String year = dateTime.year.toString();
  String month = dateTime.day.toString();
  String day = dateTime.day.toString();
  String formattedData = '$day/$month/$year';
  return formattedData;
}