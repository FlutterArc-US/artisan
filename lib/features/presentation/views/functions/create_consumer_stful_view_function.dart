import 'dart:io';

import 'package:artisan/extensions/clickable_string_console_path.dart';
import 'package:artisan/extensions/color_print_extension.dart';
import 'package:artisan/extensions/naming_conventions_extension.dart';
import 'package:artisan/features/create_feature.dart';
import 'package:artisan/features/presentation/views/files/create_consumer_stful_view_file.dart';
import 'package:artisan/functions/routes_functions/update_router_paths.dart';
import 'package:artisan/functions/routes_functions/update_router_routes.dart';

/// Function to create a new stateless view file
Future<void> createConsumerStatefulView(
    String viewName, String featureName) async {
  try {
    final projectPath = Directory.current.path;
    final featureDirectory =
        Directory('$projectPath/lib/features/$featureName/presentation/views');
    if (!await featureDirectory.exists()) {
      createFeature(featureName);
      'Feature not found, creating feature: $featureName'.printBoldOrange();
    }

    final viewFilePath =
        '${featureDirectory.path}/${viewName.toSnakeCase()}_view.dart';
    if (await File(viewFilePath).exists()) {
      'Error: View file already exists: '.printBoldRed();
      viewFilePath.printClickablePath();
      return;
    }

    var contentFile = consumerStfulViewFile(viewName, featureName);
    var file = File(viewFilePath);
    file.writeAsStringSync(contentFile);

    'Stateless View file created successfully: '.printBoldGreen();
    viewFilePath.printClickablePath();
    await updateRouterPaths(featureName, viewName);
    await updateRouterRoutes(featureName, viewName);
  } catch (e) {
    'An error occurred: $e'.printBoldRed();
  }
}
