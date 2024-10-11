import 'dart:io';
import 'package:artisan/extensions/color_print_extension.dart';
import 'package:artisan/extensions/naming_conventions_extension.dart';

/// Creates the data layer structure
void createDataLayer(String featureName) {
  Directory('lib/features/${featureName.toSnakeCase()}/data')
      .createSync(recursive: true);
  Directory('lib/features/${featureName.toSnakeCase()}/data/models')
      .createSync(recursive: true);
  Directory('lib/features/${featureName.toSnakeCase()}/data/repository')
      .createSync(recursive: true);
  Directory('lib/features/${featureName.toSnakeCase()}/data/source/local')
      .createSync(recursive: true);
  Directory('lib/features/${featureName.toSnakeCase()}/data/source/remote')
      .createSync(recursive: true);
  Directory('lib/features/${featureName.toSnakeCase()}/data/source/mock')
      .createSync(recursive: true);

  'Data layer created for ${featureName.toSnakeCase()}'.printBoldGreen();
}
