// ignore_for_file: non_constant_identifier_names

import 'package:intl/intl.dart';

class DateFormatSamples {
  static String dateFormat_dd_MMMM_yyyy(String date) {
    if (date.isEmpty) {
      return "";
    }
    String formatDate = DateFormat("dd MMMM yyyy").format(DateTime.parse(date));
    return formatDate;
  }
}
