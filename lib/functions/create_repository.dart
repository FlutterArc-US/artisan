import 'dart:io';

import 'package:artisan/extensions/naming_conventions_extension.dart';
import 'package:artisan/files/repository_file.dart';
import 'package:artisan/files/repository_method.dart';
import 'package:artisan/functions/get_app_package_name.dart';

/// [Make Repository]
void createRepository({
  required String usecaseName,
  required String featureName,
  required String datasourceName,
}) async {
  final fileAddress =
      'lib/features/${featureName.toSnakeCase()}/domain/repository';
  var directory = Directory(fileAddress);
  if (!directory.existsSync()) {
    directory.createSync(recursive: true);
  }

  // Your logic to generate the model file
  var content = repositoryFile(usecaseName, featureName);

  // Create the file
  var file = File("$fileAddress/${featureName.toSnakeCase()}_repository.dart");

  if (file.existsSync()) {
    final sink = file.readAsLinesSync();
    await file.writeAsString('');
    if (sink.isEmpty) {
      file.writeAsStringSync(content);
    } else {
      while (sink.last.isEmpty) {
        sink.removeLast();
      }

      final writeSink = file.openWrite(mode: FileMode.writeOnlyAppend);
      final indexToPlaceImport =
          sink.indexOf("////********** END IMPORTS **********////");

      final indexToPlaceMethod =
          sink.indexOf("////********** END METHODS **********////");

      for (var i = 0; i < sink.length; i++) {
        final line = sink[i];
        if (i == indexToPlaceImport) {
          writeSink.writeln(
              "import 'package:${getPackageName()}/features/${featureName.toSnakeCase()}/domain/usecases/${usecaseName.toSnakeCase()}_usecase.dart';");
        }

        if (i == indexToPlaceMethod) {
          writeSink.writeln(newRepoMethod(usecaseName, featureName));
        }
        writeSink.writeln(line);
      }
    }
  } else {
    file.writeAsStringSync(content);
  }
}
