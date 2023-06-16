import 'dart:io';

Future<void> init() async {
  /// [Add Infrastructure]
  addInfrastructure();

  /// [Add Common]
  addCommon();
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

Future<void> addCommon() async {
  // final commonExtensions = getDirectory('lib/common/extension');
  final assetPath = Directory('${Directory.current.path}/assets');

  print(assetPath.existsSync());
}
