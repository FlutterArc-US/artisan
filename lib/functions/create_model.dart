import 'dart:io';

import 'package:artisan/files/model_file.dart';

import 'convert_to_pascal_case.dart';

/// [Create Model]
void createModel(String modelName) {
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
