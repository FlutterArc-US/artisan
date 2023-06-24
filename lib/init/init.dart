import 'dart:io';

import 'package:artisan/files/main_file.dart';
import 'package:artisan/files/pubspec.yaml.dart';

Future<void> init() async {
  /// [Add Infrastructure]
  addInfrastructure();

  /// [Add Common]
  addMain();

  /// [Add Pubspec]
  addPubspecYaml();
}

String getDirectory(String address) {
  var directory = Directory(address);
  if (!directory.existsSync()) {
    directory.createSync(recursive: true);
  }

  return directory.path;
}

Future<void> addInfrastructure() async {
  final infrastructure = getDirectory('lib/infrastructure');

  /// [Datasource]
  const datasource = '''abstract class DataSource {}''';
  final datasourceFile = File('$infrastructure/datasource.dart');
  datasourceFile.writeAsStringSync(datasource);

  /// [Repository]
  const repository = '''abstract class Repository {}''';
  final repositoryFile = File('$infrastructure/repository.dart');
  repositoryFile.writeAsStringSync(repository);

  /// [Usecase]
  const usecase = '''
abstract class Usecase<Input, Output> {
  Future<Output> call(Input input);
}
''';
  final usecaseFile = File('$infrastructure/usecase.dart');
  usecaseFile.writeAsStringSync(usecase);

  /// [UsecaseInput]
  const usecaseInput = '''
abstract class Input {}

class NoInput extends Input {}

''';
  final usecaseInputFile = File('$infrastructure/usecase_input.dart');
  usecaseInputFile.writeAsStringSync(usecaseInput);

  /// [Usecase Output]
  const usecaseOutput = '''abstract class Output {}''';
  final usecaseOutputFile = File('$infrastructure/usecase_output.dart');
  usecaseOutputFile.writeAsStringSync(usecaseOutput);

  print('Artisan init successfully!');
}

Future<void> addPubspecYaml() async {
  print("Adding pubspec.yaml");
  final pubspecExisting = File("${Directory.current.path}/pubspec.yaml");
  final lines = pubspecExisting.readAsLinesSync();
  final contents = '${lines.first}\n$pubspecFile';
  pubspecExisting.writeAsStringSync(contents);
  print("Added pubspec.yaml");
}

Future<void> addMain() async {
  final mainDart = File("${Directory.current.path}/lib/main.dart");
  mainDart.writeAsStringSync(mainFile);
  print("Added main");
}
