import 'dart:io';

import 'package:artisan/make/make.dart';

Future<void> addColor(String colorName, String code) async {
  try {
    code = code.replaceAll('#', '');
    final colorFile =
        File('${Directory.current.path}/lib/util/resource/data/colors.dart');

    final newLines = <String>[];

    if (colorFile.existsSync()) {
      final lines = colorFile.readAsLinesSync();

      for (final line in lines) {
        if (line.contains('= const Color(0xFF')) {
          newLines.add(line);
        }
      }

      newLines.add(
          'final Color ${convertToPascalCase(colorName)}_FF$code = const Color(0xFF$code);');

      newLines.sort();

      final content = '''
part of r;

class _Colors{
  const _Colors();
${newLines.fold('', (previousValue, element) => '$previousValue\n\t$element')}
}
  ''';

      colorFile.writeAsStringSync(content);
      print("Color Added Successfuly");
    }
  } catch (e) {
    print('Invalid command. Color could not be added');
  }
}
