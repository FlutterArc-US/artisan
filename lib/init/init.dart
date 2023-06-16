import 'dart:io';

void copyDirectory(Directory sourceDir, Directory destinationDir) {
  // Create the destination directory if it doesn't exist
  if (!destinationDir.existsSync()) {
    destinationDir.createSync(recursive: true);
  }

  // List all files and directories in the source directory
  sourceDir.listSync().forEach((FileSystemEntity entity) {
    if (entity is File) {
      // If it's a file, copy it to the destination directory
      File file = File(entity.path);
      String relativePath = file.path.replaceFirst(sourceDir.path, '');
      String destinationPath = destinationDir.path + relativePath;
      file.copySync(destinationPath);
    } else if (entity is Directory) {
      // If it's a directory, recursively copy it
      Directory subDirectory = Directory(entity.path);
      String relativePath = subDirectory.path.replaceFirst(sourceDir.path, '');
      String destinationPath = destinationDir.path + relativePath;
      copyDirectory(subDirectory, Directory(destinationPath));
    }
  });
}

void init() {
  try {
    final fromPath = '${Directory.current.path}/lib/files/init';
    print(fromPath);

    final toPath = Directory('./lib');

    print(toPath);

    copyDirectory(Directory(fromPath), toPath);
  } catch (e) {
    print(e);
  }
}
