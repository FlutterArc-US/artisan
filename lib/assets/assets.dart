import 'dart:io';

import 'package:artisan/make/make.dart';

Future<void> assets() async {
  final assetPath = Directory('${Directory.current.path}/assets');

  if (assetPath.existsSync()) {
    final list = assetPath.listSync(recursive: true);

    /// [AssetTypes]
    final assetTypes = <String>[];

    for (final item in list) {
      if (!isValid(item.toString())) {
        continue;
      }

      if (item.toString().startsWith('File')) {
        final assetFileName = item.path.split('/');
        final assetType = assetFileName[assetFileName.length - 2];

        if (!assetTypes.any((element) => element == assetType)) {
          assetTypes.add(assetType);
        }
      }
    }

    /// [Register in R]
    registerAssetTypesInR(assetTypes);

    for (final type in assetTypes) {
      final typedAssets = list.where((element) {
        final namePieces = element.path.split('/');
        final typePiece = namePieces[namePieces.length - 2];

        return typePiece == type;
      }).toList();

      final writeAt =
          File("${Directory.current.path}/lib/util/resources/data/$type.dart");
      writeAt.createSync(recursive: true);

      var assetsContent = '''''';

      for (final assetContent in typedAssets) {
        assetsContent +=
            "\tfinal ${(assetContent.path.split('/').last.split('.').first.replaceAll('-', '_')).toUpperCase()} = 'assets${assetContent.path.split('assets').last}';\n";
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
}

/// [registerAssetTypesInR]
void registerAssetTypesInR(List<String> assetTypes) {
  final rFile = File("${Directory.current.path}/lib/util/resources/r.dart");

  rFile.createSync(recursive: true);
  var typesText = '''''';
  var imports = '''''';

  for (final type in assetTypes) {
    typesText +=
        "\tstatic const ${convertToCamelCase(type)} = _${convertToPascalCase(type)}();\n";

    imports += "part './data/$type.dart';\n";
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
  final fileName = filePath.split('/').last;

  if (fileName.startsWith('.') || !fileName.contains('.')) {
    return false;
  }

  return true;
}
