import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;

void init() async{
  try {
    final a = await rootBundle.load('package:artisan/');
    print(a.toString());
    return;
    final packageDirectory = path.dirname(Platform.script.toFilePath());
    final fromPath = path.join(packageDirectory, 'lib', 'files', 'init');
    print(fromPath);

    final toPath = Directory('./lib');

    print(toPath);

    if (!toPath.existsSync()) {
      toPath.createSync(recursive: true);
    }

    copyDirectory(Directory(fromPath), toPath);
  } catch (e) {
    print(e);
  }
}

void copyDirectory(Directory source, Directory destination) {
  source.listSync(recursive: true).forEach((entity) {
    if (entity is File) {
      final relativePath = path.relative(entity.path, from: source.path);
      final destinationFile = path.join(destination.path, relativePath);
      final destinationDirectory = Directory(path.dirname(destinationFile));

      if (!destinationDirectory.existsSync()) {
        destinationDirectory.createSync(recursive: true);
      }

      entity.copySync(destinationFile);
      print('Copied file: $destinationFile');
    }
  });
}
