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
    const newContent = analysisOptionsFileContent; // Reference to the content

    // Check if the file already exists
    if (await analysisOptionsFile.exists()) {
      // File exists, overwrite its contents
      'File exists, overwriting analysis_options.yaml...'.printYellow(); // Update File

      // Overwrite the content with new content
      analysisOptionsFile.writeAsStringSync(newContent);
      'File overwritten: analysis_options.yaml'.printYellow(); // Update File
    } else {
      // File does not exist, create a new one
      'Creating new analysis_options.yaml...'.printGreen(); // Create File
      await analysisOptionsFile.writeAsString(newContent);
      'File created successfully: analysis_options.yaml'.printGreen(); // Create File
    }
  } catch (e) {
    // Error handling using Red color for errors
    switch (e.runtimeType) {
      case FileSystemException:
        'Error: Unable to create or write to the file.'.printRed(); // File System Error
        break;
      default:
        'An unknown error occurred: $e'.printRed(); // Other Errors
    }
  }
}
