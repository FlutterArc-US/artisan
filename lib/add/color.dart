import 'dart:io';

import 'package:artisan/make/make.dart';

Future<void> addColor(String colorName, String code) async {
  try {
    final colorFile =
        File('${Directory.current.path}/lib/util/resource/data/colors.dart');

    if (!colorFile.existsSync()) {
      colorFile.createSync(recursive: true);
    }

    final newLines = <String>[];

    final lines = colorFile.readAsLinesSync();

    for (final line in lines) {
      if (line.contains('= const Color(0xFF')) {
        newLines.add(line);
      }
    }

    if (newLines.any((element) => element.contains('Color(0xFF$code)'))) {
      print(
          "$code color already exists as \n ${newLines.firstWhere((element) => element.contains('Color(0xFF$code)'))}");
      return;
    }

    newLines.add(
        '\tfinal Color ${convertToCamelCase(colorName)}_FF$code = const Color(0xFF$code);');

    newLines.sort();

    final content = '''
part of r;

class _Colors{
  const _Colors();
${newLines.fold('', (previousValue, element) => '$previousValue\n$element')}
}
  ''';

    colorFile.writeAsStringSync(content);
    print("Color Added Successfuly");
  } catch (e) {
    print('Invalid command. Color could not be added');
  }
}
