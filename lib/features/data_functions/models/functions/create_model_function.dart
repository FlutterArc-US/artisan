import 'dart:io';

import 'package:artisan/extensions/clickable_string_console_path.dart';
import 'package:artisan/extensions/color_print_extension.dart';
import 'package:artisan/extensions/naming_conventions_extension.dart';
import 'package:artisan/features/data_functions/models/files/create_model_file.dart';
Future<void> createModel(String modelName, String featureName) async {
  try {
    final projectPath = Directory.current.path;

    // Define the full directory path where the model will be created
    final featureDirectory = Directory('$projectPath/lib/features/$featureName/data/models');

    // Check if the directory exists; if not, create it (recursively)
    if (!await featureDirectory.exists()) {
      featureDirectory.createSync(recursive: true);
      'Feature directory not found, creating directory: $featureDirectory'.printBoldOrange();
    }

    // Define the model file path
    final modelFilePath = '${featureDirectory.path}/rest_${modelName.toSnakeCase()}_model.dart';

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
