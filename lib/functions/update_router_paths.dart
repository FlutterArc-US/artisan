import 'dart:io';

import 'package:artisan/extensions/color_print_extension.dart';

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
