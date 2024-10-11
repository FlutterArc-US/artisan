import 'package:artisan/extensions/color_print_extension.dart';

extension ClickablePath on String {
  void printClickablePath() {
    assert(() {
      print('file://$this');
      return true;
    }());
  }
}
