import 'dart:io';

import 'package:artisan/files/repository_imp.dart';
import 'package:artisan/files/repository_imp_method.dart';
import 'package:artisan/extensions/naming_conventions_extension.dart';

import 'name_cases/convert_to_pascal_case.dart';

/// [Make Repository]
void createRepositoryImp({
  required String usecaseName,
  required String featureName,
  required String datasourceName,
}) async {
  final fileAddress = 'lib/features/${featureName.toSnakeCase()}/domain/repository';
  var directory = Directory(fileAddress);
  if (!directory.existsSync()) {
    directory.createSync(recursive: true);
  }

  // Your logic to generate the model file
  var content = repositoryFileImp(usecaseName, featureName, datasourceName);

  // Create the file
  var file = File("$fileAddress/${featureName.toSnakeCase()}_repository_imp.dart");

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

      final indexToReceiveValues =
          sink.indexOf('////********** START RECEIVE VALUES **********////');
      final indexToEndReceiveValues =
          sink.indexOf('////********** END RECEIVE VALUES **********////');

      final indexOfEndVariables =
          sink.indexOf("////********** END VARIABLES **********////");

      final indexOfEndSetValues =
          sink.indexOf('////********** END SET VALUES **********////');

      final isImportedDatasource = sink
          .getRange(indexToReceiveValues, indexToEndReceiveValues + 1)
          .any((element) => element.contains(
              '${featureName.toCamelCase()}${datasourceName.toPascalCase()}DataSource'));

      for (var i = 0; i < sink.length; i++) {
        var line = sink[i];
        if (!isImportedDatasource) {
          if (indexToPlaceImport == i) {
            writeSink.writeln(
                "import '../../data/source/$datasourceName/${featureName.toSnakeCase()}_${datasourceName.toSnakeCase()}_datasource.dart';");
          }

          if (indexToEndReceiveValues == i) {
            writeSink.writeln(
                "    required ${convertToPascalCase(featureName)}${convertToPascalCase(datasourceName)}DataSource ${featureName.toCamelCase()}${datasourceName.toPascalCase()}DataSource,");
          }

          if ((indexOfEndVariables == i)) {
            writeSink.writeln(
                "  final ${convertToPascalCase(featureName)}${convertToPascalCase(datasourceName)}DataSource _${featureName.toCamelCase()}${datasourceName.toPascalCase()}DataSource;");
          }

          if (indexOfEndSetValues == i) {
            writeSink.writeln(
                '        _${featureName.toCamelCase()}${datasourceName.toPascalCase()}DataSource = ${featureName.toCamelCase()}${datasourceName.toPascalCase()}DataSource');
          }

          if (indexOfEndSetValues - 1 == i) {
            line += ',';
          }
        }

        if (i == indexToPlaceImport) {
          writeSink.writeln("import '../usecases/$usecaseName.dart';");
        }

        if (i == indexToPlaceMethod) {
          writeSink.writeln(newRepoMethodImp(
            usecaseName,
            featureName,
            datasourceName,
          ));
        }

        writeSink.writeln(line);
      }
    }
  } else {
    file.writeAsStringSync(content);
  }
}
