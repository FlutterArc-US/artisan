import 'dart:developer';
import 'dart:io';

import 'package:artisan/files/main_file.dart';
import 'package:artisan/files/num_extension_file.dart';

import '../../extensions/get_app_package_name.dart';

/// [addMain] function creates the main.dart file in the lib folder.
Future<void> addMain() async {
  final mainFilePath = "${Directory.current.path}/lib/main.dart";
  final content = resolveImports(mainFile);
  File(mainFilePath).writeAsStringSync(content);
  log("✅ Added main.dart with package imports for ${getPackageName()}");
}

// Future<void> addCommon() async {
//   final file = File("${Directory.current.path}/lib/common/extensions/num.dart");
//   file.createSync(recursive: true);
//   final content = resolveImports(numExtensionContents);
//   file.writeAsStringSync(content);
//   log("✅ Num Extension Added for ${getPackageName()}");
// }
