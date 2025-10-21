import 'dart:developer';
import 'dart:io';

import 'package:artisan/extensions/color_print_extension.dart';
import 'package:artisan/files/extensions/colors_print_extension.dart';
import 'package:artisan/files/main_file.dart';
import 'package:artisan/files/extensions/num_extension_file.dart';

import 'get_app_package_name.dart';

/// [addMain] function creates the main.dart file in the lib folder.
Future<void> addMain() async {
  final mainFilePath = "${Directory.current.path}/lib/main.dart";
  final content = resolveImports(mainFile);
  File(mainFilePath).writeAsStringSync(content);
  log("✅ Added main.dart with package imports for ${getPackageName()}");
}

/// Creates or updates common extension files under `lib/common/extensions/`
Future<void> addCommon() async {
  final baseDir = Directory("${Directory.current.path}/lib/common/extensions");

  try {
    // Ensure directory exists
    if (!baseDir.existsSync()) {
      baseDir.createSync(recursive: true);
      '📁 Created directory: ${baseDir.path}'.printBoldGreen();
    }

    // ---------- NUM EXTENSION ----------
    final numFile = File("${baseDir.path}/num.dart");
    final numContent = resolveImports(numExtensionContents);
    if (!numFile.existsSync()) {
      numFile.writeAsStringSync(numContent);
      "✅ Num Extension Added for ${getPackageName()}".printBoldGreen();
    } else {
      final current = numFile.readAsStringSync();
      if (current.trim() != numContent.trim()) {
        numFile.writeAsStringSync(numContent);
        "⚙️ Num Extension Updated for ${getPackageName()}".printBoldYellow();
      } else {
        "✅ Num Extension already up to date.".printBoldCyan();
      }
    }

    // ---------- COLOR PRINT EXTENSION ----------
    final colorFile = File("${baseDir.path}/color_print_extension.dart");
    final colorContent = resolveImports(colorPrintExtensionContents);
    if (!colorFile.existsSync()) {
      colorFile.writeAsStringSync(colorContent);
      "✅ Color Print Extension Added for ${getPackageName()}".printBoldGreen();
    } else {
      final current = colorFile.readAsStringSync();
      if (current.trim() != colorContent.trim()) {
        colorFile.writeAsStringSync(colorContent);
        "⚙️ Color Print Extension Updated for ${getPackageName()}".printBoldYellow();
      } else {
        "✅ Color Print Extension already up to date.".printBoldCyan();
      }
    }

    '📦 Common extensions verified successfully.'.printBoldBlue();
  } catch (e, stack) {
    '🚨 Error in addCommon(): $e'.printBoldRed();
    'Stack Trace:\n$stack'.printRed();
  }
}