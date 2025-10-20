import 'dart:io';

/// Reads project name from pubspec.yaml
String getPackageName() {
  try {
    final lines = File('pubspec.yaml').readAsLinesSync();
    final nameLine =
        lines.firstWhere((line) => line.trim().startsWith('name:'));
    return nameLine.split(':').last.trim();
  } catch (e) {
    throw Exception('❌ Could not read project name from pubspec.yaml: $e');
  }
}

/// Fixes relative imports and organizes them by Dart convention
String resolveImports(String content) {
  final projectName = getPackageName();

  // Convert relative imports (starting with './') into package imports
  final replaced = content.replaceAllMapped(
    RegExp(r"import '\./(.*?)';"),
    (match) => "import 'package:$projectName/${match[1]}';",
  );

  // Extract all imports
  final lines = replaced.split('\n');
  final imports = <String>[];
  final others = <String>[];

  for (final line in lines) {
    if (line.trim().startsWith('import ')) {
      imports.add(line.trim());
    } else {
      others.add(line);
    }
  }

  // Categorize imports
  final dartImports = imports.where((i) => i.contains("dart:")).toList();
  final flutterImports =
      imports.where((i) => i.contains("package:flutter")).toList();
  final externalImports = imports
      .where((i) =>
          i.contains("package:") &&
          !i.contains("package:flutter") &&
          !i.contains("package:$projectName"))
      .toList();
  final projectImports =
      imports.where((i) => i.contains("package:$projectName")).toList();

  // Sort each group alphabetically
  dartImports.sort();
  flutterImports.sort();
  externalImports.sort();
  projectImports.sort();

  // Combine all groups with proper spacing
  final organizedImports = [
    if (dartImports.isNotEmpty) ...dartImports,
    if (flutterImports.isNotEmpty) ...flutterImports,
    if (externalImports.isNotEmpty) ...externalImports,
    if (projectImports.isNotEmpty) ...projectImports,
  ].join('\n');

  final nonEmptySections = [
    if (dartImports.isNotEmpty) dartImports.join('\n'),
    if (flutterImports.isNotEmpty) flutterImports.join('\n'),
    if (externalImports.isNotEmpty) externalImports.join('\n'),
    if (projectImports.isNotEmpty) projectImports.join('\n'),
  ];

  final formattedImports = nonEmptySections.join('\n\n');

  // Replace old imports with organized ones
  final output = [
    formattedImports,
    others.where((line) => !line.trim().startsWith('import ')).join('\n')
  ].join('\n\n');

  return output.trim() + '\n';
}
