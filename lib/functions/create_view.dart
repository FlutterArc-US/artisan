import 'dart:io';
import 'package:artisan/extensions/color_print_extension.dart';

Future<void> createView(String viewName, String featureName) async {
  try {
    // Determine the base path of the project dynamically
    final projectPath = Directory.current.path;

    // Define the directory for the feature correctly
    final featureDirectory =
    Directory('$projectPath/lib/features/$featureName/presentation/views');

    // Create the feature directory if it doesn't exist
    if (!await featureDirectory.exists()) {
      await featureDirectory.create(recursive: true);
      'Feature directory created: $featureName'.printGreen();
    }

    // Define the path for the new view file
    final viewFilePath = '${featureDirectory.path}/${viewName}_view.dart';

    // Check if the view file already exists
    if (await File(viewFilePath).exists()) {
      'Error: View file already exists: $viewFilePath'.printRed();
      return;
    }

    // Define the content for the view file, including the necessary imports
    final viewContent = '''
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:artisan_learning/util/router/paths.dart'; // Auto-import for paths

class ${viewName.capitalize()}View extends StatelessWidget {
  const ${viewName.capitalize()}View({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 1.sh,
      color: Colors.indigoAccent,
      child: const Placeholder(),
    );
  }
}
''';

    // Write the new view content to the file
    await File(viewFilePath).writeAsString(viewContent);
    'View file created successfully: $viewFilePath'.printGreen();

    // Check and update router paths and routes
    final routerPathsResult = await updateRouterPaths(featureName, viewName);
    final routerResult = await updateRouterRoutes(featureName, viewName);

    // Check for existing paths and routes
    if (!routerPathsResult && !routerResult) {
      'Error: Both path and route already exist for ${viewName.capitalize()}View.'.printRed();
      // Clean up the created view file if paths or routes already existed
      await File(viewFilePath).delete();
      'View file deleted: $viewFilePath'.printRed();
    }
  } catch (e) {
    // Handle errors
    switch (e.runtimeType) {
      case FileSystemException:
        'Error: Unable to create or write to the view file.'.printRed();
        break;
      default:
        'An unknown error occurred: $e'.printRed();
    }
  }
}

/// Function to update router paths
Future<bool> updateRouterPaths(String featureName, String viewName) async {
  // Define the path for paths.dart
  final pathsFile =
  File('${Directory.current.path}/lib/util/router/paths.dart');

  // Check if paths.dart file exists
  if (!await pathsFile.exists()) {
    await pathsFile.create(recursive: true);
  }

  // Read existing content
  String pathsContent = await pathsFile.readAsString();
  final newPath = "static const String ${viewName.toLowerCase()} = '/${viewName.toLowerCase()}';\n";

  // Check if the path already exists
  if (pathsContent.contains(newPath)) {
    'Error: Path already exists: ${viewName.toLowerCase()}'.printRed();
    return false; // Indicate the path already existed
  }

  // Ensure to append new paths correctly while maintaining the class structure
  pathsContent = pathsContent.replaceFirst('class RoutePaths {', 'class RoutePaths {\n  $newPath');
  await pathsFile.writeAsString(pathsContent);
  'Path added successfully: ${viewName.toLowerCase()}'.printGreen();
  return true; // Indicate the path was added
}

/// Function to update router routes
Future<bool> updateRouterRoutes(String featureName, String viewName) async {
  // Define the path for router.dart
  final routerFile =
  File('${Directory.current.path}/lib/util/router/router.dart');

  if (!await routerFile.exists()) {
    await routerFile.create(recursive: true);
  }

  // Read existing content
  String routerContent = await routerFile.readAsString();
  final routeEntry = '''
  GoRoute(
    path: RoutePaths.${viewName.toLowerCase()},
    builder: (context, state) {
      return const ${viewName.capitalize()}View();
    },
  ),
  ''';

  // Check if the route already exists
  if (routerContent.contains(routeEntry)) {
    'Error: Route already exists for: ${viewName.capitalize()}View'.printRed();
    return false; // Indicate the route already existed
  }

  // Append the new route at the end
  routerContent = routerContent.replaceFirst('routes: [', 'routes: [\n$routeEntry');
  await routerFile.writeAsString(routerContent);
  'Route added successfully: ${viewName.toLowerCase()}'.printGreen();
  return true; // Indicate the route was added
}

// Extension to capitalize the first letter of a string
extension StringCapitalization on String {
  String capitalize() => this[0].toUpperCase() + this.substring(1);
}
