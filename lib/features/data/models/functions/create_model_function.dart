import 'dart:io';

import 'package:artisan/extensions/clickable_string_console_path.dart';
import 'package:artisan/extensions/color_print_extension.dart';
import 'package:artisan/extensions/naming_conventions_extension.dart';
import 'package:artisan/features/create_feature.dart';
import 'package:artisan/features/data/models/files/create_model_file.dart';

Future<void> createModel(String modelName, String featureName) async {
  try {
    final projectPath = Directory.current.path;

    final featureDirectory =
        Directory('$projectPath/lib/features/$featureName/data/models');

    // Check if the directory exists; if not, create it (recursively)
    if (!await featureDirectory.exists()) {
      createFeature(featureName);
      'Feature directory not found, creating directory: $featureDirectory'
          .printBoldOrange();
    }

    final modelDirectory =
        Directory('${featureDirectory.path}/${modelName.toSnakeCase()}');

    if (!await modelDirectory.exists()) {
      modelDirectory.createSync();
      'Model directory not found, creating directory: $modelDirectory'
          .printBoldGreen();
    }

    // Define the model file path
    final modelFilePath =
        '${featureDirectory.path}/${modelName.toSnakeCase()}/rest_${modelName.toSnakeCase()}_model.dart';

    // Check if the file already exists to prevent overwriting
    if (await File(modelFilePath).exists()) {
      'Error: Model file already exists: '.printBoldRed();
      modelFilePath.printClickablePath();
      return;
    }

    // Create the content for the model file
    var contentFile = createModelFile(modelName, featureName);

    // Write the content to the file
    File(modelFilePath).writeAsStringSync(contentFile);

    'Model file created successfully: '.printBoldGreen();
    modelFilePath.printClickablePath();
  } catch (e) {
    // Handle different types of errors
    switch (e.runtimeType) {
      case FileSystemException:
        'Error: Unable to create or write to the model file.'.printRed();
        break;
      default:
        'An unknown error occurred: $e'.printBoldRed();
    }
  }
}