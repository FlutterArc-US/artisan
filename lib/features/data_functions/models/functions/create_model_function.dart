import 'dart:io';

import 'package:artisan/extensions/clickable_string_console_path.dart';
import 'package:artisan/extensions/color_print_extension.dart';
import 'package:artisan/extensions/naming_conventions_extension.dart';
import 'package:artisan/features/create_feature.dart';
import 'package:artisan/features/data_functions/models/files/create_model_file.dart';

Future<void> createModel(String modelName, String featureName) async {
  try {
    final projectPath = Directory.current.path;

    final featureDirectory =
        Directory('$projectPath/lib/features/$featureName/data/models');

    if (!await featureDirectory.exists()) {
      createFeature(featureName);
      'Feature not found, creating feature: $featureName'.printBoldOrange();
    }

    final modelFilePath =
        '${featureDirectory.path}/${modelName.toSnakeCase()}_model.dart';

    if (await File(modelFilePath).exists()) {
      'Error: Model File already exists: '.printBoldRed();
      modelFilePath.printClickablePath();
      return;
    }

    var contentFile = createModelFile(modelName, featureName);
    File(modelFilePath).writeAsStringSync(contentFile);

    'Entity file created successfully: '.printBoldGreen();
    modelFilePath.toSnakeCase().printClickablePath();
  } catch (e) {
    switch (e.runtimeType) {
      case FileSystemException:
        'Error: Unable to create or write to the entity file.'.printRed();
        break;
      default:
        'An unknown error occurred: $e'.printBoldRed();
    }
  }
}
