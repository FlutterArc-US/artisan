import 'dart:io';

import 'package:artisan/assets/assets.dart';
import 'package:artisan/make/make.dart';

Future<void> addColor(String colorName, String code) async {
  final colorFile =
  File('${Directory.current.path}/lib/util/resource/colors.dart');

  final newLines = [];

  if (colorFile.existsSync()) {
    final lines = colorFile.readAsLinesSync();

    for (final line in lines) {
      if (line.contains('= const Color(0xFF')) {
        newLines.add(line);
      }
    }

    newLines.add(
        'final Color ${convertToPascalCase(
            colorName)}_FF$code = const Color(0xFF$code);');

    newLines.sort();

    final content = '''
part of r;

  class _Colors{
  const _Colors();
  $newLines
  }
  ''';

    colorFile.writeAsStringSync(content);
  }
}
