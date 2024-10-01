import 'dart:io';
import 'package:artisan/extensions/color_print_extension.dart';
import 'package:artisan/files/analysis_options.dart'; // Import the file that contains your analysis options

/// Function to add or update the `analysis_options.yaml` file
Future<void> addAnalysisOptions() async {
  try {
    // Define the path for the analysis_options.yaml file
    final analysisOptionsFilePath =
        '${Directory.current.path}/analysis_options.yaml';
    final analysisOptionsFile = File(analysisOptionsFilePath);

    // Use the content from the imported file
    const newContent =
        analysisOptionsFileContent; // This should reference the defined content

    // Check if the file already exists
    if (await analysisOptionsFile.exists()) {
      // File exists, update its contents
      'File exists, updating analysis_options.yaml...'.printGreen();

      // Read the existing content
      final existingContent = await analysisOptionsFile.readAsString();

      // Append the new content to the existing content
      final updatedContent =
          '$existingContent\n$newContent'; // Modify as needed

      // Write the updated content back to the file
      analysisOptionsFile.writeAsStringSync(updatedContent);
      'File updated: analysis_options.yaml'.printGreen();
    } else {
      // File does not exist, create a new one
      'Creating new analysis_options.yaml...'.printGreen();
      await analysisOptionsFile.writeAsString(newContent);
      'File created successfully: analysis_options.yaml'.printGreen();
    }
  } catch (e) {
    // Error handling using a switch-case approach
    switch (e.runtimeType) {
      case FileSystemException:
        'Error: Unable to create or write to the file.'.printRed();
        break;
      default:
        'An unknown error occurred: $e'.printRed();
    }
  }
}
