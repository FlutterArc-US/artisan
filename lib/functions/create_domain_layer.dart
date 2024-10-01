import 'dart:developer';
import 'dart:io';

/// Creates the domain layer structure
void createDomainLayer(String featureName) {
  Directory('lib/features/$featureName/domain').createSync(recursive: true);
  Directory('lib/features/$featureName/domain/data')
      .createSync(recursive: true);
  Directory('lib/features/$featureName/domain/models')
      .createSync(recursive: true);
  Directory('lib/features/$featureName/domain/repository')
      .createSync(recursive: true);
  Directory('lib/features/$featureName/domain/usecases')
      .createSync(recursive: true);

  log('Domain layer created for $featureName');
}
