import 'dart:io';

import 'package:artisan/extensions/color_print_extension.dart';
import 'package:artisan/extensions/naming_conventions_extension.dart';
import 'package:artisan/functions/features_functions/create_feature.dart';
import 'package:artisan/functions/routes_functions/update_router_paths.dart';
import 'package:artisan/functions/routes_functions/update_router_routes.dart';

/// Function to create a new stateful view file
Future<void> createStatefulView(String viewName, String featureName) async {
  try {
    final projectPath = Directory.current.path;
    final featureDirectory = Directory('$projectPath/lib/features/$featureName/presentation/views');
    if (!await featureDirectory.exists()) {
      createFeature(featureName);
      print('Feature not found, creating feature: $featureName');
    }

    final viewFilePath = '${featureDirectory.path}/${viewName.toSnakeCase()}_view.dart';
    if (await File(viewFilePath).exists()) {
      print('Error: View file already exists: $viewFilePath');
      return;
    }

    final viewContent = '''
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:artisan_learning/util/router/paths.dart'; // Auto-import for paths

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

    await File(viewFilePath).writeAsString(viewContent);
    'Stateful View file created successfully: $viewFilePath'.printBoldGreen();
    await updateRouterPaths(featureName, viewName);
    await updateRouterRoutes(featureName, viewName);
  } catch (e) {
    print('An error occurred: $e');
  }
}
