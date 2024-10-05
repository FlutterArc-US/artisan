import 'package:artisan/extensions/color_print_extension.dart';

extension ClickablePath on String {
  /// Returns a clickable link for file paths in supported terminal emulators
  dynamic printClickableGreen() {
    // Create clickable path using ANSI escape codes
    final path = '\x1B]8;;file://$this\x1B\\$this\x1B]8;;\x1B\\';
    final printGreenPath = path.printGreen();
    return printGreenPath;
  }

  dynamic printClickableRed() {
    // Create clickable path using ANSI escape codes
    final path = '\x1B]8;;file://$this\x1B\\$this\x1B]8;;\x1B\\';
    final printRedPath = path.printRed();
    return printRedPath;
  }
}
