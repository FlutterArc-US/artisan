import 'dart:io';

import 'package:artisan/extensions/color_print_extension.dart';
import 'package:artisan/extensions/naming_conventions_extension.dart';
import 'package:artisan/functions/features_functions/create_feature.dart';

Future<void> createProvider(String providerName, String featureName) async {
  try {
    final projectPath = Directory.current.path;

    final featureDirectory = Directory(
        '$projectPath/lib/features/$featureName/presentation/providers');

    if (!await featureDirectory.exists()) {
      createFeature(featureName);
      'Feature not found, creating feature: $featureName'.printBoldOrange();
    }

    final providerFilePath =
        '${featureDirectory.path}/${providerName.toSnakeCase()}_provider.dart';

    if (await File(providerFilePath).exists()) {
      'Error: Provider File already exists: $providerFilePath'.printBoldRed();
      return;
    }

    final providerContent = '''
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '${providerName.toSnakeCase()}.g.dart';

@
''';

    await File(providerFilePath).writeAsString(providerContent);
    'Provider file created successfully: ${providerFilePath.toSnakeCase()}'
        .printBoldGreen();
  } catch (e) {
    switch (e.runtimeType) {
      case FileSystemException:
        'Error: Unable to create or write to the view file.'.printRed();
        break;
      default:
        'An unknown error occurred: $e'.printBoldRed();
    }
  }
}
