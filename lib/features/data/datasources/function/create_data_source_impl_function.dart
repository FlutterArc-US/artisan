import 'dart:io';

import 'package:artisan/extensions/naming_conventions_extension.dart';
import 'package:artisan/features/data/datasources/files/create_data_source_impl_file.dart';
import 'package:artisan/files/datasource_imp_method.dart';

/// [Create DataSource Implementation]
void createDatasourceImp({
  required String usecaseName,
  required String featureName,
  required String datasourceName,
}) async {
  final fileAddress = 'lib/features/${featureName.toSnakeCase()}/data/source/${datasourceName.toSnakeCase()}';
  var directory = Directory(fileAddress);
  if (!directory.existsSync()) {
    directory.createSync(recursive: true);
  }

  // Logic to generate the datasource implementation file
  var content = datasourceFileImp(usecaseName, featureName, datasourceName);

  // Create the file
  var file = File(
      "$fileAddress/${featureName.toSnakeCase()}_${datasourceName.toSnakeCase()}_datasource_imp.dart");

  if (file.existsSync()) {
    final lines = file.readAsLinesSync();
    await file.writeAsString(''); // Clear the file content

    if (lines.isEmpty) {
      file.writeAsStringSync(content);
    } else {
      // Remove empty lines at the end
      while (lines.last.isEmpty) {
        lines.removeLast();
      }

      final writeSink = file.openWrite(mode: FileMode.writeOnlyAppend);
      final importIndex = lines.indexOf("////********** END IMPORTS **********////");
      final methodIndex = lines.indexOf("////********** END METHODS **********////");

      for (var i = 0; i < lines.length; i++) {
        var line = lines[i];

        if (i == importIndex) {
          writeSink.writeln("import '../../../domain/usecases/${usecaseName.toSnakeCase()}_usecase.dart';");
        }

        if (i == methodIndex) {
          writeSink.writeln(newDatasourceMethodImp(
            usecaseName,
            featureName,
            datasourceName,
          ));
        }

        writeSink.writeln(line); // Write each line back
      }
    }
  } else {
    file.writeAsStringSync(content);
  }
}
