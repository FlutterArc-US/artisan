import 'dart:io';
import 'package:path/path.dart' as path;

init() async {
  String packageDirectory = path.dirname(Platform.resolvedExecutable);

  String assetsPath = path.join(packageDirectory, 'artisan');
  print(assetsPath);

  print(Directory(assetsPath).existsSync());

  String destinationPath = Directory.current.path;
  print(destinationPath);
}
