import 'dart:io';

import 'package:artisan/files/datasource_file_imp.dart';
import 'package:artisan/files/datasource_imp_method.dart';

/// [Make Datasource Imp]
void createDatasourceImp({
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
  var file =
      File("$fileAddress/${featureName}_${datasourceName}_datasource_imp.dart");

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
        var line = sink[i];

        if (i == indexToPlaceImport) {
          writeSink
              .writeln("import '../../../domain/usecases/$usecaseName.dart';");
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
