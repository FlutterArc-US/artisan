import 'dart:io';

import 'package:artisan/extensions/clickable_string_console_path.dart';
import 'package:artisan/extensions/color_print_extension.dart';
import 'package:artisan/extensions/naming_conventions_extension.dart';
import 'package:artisan/functions/features_functions/create_feature.dart';
import 'package:artisan/functions/features_functions/domain_functions/entities/files/create_entity_file.dart';

Future<void> createEntity(String entityName, String featureName) async {
  try {
    final projectPath = Directory.current.path;

    final featureDirectory =
        Directory('$projectPath/lib/features/$featureName/domain/entities');

    if (!await featureDirectory.exists()) {
      createFeature(featureName);
      'Feature not found, creating feature: $featureName'.printBoldOrange();
    }

    final entityFilePath =
        '${featureDirectory.path}/${entityName.toSnakeCase()}_entity.dart';

    if (await File(entityFilePath).exists()) {
      'Error: Entity File already exists: '.printBoldRed();
      entityFilePath.printClickablePath();
      return;
    }

    var contentFile = createEntityFile(entityName);
    File(entityFilePath).writeAsStringSync(contentFile);

    'Entity file created successfully: '.printBoldGreen();
    entityFilePath.toSnakeCase().printClickablePath();
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
