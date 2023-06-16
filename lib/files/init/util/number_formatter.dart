import 'package:intl/intl.dart';

class CurrencyFormatter {
  static String formatCompactCurrencyWithSymbol(num value) {
    return NumberFormat.compactCurrency(symbol: "").format(value);
  }
}
