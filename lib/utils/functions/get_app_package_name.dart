import 'dart:io';

/// Reads the project name from pubspec.yaml
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

/// Replaces relative imports (starting with ./) to package imports
String resolveImports(String content) {
  final packageName = getPackageName();
  return content.replaceAllMapped(
    RegExp(r"import '\./(.*?)';"),
    (match) => "import 'package:$packageName/${match[1]}';",
  );
}
