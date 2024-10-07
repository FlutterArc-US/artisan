import 'dart:developer';
import 'dart:io';

import 'package:artisan/extensions/clickable_string_console_path.dart';
import 'package:artisan/extensions/color_print_extension.dart';
import 'package:artisan/extensions/naming_conventions_extension.dart';

/// Creates the data layer structure
void createDataLayer(String featureName) {
  Directory('lib/features/${featureName.toSnakeCase()}/data')
      .createSync(recursive: true);
  Directory('lib/features/${featureName.toSnakeCase()}/data/models')
      .createSync(recursive: true);
  Directory('lib/features/${featureName.toSnakeCase()}/data/repositories')
      .createSync(recursive: true);
  Directory('lib/features/${featureName.toSnakeCase()}/data/datasources/local')
      .createSync(recursive: true);
  Directory('lib/features/${featureName.toSnakeCase()}/data/datasources/remote')
      .createSync(recursive: true);
  Directory('lib/features/${featureName.toSnakeCase()}/data/datasources/mock')
      .createSync(recursive: true);

  'Data layer created for ${featureName.toSnakeCase()}'.printBoldGreen();
}
