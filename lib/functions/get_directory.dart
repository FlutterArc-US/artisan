import 'dart:io';

String getDirectory(String address) {
  var directory = Directory(address);
  if (!directory.existsSync()) {
    directory.createSync(recursive: true);
  }

  return directory.path;
}