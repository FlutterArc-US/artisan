import 'dart:io';

import 'package:artisan/files/main.yaml.dart';
import 'package:artisan/init/init.dart';

void main(List<String> args) {
  if (args.isEmpty) {
    print("No command provided.");
    return;
  }

  final command = args[0];
  switch (command) {
    case 'make:feature':
      if (args.length > 1) {
        createFeature(args[1]);
      } else {
        print("Please provide a feature name.");
      }
      break;

    case 'make:workflow':
      createGitHubWorkflow();
      break;

    default:
      print("Invalid Command: $command");
  }
}

/// Function to create a feature with the specified structure.
void createFeature(String featureName) {
  print("Creating feature: $featureName");

  final featureDir = Directory('lib/features/$featureName');
  if (!featureDir.existsSync()) {
    featureDir.createSync(recursive: true);
    print('Feature folder created at lib/features/$featureName');

    createDataLayer(featureName);
    createDomainLayer(featureName);
    createPresentationLayer(featureName);

    print('Feature $featureName created successfully.');
  } else {
    print('Feature folder already exists.');
  }
}

/// Creates the data layer structure
void createDataLayer(String featureName) {
  Directory('lib/features/$featureName/data').createSync(recursive: true);
  Directory('lib/features/$featureName/data/entities').createSync(recursive: true);
  Directory('lib/features/$featureName/data/repository').createSync(recursive: true);
  Directory('lib/features/$featureName/data/source/local').createSync(recursive: true);
  Directory('lib/features/$featureName/data/source/remote').createSync(recursive: true);

  print('Data layer created for $featureName');
}

/// Creates the domain layer structure
void createDomainLayer(String featureName) {
  Directory('lib/features/$featureName/domain').createSync(recursive: true);
  Directory('lib/features/$featureName/domain/data').createSync(recursive: true);
  Directory('lib/features/$featureName/domain/models').createSync(recursive: true);
  Directory('lib/features/$featureName/domain/repository').createSync(recursive: true);
  Directory('lib/features/$featureName/domain/usecases').createSync(recursive: true);

  print('Domain layer created for $featureName');
}

/// Creates the presentation layer structure
void createPresentationLayer(String featureName) {
  Directory('lib/features/$featureName/presentation').createSync(recursive: true);
  Directory('lib/features/$featureName/presentation/providers').createSync(recursive: true);
  Directory('lib/features/$featureName/presentation/views').createSync(recursive: true);
  Directory('lib/features/$featureName/presentation/widgets').createSync(recursive: true);

  print('Presentation layer created for $featureName');
}


