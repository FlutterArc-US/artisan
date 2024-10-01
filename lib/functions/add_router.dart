import 'dart:io';
import 'package:artisan/extensions/color_print_extension.dart';

/// Function to create or update router files in the project
Future<void> addRouter() async {
  try {
    // Define paths for the router files
    final pathsFile = File("${Directory.current.path}/lib/util/router/paths.dart");
    final routerFile = File("${Directory.current.path}/lib/util/router/router.dart");

    // Content for the paths.dart file
    const pathsContent = '''
class RoutePaths {
  RoutePaths._();
}
  ''';

    // Content for the router.dart file
    const routerContents = '''
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [],
);
''';

    // Create or update paths.dart
    if (!pathsFile.existsSync()) {
      'Creating paths.dart file...'.printGreen(); // Create File
      pathsFile.createSync(recursive: true);
    } else {
      'paths.dart file already exists, overwriting...'.printYellow(); // Update File
    }
    pathsFile.writeAsStringSync(pathsContent);

    // Create or update router.dart
    if (!routerFile.existsSync()) {
      'Creating router.dart file...'.printGreen(); // Create File
      routerFile.createSync(recursive: true);
    } else {
      'router.dart file already exists, overwriting...'.printYellow(); // Update File
    }
    routerFile.writeAsStringSync(routerContents);

    'Router files created/updated successfully.'.printBlue(); // Success message for file operations
  } catch (e) {
    // Error handling with colorful prints
    switch (e.runtimeType) {
      case FileSystemException:
        'Error: Failed to create or write to the router files.'.printRed(); // File system error
        break;
      default:
        'An unknown error occurred: $e'.printRed(); // Unknown error
    }
  }
}
