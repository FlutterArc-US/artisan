import 'package:artisan/extensions/color_print_extension.dart';

extension ClickablePath on String {
  void printClickablePath() {
    final file = 'file://$this'.printNormal();
    return file;
  }
}
