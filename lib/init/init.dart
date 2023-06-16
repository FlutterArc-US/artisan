import 'dart:io';
import 'package:path/path.dart' as path;

init() async {
  String packageDirectory = path.dirname(Platform.resolvedExecutable);

  String assetsPath = path.join(packageDirectory, 'lib');
  print(assetsPath);

  String destinationPath = Directory.current.path;
  print(destinationPath);
}
