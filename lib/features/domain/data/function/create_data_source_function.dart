import 'dart:io';

import 'package:artisan/extensions/naming_conventions_extension.dart';
import 'package:artisan/features/domain/data/file/create_data_source_file.dart';
import 'package:artisan/features/domain/repositories/functions/new_repo_method.dart';

/// [Create DataSource]
void createDatasource({
  required String usecaseName,
  required String featureName,
  required String datasourceName,
}) async {
  final fileAddress =
      'lib/features/${featureName.toSnakeCase()}/data/datasources/${datasourceName.toSnakeCase()}';

  var directory = Directory(fileAddress);
  if (!directory.existsSync()) {
    directory.createSync(recursive: true);
  }

  // Logic to generate the datasource file
  var content = datasourceFile(usecaseName, featureName, datasourceName);

  // Create the file
  var file = File(
      "$fileAddress/${featureName.toSnakeCase()}_${datasourceName.toSnakeCase()}_datasource.dart");

  if (file.existsSync()) {
    final lines = file.readAsLinesSync();
    await file.writeAsString(''); // Clear the file

    if (lines.isEmpty) {
      file.writeAsStringSync(content);
    } else {
      // Trim empty lines at the end
      while (lines.last.isEmpty) {
        lines.removeLast();
      }

      final writeSink = file.openWrite(mode: FileMode.writeOnlyAppend);
      final importIndex =
      lines.indexOf("////********** END IMPORTS **********////");
      final methodIndex =
      lines.indexOf("////********** END METHODS **********////");

      for (var i = 0; i < lines.length; i++) {
        final line = lines[i];

        if (i == importIndex) {
          writeSink.writeln(
              "import '../../../domain/usecases/${usecaseName.toSnakeCase()}_usecase.dart';");
        }

        if (i == methodIndex) {
          writeSink.writeln(newRepoMethod(usecaseName, featureName));
        }

        writeSink.writeln(line); // Write each line back
      }
    }
  } else {
    file.writeAsStringSync(content);
  }
}
