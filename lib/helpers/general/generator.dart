import 'package:intl/intl.dart';

String generateTempDataKey() {
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(now);
  return formattedDate;
}
