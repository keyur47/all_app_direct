import 'package:intl/intl.dart';

dateTime() {
  final DateFormat formatter = DateFormat('hh:mm a');
  final String formatted = formatter.format(DateTime.now());
  return formatted;
}

day() {
  DateTime now = DateTime.now();
  String formattedDate = DateFormat.E().format(now);
  return formattedDate;
}

