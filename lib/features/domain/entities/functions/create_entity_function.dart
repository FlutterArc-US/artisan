import 'dart:io';

import 'package:artisan/extensions/clickable_string_console_path.dart';
import 'package:artisan/extensions/color_print_extension.dart';
import 'package:artisan/extensions/naming_conventions_extension.dart';
import 'package:artisan/features/create_feature.dart';
import 'package:artisan/features/domain/entities/files/create_entity_file.dart';

Future<void> createEntity(String entityName, String featureName) async {
  try {
    final projectPath = Directory.current.path;

    final featureDirectory =
        Directory('$projectPath/lib/features/$featureName/domain/entities');

    if (!await featureDirectory.exists()) {
      createFeature(featureName);
      'Feature directory not found, creating directory: $featureDirectory'
          .printBoldOrange();
    }

    final entityDirectory =
        Directory('${featureDirectory.path}/${entityName.toSnakeCase()}');

    if (!await entityDirectory.exists()) {
      entityDirectory.createSync();
      'Entity directory not found, creating directory: $entityDirectory'
          .printBoldGreen();
    }

    final entityFilePath =
        '${featureDirectory.path}/${entityName.toSnakeCase()}/${entityName.toSnakeCase()}_entity.dart';

    if (await File(entityFilePath).exists()) {
      'Error: entity file already exists: '.printBoldRed();
      entityFilePath.printClickablePath();
      return;
    }

    var contentFile = createEntityFile(entityName);

    File(entityFilePath).writeAsStringSync(contentFile);

    'Entity file created successfully: '.printBoldGreen();
    entityFilePath.printClickablePath();
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
