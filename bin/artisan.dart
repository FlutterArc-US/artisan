import 'dart:io';

void main(List<String> args) {
  if (args.isEmpty) {
    print("No command provided. Use 'artisan make:feature <feature_name>' to create a feature.");
    return;
  }

  final command = args[0];
  final name = args.length > 1 ? args[1] : null;

  switch (command) {
    case 'make:feature':
      if (name != null) {
        createFeature(name);
      } else {
        print("Please provide a feature name.");
      }
      break;

    case 'make:usecase':
      if (name != null) {
        if (args.length > 2) {
          createUseCase(name, args[2]);
        } else {
          print("Please provide a use case name.");
        }
      } else {
        print("Please provide a feature name.");
      }
      break;

    default:
      print("Invalid Command: $command");
  }
}

/// Function to create a feature with domain, application, data, and presentation layers.
void createFeature(String featureName) {
  print("Creating feature: $featureName");

  // Create folder structure for the feature
  final featureDir = Directory('lib/features/$featureName');
  if (!featureDir.existsSync()) {
    featureDir.createSync(recursive: true);
    print('Feature folder created at lib/features/$featureName');

    // Create Domain Layer
    final domainDir = Directory('lib/features/$featureName/domain');
    domainDir.createSync();
    print('Domain folder created');

    // Create Application Layer (Use Cases)
    final usecaseDir = Directory('lib/features/$featureName/application');
    usecaseDir.createSync();
    print('Application (Use Case) folder created');

    // Create Data Layer
    final dataDir = Directory('lib/features/$featureName/data');
    dataDir.createSync();
    print('Data folder created');

    // Create Presentation Layer
    final presentationDir = Directory('lib/features/$featureName/presentation');
    presentationDir.createSync();
    print('Presentation folder created');

    // Create Placeholder Files
    File('lib/features/$featureName/domain/entities.dart')
        .writeAsStringSync('// Domain entities for $featureName');
    File('lib/features/$featureName/application/usecases.dart')
        .writeAsStringSync('// Application use cases for $featureName');
    File('lib/features/$featureName/data/repositories.dart')
        .writeAsStringSync('// Data repositories for $featureName');
    File('lib/features/$featureName/presentation/widgets.dart')
        .writeAsStringSync('// UI widgets for $featureName');

    print('Feature created successfully.');
  } else {
    print('Feature folder already exists.');
  }
}

/// Function to create a use case within a feature.
void createUseCase(String featureName, String useCaseName) {
  final usecaseDir = Directory('lib/features/$featureName/application');
  if (!usecaseDir.existsSync()) {
    print('Feature $featureName does not exist.');
    return;
  }

  final usecaseFile =
  File('lib/features/$featureName/application/${useCaseName}_usecase.dart');
  usecaseFile.writeAsStringSync('''
class ${useCaseName.capitalize()}UseCase {
  // Add logic for $useCaseName use case
}
''');

  print('$useCaseName use case created.');
}

/// Extension to capitalize the first letter of the use case name.
extension StringExtension on String {
  String capitalize() {
    return this[0].toUpperCase() + substring(1);
  }
}
