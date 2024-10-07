import 'dart:io';

import 'package:artisan/extensions/clickable_string_console_path.dart';
import 'package:artisan/extensions/color_print_extension.dart';
import 'package:artisan/extensions/naming_conventions_extension.dart';
import 'package:artisan/features/create_feature.dart';
import 'package:artisan/features/data_functions/models/files/create_model_file.dart';

Future<void> createEntity(String entityName, String featureName) async {
  try {
    final projectPath = Directory.current.path;

    final featureDirectory = Directory(
        '$projectPath/lib/features/$featureName/domain/entities/${entityName.toSnakeCase()}');

    if (!await featureDirectory.exists()) {
      createFeature(featureName);
      'Feature directory not found, creating directory: $featureDirectory'
          .printBoldOrange();
    }

    final entityFilePath =
        '${featureDirectory.path}/rest_${entityName.toSnakeCase()}_entity.dart';

    // Check if the file already exists to prevent overwriting
    if (await File(entityFilePath).exists()) {
      'Error: Entity file already exists: '.printBoldRed();
      entityFilePath.printClickablePath();
      return;
    }

    var contentFile = createModelFile(entityName, featureName);

    // Write the content to the file
    File(entityFilePath).writeAsStringSync(contentFile);

    'Entity file created successfully: '.printBoldGreen();
    entityFilePath.printClickablePath();
  } catch (e) {
    // Handle different types of errors
    switch (e.runtimeType) {
      case FileSystemException:
        'Error: Unable to create or write to the Entity file.'.printRed();
        break;
      default:
        'An unknown error occurred: $e'.printBoldRed();
    }
  }
}
