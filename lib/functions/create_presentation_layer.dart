import 'dart:developer';
import 'dart:io';

import 'package:artisan/extensions/clickable_string_console_path.dart';
import 'package:artisan/extensions/color_print_extension.dart';
import 'package:artisan/extensions/naming_conventions_extension.dart';

/// Creates the presentation layer structure
void createPresentationLayer(String featureName) {
  Directory('lib/features/${featureName.toSnakeCase()}/presentation')
      .createSync(recursive: true);
  Directory('lib/features/${featureName.toSnakeCase()}/presentation/providers')
      .createSync(recursive: true);
  Directory('lib/features/${featureName.toSnakeCase()}/presentation/views')
      .createSync(recursive: true);
  Directory('lib/features/${featureName.toSnakeCase()}/presentation/widgets')
      .createSync(recursive: true);

  'Presentation layer created for ${featureName.toSnakeCase()}'.printBoldGreen();
}
