import 'dart:developer';
import 'dart:io';

///[addAssetsFolder] function creates the assets folder with pngs and svgs subfolders.
Future<void> addAssetsFolder() async {
  // Create the assets/pngs and assets/svgs directories
  final pngsFolder = Directory("${Directory.current.path}/assets/pngs");
  final svgsFolder = Directory("${Directory.current.path}/assets/svgs");

  // Create the directories recursively
  pngsFolder.createSync(recursive: true);
  svgsFolder.createSync(recursive: true);

  // Output confirmation messages
  log("Assets folder with pngs and svgs subfolders created.");
}
