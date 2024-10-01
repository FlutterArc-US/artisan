import 'dart:developer';
import 'dart:io';

import 'package:artisan/files/main_file.dart';
import 'package:artisan/files/num_extension_file.dart';

/// [addMain] function creates the main.dart file in the lib folder.
Future<void> addMain() async {
  final mainDart = File("${Directory.current.path}/lib/main.dart");
  mainDart.writeAsStringSync(mainFile);
  log("Added main");
}

Future<void> addCommon() async {
  final numExtension =
      File("${Directory.current.path}/lib/common/extensions/num.dart");
  numExtension.createSync(recursive: true);
  numExtension.writeAsStringSync(numExtensionContents);
  log("Num Extension Added");
}
