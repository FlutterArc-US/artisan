import 'dart:developer';
import 'dart:io';

import 'package:artisan/extensions/clickable_string_console_path.dart';
import 'package:artisan/extensions/color_print_extension.dart';

/// Creates the presentation layer structure
void createPresentationLayer(String featureName) {
  Directory('lib/features/$featureName/presentation')
      .createSync(recursive: true);
  Directory('lib/features/$featureName/presentation/providers')
      .createSync(recursive: true);
  Directory('lib/features/$featureName/presentation/views')
      .createSync(recursive: true);
  Directory('lib/features/$featureName/presentation/widgets')
      .createSync(recursive: true);

  'Presentation layer created for $featureName'.printBoldGreen();
}
