import 'dart:io';
import 'package:artisan/extensions/clickable_string_console_path.dart';
import 'package:artisan/extensions/color_print_extension.dart';
import 'package:artisan/extensions/naming_conventions_extension.dart';
import 'package:artisan/functions/features_functions/create_feature.dart';
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

    // 1. Check if the view file already exists
    if (await File(viewFilePath).exists()) {
      'Error: View file already exists:'.printBoldRed();
      viewFilePath.printClickablePath();
      return; // Abort the operation if the view file exists
    }


    if (!await featureDirectory.exists()) {
      createFeature(featureName);
      'Feature not found, creating feature: $featureName'.printBoldOrange();
    }

    // 3. Check if the route already exists before creating the view
    final routeExists = await doesRouteExist(featureName, viewName);
    if (routeExists) {
      'Error: Route for view $viewName already exists in $featureName'
          .printBoldRed();
      return; // Abort the operation if the route already exists
    }

    // 4. If all checks pass, proceed to create the view file
    final viewContent = '''
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ${viewName.toPascalCase()}View extends StatefulWidget {
  const ${viewName.toPascalCase()}View({super.key});

  @override
  State<${viewName.toPascalCase()}View> createState() => _${viewName.toPascalCase()}ViewState();
}

class _${viewName.toPascalCase()}ViewState extends State<${viewName.toPascalCase()}View> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 1.sw,
        height: 1.sh,
        color: Colors.indigoAccent,
        child: const Placeholder(),
      ),
    );
  }
}
''';

    // 5. Create the view file
    await File(viewFilePath).writeAsString(viewContent);
    'Stateful View file created successfully:'.printBoldGreen();
    viewFilePath.printClickablePath();

    // 6. Update router paths and routes after the view file is created successfully
    await updateRouterPaths(featureName, viewName);
    await updateRouterRoutes(featureName, viewName);
  } catch (e) {
    // Catch any errors that happen during the process
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
    return false; // Abort if the routes file doesn't exist
  }

  // Read the routes file to check if the route for the view already exists
  final routesContent = await routesFile.readAsString();
  final routePattern =
      "${viewName.toPascalCase()}View"; // Match by View class name

  return routesContent
      .contains(routePattern); // Returns true if the route already exists
}
