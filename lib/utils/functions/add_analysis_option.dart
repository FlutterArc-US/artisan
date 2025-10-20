import 'dart:io';

import 'package:artisan/extensions/color_print_extension.dart';
import 'package:artisan/files/analysis_options.dart'; // Contains analysisOptionsFileContent

/// Adds or updates the `analysis_options.yaml` file safely and idempotently.
Future<void> addAnalysisOptions() async {
  const fileName = 'analysis_options.yaml';
  final filePath = '${Directory.current.path}/$fileName';
  final file = File(filePath);

  try {
    '🔍 Checking $fileName...'.printBoldBlue();

    // Ensure directory exists
    final dir = file.parent;
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
      '📁 Created directory: ${dir.path}'.printBoldGreen();
    }

    const newContent = analysisOptionsFileContent;

    // Handle file creation or update
    if (!file.existsSync()) {
      '🆕 Creating new $fileName...'.printBoldGreen();
      file.writeAsStringSync(newContent);
      '✅ $fileName created successfully.'.printBoldGreen();
    } else {
      // Compare existing content
      final currentContent = file.readAsStringSync().trim();
      if (currentContent == newContent) {
        '✅ $fileName already up to date. No changes needed.'.printBoldCyan();
      } else {
        '⚙️ Updating existing $fileName...'.printBoldYellow();
        file.writeAsStringSync(newContent);
        '✅ $fileName updated successfully.'.printBoldGreen();
      }
    }

    // Verify post-write
    if (file.existsSync()) {
      final lines = file.readAsLinesSync().length;
      '📄 Verified $fileName with $lines lines.'.printBoldBlue();
    }
  } on FileSystemException catch (e) {
    '❌ File system error: ${e.message}'.printBoldRed();
    if (e.osError?.errorCode == 13) {
      '🔒 Permission denied while accessing $fileName'.printBoldRed();
    }
  } catch (e, stack) {
    '🚨 Unexpected error in addAnalysisOptions: $e'.printBoldRed();
    'Stack Trace:\n$stack'.printRed();
  }
}
