import 'dart:io';

String getPackageName() {
  final name = File('pubspec.yaml')
      .readAsLinesSync()
      .firstWhere((element) => element.contains('name:'))
      .split(':')
      .last
      .trim();
  return name;
}
