import 'dart:io';

import 'package:artisan/files/datasource_file.dart';
import 'package:artisan/files/datasource_file_imp.dart';
import 'package:artisan/files/datasource_imp_method.dart';
import 'package:artisan/files/model_file.dart';
import 'package:artisan/files/repository_file.dart';
import 'package:artisan/files/repository_imp.dart';
import 'package:artisan/files/repository_imp_method.dart';
import 'package:artisan/files/repository_method.dart';
import 'package:artisan/files/usecase_file.dart';

///[Make File]
makeFile(String makeCommand) {
  final fileType = makeCommand.split(' ').first;
  final file = makeCommand.split(' ').map((e) => e == fileType ? '' : e).toList().reduce((value, element) => "$value $element");

  if (fileType == 'model') {
    makeModel(file);
  } else if (fileType == 'usecase') {
    final usecaseName = file.split(' on ').first.trim();
    final featureAndDatasource = file.split(' on ').last.trim();
    final featureName = featureAndDatasource.split('--').first.trim();
    final datasource = featureAndDatasource.split('--').last.trim();

    makeUsecase(usecaseName, featureName, featureName == datasource);

    if (featureName == datasource) {
      ///When no arguments with -- given.
      return;
    }

    makeRepository(
      usecaseName: usecaseName,
      featureName: featureName,
      datasourceName: datasource,
    );
    makeRepositoryImp(
      usecaseName: usecaseName,
      featureName: featureName,
      datasourceName: datasource,
    );
    makeDatasource(
      usecaseName: usecaseName,
      featureName: featureName,
      datasourceName: datasource,
    );
    makeDatasourceImp(
      usecaseName: usecaseName,
      featureName: featureName,
      datasourceName: datasource,
    );
  }
}

/// [Make Model]
void makeModel(String modelName) {
  final fileName = modelName.split(' on ').first.trim();
  final className = convertToPascalCase(fileName).trim();
  final featureName = modelName.split(' on ').last.trim();

  final fileAddress = 'lib/features/$featureName/domain/models/$fileName';

  var directory = Directory(fileAddress);
  if (!directory.existsSync()) {
    directory.createSync(recursive: true);
  }

  // Your logic to generate the model file
  var content = modelFile(className, fileName);

  // Create the file
  var file = File("$fileAddress/$fileName.dart");
  file.writeAsStringSync(content);

  print('Model $modelName created successfully!');
}

/// [Make Usecase]
void makeUsecase(String usecaseName, String featureName, bool onlyUsecase) {
  final fileAddress = 'lib/features/$featureName/domain/usecases';

  var directory = Directory(fileAddress);
  if (!directory.existsSync()) {
    directory.createSync(recursive: true);
  }

  // Your logic to generate the model file
  var content = onlyUsecase ? onlyUsecaseFile(usecaseName, featureName) : usecaseFile(usecaseName, featureName);

  // Create the file
  var file = File("$fileAddress/$usecaseName.dart");
  file.writeAsStringSync(content);

  print('Usecase $usecaseName created successfully!');
}

