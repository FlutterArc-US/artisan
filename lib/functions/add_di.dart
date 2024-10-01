import 'dart:io';

import 'package:artisan/files/di_config_file.dart';
import 'package:artisan/files/di_file.dart';

void addDi() {
  final diFile = File("${Directory.current.path}/lib/util/di/di.dart");
  final diConfigFile =
      File("${Directory.current.path}/lib/util/di/di.config.dart");

  if (!diFile.existsSync()) {
    diFile.createSync(recursive: true);
  }

  if (!diConfigFile.existsSync()) {
    diConfigFile.createSync(recursive: true);
  }

  diFile.writeAsStringSync(diFileContent);
  diConfigFile.writeAsStringSync(diConfigFileContent);
}
