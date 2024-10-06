import 'dart:io';

import 'package:artisan/extensions/clickable_string_console_path.dart';
import 'package:artisan/extensions/color_print_extension.dart';
import 'package:artisan/extensions/naming_conventions_extension.dart';
import 'package:artisan/functions/features_functions/create_feature.dart';
import 'package:artisan/functions/features_functions/presentation_functions/providers/files/create_notifier_provider_file.dart';

Future<void> createNotifierProvider(
    String providerName, String featureName) async {
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
      'Error: Provider File already exists: '.printBoldRed();
      providerFilePath.printClickablePath();
      return;
    }

    var contentFile =
    createNotifierProviderFile(providerName, featureName);
    var file = File(providerFilePath);
    await file.writeAsString(contentFile);
    'Provider file created successfully:'.printBoldGreen();
    providerFilePath.toSnakeCase().printClickablePath();
    'Now please run build runner command to resolve errors'.printBoldPurple();
  } catch (e) {
    switch (e.runtimeType) {
      case FileSystemException:
        'Error: Unable to create or write to the provider file.'.printRed();
        break;
      default:
        'An unknown error occurred: $e'.printBoldRed();
    }
  }
}
