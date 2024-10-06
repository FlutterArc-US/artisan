import 'dart:io';

import 'package:artisan/extensions/clickable_string_console_path.dart';
import 'package:artisan/extensions/color_print_extension.dart';
import 'package:artisan/extensions/naming_conventions_extension.dart';
import 'package:artisan/features/create_feature.dart';
import 'package:artisan/features/presentation_functions/widgets/file/create_widget_file.dart';

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
      'Error: Widget File already exists: '.printBoldRed();
      widgetFilePath.printClickablePath();
      return;
    }

    var contentFile = createWidgetFile(widgetName);
    File(widgetFilePath).writeAsStringSync(contentFile);

    'Widget file created successfully: '.printBoldGreen();
    widgetFilePath.toSnakeCase().printClickablePath();
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
