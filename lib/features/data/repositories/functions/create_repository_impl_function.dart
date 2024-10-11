import 'dart:io';

import 'package:artisan/extensions/naming_conventions_extension.dart';
import 'package:artisan/features/data/repositories/files/create_repository_impl_file.dart';
import 'package:artisan/functions/name_cases/convert_to_pascal_case.dart';
import 'package:artisan/utils/functions/get_app_package_name.dart';

import '../../../../files/repository_imp_method.dart';

void createRepositoryImpl({
  required String usecaseName,
  required String featureName,
  required String datasourceName,
}) async {
  final fileAddress =
      'lib/features/${featureName.toSnakeCase()}/data/repository';
  var directory = Directory(fileAddress);
  if (!directory.existsSync()) {
    directory.createSync(recursive: true);
  }

  var content = repositoryFileImp(usecaseName, featureName, datasourceName);

  var file =
  File("$fileAddress/${featureName.toSnakeCase()}_repository_impl.dart");
  final basePath = 'package:${getPackageName()}';
  final featurePath = '$basePath/features/${featureName.toSnakeCase()}';

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
          writeSink.writeln(
              "import '$featurePath/domain/usecases/${usecaseName.toSnakeCase()}_usecase.dart';");
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