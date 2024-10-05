import 'package:artisan/extensions/color_print_extension.dart';

extension ClickablePath on String {
  void printClickablePath() {
    final file = print('file://$this');
    return file;
  }
}
