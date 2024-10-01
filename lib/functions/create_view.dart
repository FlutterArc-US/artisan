import 'dart:io';
import 'package:artisan/extensions/color_print_extension.dart';
import 'package:artisan/functions/create_feature.dart';

/// Function to create a new view file with auto imports
Future<void> createView(String viewName, String featureName) async {
  try {
    // Determine the base path of the project dynamically
    final projectPath = Directory.current.path;

    // Define the directory for the feature
    final featureDirectory =
    Directory('$projectPath/lib/presentation/$featureName/views');

    // Create the feature directory if it doesn't exist
    if (!await featureDirectory.exists()) {
      await featureDirectory.create(recursive: true);
      'Feature directory created: $featureName'.printGreen();
    }

    // Define the path for the new view file
    final viewFilePath = '${featureDirectory.path}/${viewName}_view.dart';

    // Check if the view file already exists
    if (await File(viewFilePath).exists()) {
      'View file already exists: $viewFilePath'.printRed();
      return;
    }

    // Define the content for the view file
    final viewContent = '''
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:${getPackageName(projectPath)}/presentation/$featureName/views/${viewName}_view.dart'; 
import 'package:${getPackageName(projectPath)}/util/router/paths.dart';

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

    // Update router paths and routes
    await updateRouterPaths(featureName, viewName);
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

/// Function to extract the package name from the pubspec.yaml
String getPackageName(String projectPath) {
  final pubspecFile = File('$projectPath/pubspec.yaml');
  if (pubspecFile.existsSync()) {
    final content = pubspecFile.readAsStringSync();
    final lines = content.split('\n');
    for (var line in lines) {
      if (line.startsWith('name: ')) {
        return line.replaceAll('name: ', '').trim();
      }
    }
  }
  return 'unknown_project'; // Fallback if the package name is not found
}

/// Function to update router paths and routes
Future<void> updateRouterPaths(String featureName, String viewName) async {
  // Define the path for paths.dart
  final pathsFile =
  File('${Directory.current.path}/lib/util/router/paths.dart');

  // Check if paths.dart file exists
  if (!await pathsFile.exists()) {
    await pathsFile.create(recursive: true);
  }

  // Read existing content and append new path
  String pathsContent = await pathsFile.readAsString();
  final newPath = "static const String ${viewName.toLowerCase()} = '/$featureName/${viewName.toLowerCase()}';\n";
  if (!pathsContent.contains(newPath)) {
    pathsContent += newPath;
    await pathsFile.writeAsString(pathsContent);
    'Path added successfully: ${viewName.toLowerCase()}'.printGreen();
  }

  // Update router.dart similarly
  final routerFile =
  File('${Directory.current.path}/lib/util/router/router.dart');

  if (!await routerFile.exists()) {
    await routerFile.create(recursive: true);
  }

  String routerContent = await routerFile.readAsString();
  final routeEntry = '''
  GoRoute(
    path: RoutePaths.${viewName.toLowerCase()},
    builder: (context, state) {
      return const ${viewName.capitalize()}View();
    },
  ),
  ''';
  if (!routerContent.contains(routeEntry)) {
    routerContent = routerContent.replaceFirst('routes: [', 'routes: [\n$routeEntry');
    await routerFile.writeAsString(routerContent);
    'Route added successfully: ${viewName.toLowerCase()}'.printGreen();
  }
}

// Extension to capitalize the first letter of a string
extension StringCapitalization on String {
  String capitalize() => this[0].toUpperCase() + this.substring(1);
}
