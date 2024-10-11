import 'dart:developer';
import 'dart:io';

import 'package:artisan/files/pubspec.yaml.dart';

///[Add pubspec.yaml]
Future<void> addPubspecYaml() async {
  log("Adding pubspec.yaml");
  final pubspecExisting = File("${Directory.current.path}/pubspec.yaml");
  final lines = pubspecExisting.readAsLinesSync();
  final contents = '${lines.first}\n$pubspecFile';
  pubspecExisting.writeAsStringSync(contents);
  log("Added pubspec.yaml");
}
