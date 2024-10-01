import 'dart:developer';
import 'dart:io';

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

  log('Presentation layer created for $featureName');
}