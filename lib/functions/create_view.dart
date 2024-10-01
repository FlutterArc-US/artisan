import 'dart:io';
import 'package:artisan/extensions/color_print_extension.dart';

Future<void> createView(String viewName, String featureName) async {
  try {
    // Define the path for the views directory
    final featurePath = "${Directory.current.path}/lib/presentation/${featureName}/views";
    final viewFilePath = "$featurePath/${viewName}_view.dart";

    // Create the feature directory if it doesn't exist
    final featureDir = Directory(featurePath);
    if (!featureDir.existsSync()) {
      'Creating feature directory: $featurePath'.printGreen();
      featureDir.createSync(recursive: true);
    }

    // Content for the view file
    final viewContent = '''
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

    // Create the view file
    if (!File(viewFilePath).existsSync()) {
      'Creating view file: $viewFilePath'.printGreen();
      File(viewFilePath).writeAsStringSync(viewContent);
    } else {
      'View file already exists, overwriting: $viewFilePath'.printYellow();
      File(viewFilePath).writeAsStringSync(viewContent);
    }

    // Add route to RoutePaths and router.dart
    await updateRouting(viewName, featureName);

    'View and routing created successfully for $viewName in $featureName feature.'.printBlue();
  } catch (e) {
    // Error handling with colorful prints
    switch (e.runtimeType) {
      case FileSystemException:
        'Error: Failed to create the view file or directory.'.printRed();
        break;
      default:
        'An unknown error occurred: $e'.printRed();
    }
  }
}

Future<void> updateRouting(String viewName, String featureName) async {
  // Define the paths for the router and paths files
  final routerFile = File("${Directory.current.path}/lib/util/router/router.dart");
  final pathsFile = File("${Directory.current.path}/lib/util/router/paths.dart");

  // Update RoutePaths
  if (pathsFile.existsSync()) {
    final currentPathsContent = await pathsFile.readAsString();
    if (!currentPathsContent.contains("static const String ${viewName.toLowerCase()} = '/${viewName.toLowerCase()}';")) {
      final newPathContent = "  static const String ${viewName.toLowerCase()} = '/${viewName.toLowerCase()}';\n";
      final updatedPathsContent = currentPathsContent.replaceFirst("class RoutePaths {", "class RoutePaths {\n$newPathContent");
      pathsFile.writeAsStringSync(updatedPathsContent);
      '${viewName} path added to RoutePaths.'.printGreen();
    }
  }

  // Update router file
  if (routerFile.existsSync()) {
    final currentRouterContent = await routerFile.readAsString();
    if (!currentRouterContent.contains("GoRoute(\n      path: RoutePaths.${viewName.toLowerCase()},\n      builder: (context, state) {\n        return const ${viewName.capitalize()}View();\n      },\n    ),")) {
      final newRoute = '''
    GoRoute(
      path: RoutePaths.${viewName.toLowerCase()},
      builder: (context, state) {
        return const ${viewName.capitalize()}View();
      },
    ),\n''';
      final updatedRouterContent = currentRouterContent.replaceFirst("routes: [", "routes: [\n$newRoute");
      routerFile.writeAsStringSync(updatedRouterContent);
      '${viewName} route added to router.'.printGreen();
    }
  }
}

// Extension to capitalize the first letter
extension StringCapitalization on String {
  String capitalize() => this.isEmpty ? '' : this[0].toUpperCase() + substring(1);
}
