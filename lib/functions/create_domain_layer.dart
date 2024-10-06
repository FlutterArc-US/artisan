import 'dart:developer';
import 'dart:io';

import 'package:artisan/extensions/color_print_extension.dart';

/// Creates the domain layer structure
void createDomainLayer(String featureName) {
  Directory('lib/features/$featureName/domain').createSync(recursive: true);
  Directory('lib/features/$featureName/domain/entities')
      .createSync(recursive: true);
  Directory('lib/features/$featureName/domain/repositories')
      .createSync(recursive: true);
  Directory('lib/features/$featureName/domain/usecases')
      .createSync(recursive: true);

  'Domain layer created for $featureName'.printBoldGreen();
}
