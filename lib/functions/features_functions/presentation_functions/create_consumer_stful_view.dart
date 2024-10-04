import 'dart:io';

import 'package:artisan/extensions/color_print_extension.dart';
import 'package:artisan/extensions/naming_conventions_extension.dart';
import 'package:artisan/functions/features_functions/create_feature.dart';
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
      'Error: View file already exists: $viewFilePath'.printBoldRed();
      return;
    }

    final viewContent = '''
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ${viewName.toPascalCase()}View extends ConsumerStatefulWidget {
  const ${viewName.toPascalCase()}View({super.key});

  @override
  ConsumerState createState() => _${viewName.toPascalCase()}ViewState();
}

class _${viewName.toPascalCase()}ViewState extends ConsumerState<${viewName.toPascalCase()}View> {
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
    'Stateless View file created successfully: $viewFilePath'.printBoldGreen();
    await updateRouterPaths(featureName, viewName);
    await updateRouterRoutes(featureName, viewName);
  } catch (e) {
    'An error occurred: $e'.printBoldRed();
  }
}
