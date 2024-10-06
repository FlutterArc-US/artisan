import 'dart:io';
import 'package:artisan/extensions/clickable_string_console_path.dart';
import 'package:artisan/extensions/color_print_extension.dart';
import 'package:artisan/extensions/naming_conventions_extension.dart';
import 'package:artisan/functions/features_functions/create_feature.dart';
import 'package:artisan/functions/features_functions/presentation_functions/views/files/create_stful_view_file.dart';
import 'package:artisan/functions/routes_functions/update_router_paths.dart';
import 'package:artisan/functions/routes_functions/update_router_routes.dart';

/// Function to create a new stateful view file
Future<void> createStatefulView(String viewName, String featureName) async {
  try {
    final projectPath = Directory.current.path;
    final featureDirectory =
        Directory('$projectPath/lib/features/$featureName/presentation/views');
    final viewFilePath =
        '${featureDirectory.path}/${viewName.toSnakeCase()}_view.dart';

    if (await File(viewFilePath).exists()) {
      'Error: View file already exists:'.printBoldRed();
      viewFilePath.printClickablePath();
      return;
    }

    if (!await featureDirectory.exists()) {
      createFeature(featureName);
      'Feature not found, creating feature: $featureName'.printBoldOrange();
    }

    final routeExists = await doesRouteExist(featureName, viewName);
    if (routeExists) {
      'Error: Route for view $viewName already exists in $featureName'
          .printBoldRed();
      return;
    }

    var contentFile = statefulViewFile(viewName, featureName);

    var file = File(viewFilePath);
    file.writeAsStringSync(contentFile);
    'Stateful View file created successfully:'.printBoldGreen();
    viewFilePath.printClickablePath();

    await updateRouterPaths(featureName, viewName);
    await updateRouterRoutes(featureName, viewName);
  } catch (e) {
    'An error occurred: $e'.printBoldRed();
  }
}

/// Function to check if a route already exists for the view
Future<bool> doesRouteExist(String featureName, String viewName) async {
  final projectPath = Directory.current.path;
  final routesFile = File('$projectPath/lib/util/router/routes.dart');

  // Check if the route file exists
  if (!await routesFile.exists()) {
    'Error: Routes file not found.'.printBoldRed();
    return false;
  }

  final routesContent = await routesFile.readAsString();
  final routePattern =
      "${viewName.toPascalCase()}View"; // Match by View class name

  return routesContent
      .contains(routePattern); // Returns true if the route already exists
}
