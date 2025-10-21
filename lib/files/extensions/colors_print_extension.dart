const colorPrintExtensionContents = '''
import 'package:flutter/material.dart';

/// Extension providing colorful console prints for debug builds only.
extension ColorfulPrint on String {
  void _debugAnsi(String code) {
    assert(() {
      debugPrint('\x1B[$code$this\x1B[0m');
      return true;
    }());
  }

  // ===== Normal Styles =====
  void printNormal() => _debugAnsi('');
  void printRed() => _debugAnsi('31m');
  void printGreen() => _debugAnsi('32m');
  void printBlue() => _debugAnsi('34m');
  void printYellow() => _debugAnsi('33m');
  void printPurple() => _debugAnsi('35m');
  void printCyan() => _debugAnsi('36m');
  void printOrange() => _debugAnsi('93m');

  // ===== Bold Styles =====
  void printBold() => _debugAnsi('1m');
  void printBoldRed() => _debugAnsi('1;31m');
  void printBoldGreen() => _debugAnsi('1;32m');
  void printBoldBlue() => _debugAnsi('1;34m');
  void printBoldYellow() => _debugAnsi('1;33m');
  void printBoldPurple() => _debugAnsi('1;35m');
  void printBoldCyan() => _debugAnsi('1;36m');
  void printBoldOrange() => _debugAnsi('1;93m');
}

/// Prints all color variants as a visual test.
void printColorfulPrints() {
  const message =
      "Flutter Project with Artisan Beta initializing... Please wait...";

  message.printNormal();
  message.printBold();
  message.printBoldRed();
  message.printBoldGreen();
  message.printBoldBlue();
  message.printBoldYellow();
  message.printBoldPurple();
  message.printBoldCyan();
  message.printBoldOrange();

  message.printRed();
  message.printGreen();
  message.printBlue();
  message.printYellow();
  message.printPurple();
  message.printCyan();
  message.printOrange();
}

/// Prints a clean visual divider line, useful for Artisan logs.
void printSectionDivider({String? title, String color = 'cyan'}) {
  assert(() {
    const divider = '────────────────────────────────────────────';
    final decorated = title == null
        ? divider
        : '$divider\n$title\n$divider';

    switch (color.toLowerCase()) {
      case 'red':
        decorated.printBoldRed();
        break;
      case 'green':
        decorated.printBoldGreen();
        break;
      case 'blue':
        decorated.printBoldBlue();
        break;
      case 'yellow':
        decorated.printBoldYellow();
        break;
      case 'purple':
        decorated.printBoldPurple();
        break;
      case 'orange':
        decorated.printBoldOrange();
        break;
      default:
        decorated.printBoldCyan();
    }
    return true;
  }());
}

/// Example usage for quick test
void main() {
  printSectionDivider(title: '🚀 Initializing Artisan', color: 'green');
  'Setting up project structure...'.printBoldBlue();
  'Dependencies installed successfully!'.printBoldGreen();
  printSectionDivider(title: '✅ Artisan Init Completed', color: 'yellow');
}
''';
