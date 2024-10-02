import 'dart:io';

import 'package:artisan/extensions/color_print_extension.dart';
import 'package:artisan/extensions/naming_conventions_extension.dart';
import 'package:artisan/functions/features_functions/create_feature.dart';

Future<void> createWidget(String widgetName, String featureName) async {
  try {
    final projectPath = Directory.current.path;

    final featureDirectory = Directory(
        '$projectPath/lib/features/$featureName/presentation/widgets');

    if (!await featureDirectory.exists()) {
      createFeature(featureName);
      'Feature not found, creating feature: $featureName'.printBoldOrange();
    }

    final widgetFilePath =
        '${featureDirectory.path}/${widgetName.toSnakeCase()}_widget.dart';

    if (await File(widgetFilePath).exists()) {
      'Error: Widget File already exists: $widgetFilePath'.printBoldRed();
      return;
    }

    final widgetContent = '''
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ${widgetName.toPascalCase()}Widget extends StatelessWidget {
  const ${widgetName.toPascalCase()}Widget({super.key});
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

    await File(widgetFilePath).writeAsString(widgetContent);
    'Widget file created successfully: ${widgetFilePath.toSnakeCase()}'
        .printBoldGreen();
  } catch (e) {
    switch (e.runtimeType) {
      case FileSystemException:
        'Error: Unable to create or write to the view file.'.printRed();
        break;
      default:
        'An unknown error occurred: $e'.printBoldRed();
    }
  }
}
