import 'dart:io';

void main(List<String> args) {
  if (args.isEmpty) {
    print("No command provided. Use 'artisan make:feature <feature_name>' to create a feature.");
    return;
  }

  final command = args[0];
  final featureName = args.length > 1 ? args[1] : null;

  switch (command) {
    case 'make:feature':
      if (featureName != null) {
        createFeature(featureName);
      } else {
        print("Please provide a feature name.");
      }
      break;

    default:
      print("Invalid Command: $command");
  }
}

/// Function to create a feature with the specified structure.
void createFeature(String featureName) {
  print("Creating feature: $featureName");

  // Create the feature directory
  final featureDir = Directory('lib/features/$featureName');
  if (!featureDir.existsSync()) {
    featureDir.createSync(recursive: true);
    print('Feature folder created at lib/features/$featureName');

    // Create Data Layer with subfolders
    createDataLayer(featureName);

    // Create Domain Layer with subfolders
    createDomainLayer(featureName);

    // Create Presentation Layer with subfolders
    createPresentationLayer(featureName);

    print('Feature $featureName created successfully.');
  } else {
    print('Feature folder already exists.');
  }
}

/// Creates the data layer structure
void createDataLayer(String featureName) {
  final dataDir = Directory('lib/features/$featureName/data');
  dataDir.createSync(recursive: true);

  // Create entities, repository, and source folders
  Directory('lib/features/$featureName/data/entities').createSync(recursive: true);
  Directory('lib/features/$featureName/data/repository').createSync(recursive: true);
  Directory('lib/features/$featureName/data/source/local').createSync(recursive: true);
  Directory('lib/features/$featureName/data/source/remote').createSync(recursive: true);

  print('Data layer structure created for $featureName');
}

/// Creates the domain layer structure
void createDomainLayer(String featureName) {
  final domainDir = Directory('lib/features/$featureName/domain');
  domainDir.createSync(recursive: true);

  // Create data, models, repository, and usecases folders
  Directory('lib/features/$featureName/domain/data').createSync(recursive: true);
  Directory('lib/features/$featureName/domain/models').createSync(recursive: true);
  Directory('lib/features/$featureName/domain/repository').createSync(recursive: true);
  Directory('lib/features/$featureName/domain/usecases').createSync(recursive: true);

  print('Domain layer structure created for $featureName');
}

/// Creates the presentation layer structure
void createPresentationLayer(String featureName) {
  final presentationDir = Directory('lib/features/$featureName/presentation');
  presentationDir.createSync(recursive: true);

  // Create providers, views, and widgets folders
  Directory('lib/features/$featureName/presentation/providers').createSync(recursive: true);
  Directory('lib/features/$featureName/presentation/views').createSync(recursive: true);
  Directory('lib/features/$featureName/presentation/widgets').createSync(recursive: true);

  print('Presentation layer structure created for $featureName');
}
