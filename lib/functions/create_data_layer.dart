import 'dart:developer';
import 'dart:io';

/// Creates the data layer structure
void createDataLayer(String featureName) {
  Directory('lib/features/$featureName/data').createSync(recursive: true);
  Directory('lib/features/$featureName/data/entities')
      .createSync(recursive: true);
  Directory('lib/features/$featureName/data/repository')
      .createSync(recursive: true);
  Directory('lib/features/$featureName/data/source/local')
      .createSync(recursive: true);
  Directory('lib/features/$featureName/data/source/remote')
      .createSync(recursive: true);

  log('Data layer created for $featureName');
}
