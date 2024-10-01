import 'dart:io';

/// Function to add or update the `analysis_options.yaml` file
Future<void> addAnalysisOptions() async {
  try {
    // Define the path for the analysis_options.yaml file
    final analysisOptionsExisting =
        File("${Directory.current.path}/analysis_options.yaml");

    // The content to be written (from analysis_options.yaml.dart)
    final lines = analysisOptionsExisting.readAsLinesSync();
    final contents = '${lines.first}\n$analysisOptionsExisting';

    // Check if the file already exists
    if (await analysisOptionsExisting.exists()) {
      // File exists, update its contents
      analysisOptionsExisting
          .writeAsStringSync(contents); // Writing the content to the file
      print('File updated: analysis_options.yaml');
    } else {
      // File does not exist, create a new one
      await analysisOptionsExisting
          .writeAsString(contents); // Creating and writing the content
      print('File created successfully: analysis_options.yaml');
    }
  } catch (e) {
    // Error handling using a switch-case approach
    switch (e.runtimeType) {
      case FileSystemException:
        print('Error: Unable to create or write to the file.');
        break;
      default:
        print('An unknown error occurred: $e');
    }
  }
}