/// [Make Repository]
void makeRepository({
  required String usecaseName,
  required String featureName,
  required String datasourceName,
}) async {
  final fileAddress = 'lib/features/$featureName/domain/repository';
  var directory = Directory(fileAddress);
  if (!directory.existsSync()) {
    directory.createSync(recursive: true);
  }

  // Your logic to generate the model file
  var content = repositoryFile(usecaseName, featureName);

  // Create the file
  var file = File("$fileAddress/${featureName}_repository.dart");

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
      final indexToPlaceImport = sink.indexOf("////********** END IMPORTS **********////");

      final indexToPlaceMethod = sink.indexOf("////********** END METHODS **********////");

      for (var i = 0; i < sink.length; i++) {
        final line = sink[i];
        if (i == indexToPlaceImport) {
          writeSink.writeln("import '../usecases/$usecaseName.dart';");
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

/// [Make Repository]
void makeRepositoryImp({
  required String usecaseName,
  required String featureName,
  required String datasourceName,
}) async {
  final fileAddress = 'lib/features/$featureName/domain/repository';
  var directory = Directory(fileAddress);
  if (!directory.existsSync()) {
    directory.createSync(recursive: true);
  }

  // Your logic to generate the model file
  var content = repositoryFileImp(usecaseName, featureName, datasourceName);

  // Create the file
  var file = File("$fileAddress/${featureName}_repository_imp.dart");

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
      final indexToPlaceImport = sink.indexOf("////********** END IMPORTS **********////");

      final indexToPlaceMethod = sink.indexOf("////********** END METHODS **********////");

      final indexToReceiveValues = sink.indexOf('////********** START RECEIVE VALUES **********////');
      final indexToEndReceiveValues = sink.indexOf('////********** END RECEIVE VALUES **********////');

      final indexOfEndVariables = sink.indexOf("////********** END VARIABLES **********////");

      final indexOfEndSetValues = sink.indexOf('////********** END SET VALUES **********////');

      final isImportedDatasource = sink
          .getRange(indexToReceiveValues, indexToEndReceiveValues + 1)
          .any((element) => element.contains('${convertToCamelCase(featureName)}${convertToPascalCase(datasourceName)}DataSource'));

      for (var i = 0; i < sink.length; i++) {
        var line = sink[i];
        if (!isImportedDatasource) {
          if (indexToPlaceImport == i) {
            writeSink.writeln("import '../../data/source/$datasourceName/${featureName}_${datasourceName}_datasource.dart';");
          }

          if (indexToEndReceiveValues == i) {
            writeSink.writeln(
                "    required ${convertToPascalCase(featureName)}${convertToPascalCase(datasourceName)}DataSource ${convertToCamelCase(featureName)}${convertToPascalCase(datasourceName)}DataSource,");
          }

          if ((indexOfEndVariables == i)) {
            writeSink.writeln(
                "  final ${convertToPascalCase(featureName)}${convertToPascalCase(datasourceName)}DataSource _${convertToCamelCase(featureName)}${convertToPascalCase(datasourceName)}DataSource;");
          }

          if (indexOfEndSetValues == i) {
            writeSink.writeln(
                '        _${convertToCamelCase(featureName)}${convertToPascalCase(datasourceName)}DataSource = ${convertToCamelCase(featureName)}${convertToPascalCase(datasourceName)}DataSource');
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

/// [Make Datasource Imp]
void makeDatasourceImp({
  required String usecaseName,
  required String featureName,
  required String datasourceName,
}) async {
  final fileAddress = 'lib/features/$featureName/data/source/$datasourceName';
  var directory = Directory(fileAddress);
  if (!directory.existsSync()) {
    directory.createSync(recursive: true);
  }

  // Your logic to generate the model file
  var content = datasourceFileImp(usecaseName, featureName, datasourceName);

  // Create the file
  var file = File("$fileAddress/${featureName}_${datasourceName}_datasource_imp.dart");

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
      final indexToPlaceImport = sink.indexOf("////********** END IMPORTS **********////");

      final indexToPlaceMethod = sink.indexOf("////********** END METHODS **********////");

      for (var i = 0; i < sink.length; i++) {
        var line = sink[i];

        if (i == indexToPlaceImport) {
          writeSink.writeln("import '../../../domain/usecases/$usecaseName.dart';");
        }

        if (i == indexToPlaceMethod) {
          writeSink.writeln(newDatasourceMethodImp(
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

/// [Make DataSource]
void makeDatasource({
  required String usecaseName,
  required String featureName,
  required String datasourceName,
}) async {
  final fileAddress = 'lib/features/$featureName/data/source/$datasourceName';

  var directory = Directory(fileAddress);
  if (!directory.existsSync()) {
    directory.createSync(recursive: true);
  }

  // Your logic to generate the model file
  var content = datasourceFile(usecaseName, featureName, datasourceName);

  // Create the file
  var file = File("$fileAddress/${featureName}_${datasourceName}_datasource.dart");

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
      final indexToPlaceImport = sink.indexOf("////********** END IMPORTS **********////");

      final indexToPlaceMethod = sink.indexOf("////********** END METHODS **********////");

      for (var i = 0; i < sink.length; i++) {
        final line = sink[i];

        if (i == indexToPlaceImport) {
          writeSink.writeln("import '../../../domain/usecases/$usecaseName.dart';");
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

/// [Convert to PascalCase]
String convertToPascalCase(String input) {
  var words = input.split('_');
  var result = '';

  for (final word in words) {
    result += word.trim()[0].toUpperCase() + word.trim().substring(1);
  }

  return result;
}

/// [Convert to camelCase]
String convertToCamelCase(String input) {
  var words = input.split('_');
  var result = words.first;

  for (var i = 1; i < words.length; i++) {
    result += words[i].trim()[0].toUpperCase() + words[i].trim().substring(1);
  }

  return result;
}
