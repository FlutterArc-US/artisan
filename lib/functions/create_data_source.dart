import 'dart:io';

import 'package:artisan/files/datasource_file.dart';
import 'package:artisan/files/repository_method.dart';

/// [Create DataSource]
void createDatasource({
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
  var file =
      File("$fileAddress/${featureName}_${datasourceName}_datasource.dart");

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
          writeSink
              .writeln("import '../../../domain/usecases/$usecaseName.dart';");
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
