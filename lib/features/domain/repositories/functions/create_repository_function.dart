import 'dart:io';

import 'package:artisan/extensions/naming_conventions_extension.dart';
import 'package:artisan/features/domain/repositories/files/create_repository_file.dart';
import 'package:artisan/features/domain/repositories/functions/new_repo_method.dart';
import 'package:artisan/utils/functions/get_app_package_name.dart';

void createRepository({
  required String usecaseName,
  required String featureName,
  required String datasourceName,
}) async {
  final fileAddress = 'lib/features/${featureName.toSnakeCase()}/domain/repository';
  var directory = Directory(fileAddress);
  if (!directory.existsSync()) {
    directory.createSync(recursive: true);
  }

  // Generate the repository file content
  var content = repositoryFile(usecaseName, featureName);

  // Create or append to the repository file
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
