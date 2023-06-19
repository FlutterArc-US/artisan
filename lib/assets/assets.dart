import 'dart:io';

import 'package:artisan/make/make.dart';

Future<void> assets() async {
  final assetPath = Directory('${Directory.current.path}/assets');

  if (!assetPath.existsSync()) {
    assetPath.createSync(recursive: true);
  }

  final list = assetPath.listSync(recursive: true);

  /// [AssetTypes]
  final assetTypes = <String>[];

  for (final item in list) {
    if (!isValid(item.toString())) {
      continue;
    }

    if (item.toString().startsWith('File')) {
      final assetFileName = item.path.replaceAll('\\', '/').split('/');
      final assetType = assetFileName[assetFileName.length - 2];

      if (!assetTypes.any((element) => element == assetType)) {
        assetTypes.add(assetType);
      }
    }
  }

  /// [Register in R]
  registerAssetTypesInR(assetTypes);

  /// [Pubspec]
  registerInPubspec(list.map((e) => e.path.replaceAll('\\', '/')).toList());

  for (final type in assetTypes) {
    final typedAssets = list.where((element) {
      final namePieces = element.path.replaceAll('\\', '/').split('/');
      final typePiece = namePieces[namePieces.length - 2];

      return typePiece == type;
    }).toList();

    final writeAt =
        File("${Directory.current.path}/lib/util/resource/data/$type.dart");
    writeAt.createSync(recursive: true);

    var assetsContent = '''''';

    for (final assetContent in typedAssets) {
      assetsContent +=
          "\tfinal ${(assetContent.path.replaceAll('\\', '/').split('/').last.split('.').first.replaceAll('-', '_')).toUpperCase()} = 'assets${assetContent.path.replaceAll('\\', '/').split('assets').last}';\n";
    }

    final file = '''
part of r;

class _${convertToPascalCase(type)}{
  const _${convertToPascalCase(type)}();

$assetsContent
}
''';

    writeAt.writeAsStringSync(file);
  }
}

/// [registerAssetTypesInR]
void registerAssetTypesInR(List<String> assetTypes) {
  final rFile = File("${Directory.current.path}/lib/util/resource/r.dart");

  rFile.createSync(recursive: true);
  var typesText = '''''';
  var imports = '''''';

  /// [Colors]
  handleColorsFile();
  imports += "import 'package:flutter/material.dart';\n";
  imports += "part './data/colors.dart';\n";
  typesText += "\tstatic const colors = _Colors();\n";

  for (final type in assetTypes) {
    imports += "part './data/$type.dart';\n";

    typesText +=
        "\tstatic const ${convertToCamelCase(type)} = _${convertToPascalCase(type)}();\n";
  }

  var fileContent = '''
library r;

$imports

class R {
  R._();

$typesText
}
''';

  rFile.writeAsStringSync(fileContent);
}

bool isValid(String filePath) {
  final fileName = filePath.replaceAll('\\', '/').split('/').last;

  if (fileName.startsWith('.') || !fileName.contains('.')) {
    return false;
  }

  return true;
}

void handleColorsFile() {
  final colorFile =
      File("${Directory.current.path}/lib/util/resource/data/colors.dart");

  if (!colorFile.existsSync()) {
    colorFile.createSync(recursive: true);
    const fileContent = '''
part of r;

class _Colors{
  const _Colors();
}
''';

    colorFile.writeAsStringSync(fileContent);
  }
}

void registerInPubspec(List<String> assetFolderPaths) {
  var assetTypes = assetFolderPaths
      .map((e) => e.split('assets').last)
      .map((e) => e.split('.').first)
      .map((e) {
        final slices = e.split('/').toList();

        slices.removeLast();

        return slices.reduce((value, element) => "$value/$element");
      })
      .toSet()
      .toList();

  assetTypes.removeWhere((element) => element.isEmpty);

  assetTypes = assetTypes.map((e) => "    - assets$e/").toList();

  final pubspec = File("${Directory.current.path}/pubspec.yaml");

  var pubspecLines = pubspec.readAsLinesSync();

  if (!pubspecLines.contains("  assets:")) {
    if (pubspecLines.contains("flutter:")) {
      final flutterBlocIndex = pubspecLines.indexOf("flutter:") + 1;

      if (pubspecLines.length == flutterBlocIndex) {
        pubspecLines.add("  assets:");
      } else {
        pubspecLines.insert(flutterBlocIndex, "  assets:");
      }
    } else {
      throw Exception("No Flutter Bloc found");
    }
  }

  final indexOfAsset = pubspecLines.indexOf("  assets:") + 1;

  for (final assetType in assetTypes) {
    if (!pubspecLines.contains(assetType)) {
      pubspecLines.insert(indexOfAsset, assetType);
    }
  }

  /// [Uniqify Assets]

  final sink = pubspec.openWrite();

  for (final line in pubspecLines) {
    sink.writeln(line);
  }
  sink.close();
}
