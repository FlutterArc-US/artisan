import 'dart:io';

import 'package:artisan/extensions/color_print_extension.dart';
import 'package:artisan/functions/create_view.dart';
import 'package:artisan/functions/name_cases/name_cases_extension.dart';

/// Function to update router routes
Future<bool> updateRouterRoutes(String featureName, String viewName) async {
  // Define the path for router.dart
  final routerFile =
      File('${Directory.current.path}/lib/util/router/router.dart');

  // Create the router file if it doesn't exist
  if (!await routerFile.exists()) {
    await routerFile.create(recursive: true);
  }

  // Read existing content
  String routerContent = await routerFile.readAsString();

  // Define the import statement for the new view file
  final viewFileImport =
      "import 'package:${Directory.current.path.split(Platform.pathSeparator).last}/features/$featureName/presentation/views/${viewName.toLowerCase()}_view.dart';";

  // Check if the import statement already exists
  if (!routerContent.contains(viewFileImport)) {
    // Add the new import statement at the top if it doesn't exist
    routerContent = '$viewFileImport\n\n$routerContent';
  }

  // Define the new route entry
  final routeEntry = '''
  GoRoute(
    path: RoutePaths.${viewName.toLowerCase()},
    builder: (context, state) {
      return const ${viewName.toPascalCase()}View();
    },
  ),
  ''';

  // Check if the route already exists
  if (routerContent.contains(routeEntry)) {
    'Error: Route already exists for: ${viewName.toPascalCase()}View'
        .printRed();
    return false; // Indicate the route already existed
  }

  // Append the new route entry at the end of the routes list
  routerContent =
      routerContent.replaceFirst('routes: [', 'routes: [\n$routeEntry');

  // Write the updated content back to the router file
  await routerFile.writeAsString(routerContent);
  'Route added successfully: ${viewName.toLowerCase()}'.printGreen();
  return true; // Indicate the route was added
}
