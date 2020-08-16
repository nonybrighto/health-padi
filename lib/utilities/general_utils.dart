import 'package:intl/intl.dart';


String stringDateFromDate(DateTime date){
  return DateFormat('dd MMMM, yyyy').format(date);
}

String stringTimeFromDate(DateTime date){
  String format = 'h:mm a';
  return DateFormat(format).format(date);
}