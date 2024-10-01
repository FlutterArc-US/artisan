import 'dart:io';

void main(List<String> args) {
  if (args.isEmpty) {
    print("No command provided. Use 'make:feature' to create a feature.");
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
    default:
      print("Invalid Command: $command");
  }
}

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
    File('lib/features/$featureName/domain/entities.dart').writeAsStringSync('// Domain entities for $featureName');
    File('lib/features/$featureName/application/usecases.dart').writeAsStringSync('// Application use cases for $featureName');
    File('lib/features/$featureName/data/repositories.dart').writeAsStringSync('// Data repositories for $featureName');
    File('lib/features/$featureName/presentation/widgets.dart').writeAsStringSync('// UI widgets for $featureName');

    print('Feature created successfully.');
  } else {
    print('Feature folder already exists.');
  }
}
