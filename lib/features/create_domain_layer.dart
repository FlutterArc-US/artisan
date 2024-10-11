import 'dart:io';

import 'package:artisan/extensions/color_print_extension.dart';
import 'package:artisan/extensions/naming_conventions_extension.dart';

/// Creates the domain layer structure
void createDomainLayer(String featureName) {
  Directory('lib/features/${featureName.toSnakeCase()}/domain')
      .createSync(recursive: true);
  Directory('lib/features/${featureName.toSnakeCase()}/domain/entities')
      .createSync(recursive: true);
  Directory('lib/features/${featureName.toSnakeCase()}/domain/repository')
      .createSync(recursive: true);
  Directory('lib/features/${featureName.toSnakeCase()}/domain/usecases')
      .createSync(recursive: true);

  'Domain layer created for ${featureName.toSnakeCase()}'.printBoldGreen();
}
