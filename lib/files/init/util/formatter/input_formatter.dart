import 'package:flutter/services.dart';

class InputFormatters {
  static FilteringTextInputFormatter get decimalFormatter =>
      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'));
}
