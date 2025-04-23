import 'package:intl/intl.dart';

class CustomDateUtils{
  static String formattedDate(DateTime date){
    var formatted = DateFormat("dd MMM yyyy").format(date);
    return formatted;
  }
}