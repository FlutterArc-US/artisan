import 'dart:io';

import 'package:artisan/files/analysis_options.yaml.dart';
import 'package:artisan/files/di_config_file.dart';
import 'package:artisan/files/di_file.dart';
import 'package:artisan/files/main.yaml.dart';
import 'package:artisan/files/main_file.dart';
import 'package:artisan/files/num_extension_file.dart';
import 'package:artisan/files/pubspec.yaml.dart';
import 'package:artisan/helpers/persistence_helper.dart';

import '../helpers/network_call_helper.dart';

Future<void> init() async {
  /// [Add Infrastructure]
  addInfrastructure();

  /// [Add Main]
  addMain();

  /// [Add Pubspec]
  addPubspecYaml();

  /// [Add Assets Folder]
  addAssetsFolder();

  /// [Add Analysis Options]
  addAnalysisOptions();

  /// [Add Common]
  addCommon();

  /// [Add Router]
  addRouter();

  /// [Add persistence Helper]
  addPersistenceHelper();

  /// [Add NetworkCall Helper]
  addNetworkCallHelper();

  /// [Add Di]
  addDi();

  /// [Create GitHub Workflow]
  createGitHubWorkflow();
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

//add Folder in main project with name assets
Future<void> addAssetsFolder() async {
  // Create the assets/pngs and assets/svgs directories
  final pngsFolder = Directory("${Directory.current.path}/assets/pngs");
  final svgsFolder = Directory("${Directory.current.path}/assets/svgs");

  // Create the directories recursively
  pngsFolder.createSync(recursive: true);
  svgsFolder.createSync(recursive: true);

  // Output confirmation messages
  print("Assets folder with pngs and svgs subfolders created.");
}

Future<void> addAnalysisOptions() async {
  print("Adding analysis_options.yaml");
  final analysisOptionsExisting =
      File("${Directory.current.path}/analysis_options.yaml");
  final lines = analysisOptionsExisting.readAsLinesSync();
  final contents = '${lines.first}\n$analysisOptionsFile';
  analysisOptionsExisting.writeAsStringSync(contents);
  print("Added analysis_options.yaml");
}

Future<void> addMain() async {
  final mainDart = File("${Directory.current.path}/lib/main.dart");
  mainDart.writeAsStringSync(mainFile);
  print("Added main");
}

Future<void> addCommon() async {
  final numExtension =
      File("${Directory.current.path}/lib/common/extensions/num.dart");
  numExtension.createSync(recursive: true);
  numExtension.writeAsStringSync(numExtensionContents);
  print("Num Extension Added");
}

Future<void> addRouter() async {
  final pathsFile =
      File("${Directory.current.path}/lib/util/router/paths.dart");
  final routerFile =
      File("${Directory.current.path}/lib/util/router/router.dart");

  if (!pathsFile.existsSync()) {
    pathsFile.createSync(recursive: true);
  }

  if (!routerFile.existsSync()) {
    routerFile.createSync(recursive: true);
  }

  const pathsContent = '''
class RoutePaths {
  RoutePaths._();
}
  ''';

  const routerContents = '''
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [],
);
''';

  pathsFile.writeAsStringSync(pathsContent);

  routerFile.writeAsStringSync(routerContents);
}

/// Function to create the GitHub Workflow in the .github/workflows folder.
void createGitHubWorkflow() {
  gitHubWorklowFile;

  final workflowDir = Directory('.github/workflows');
  if (!workflowDir.existsSync()) {
    workflowDir.createSync(recursive: true);
    print('.github/workflows directory created.');
  }else{
    print('.github/workflows directory already exists.');
  }

  final workflowFile = File('.github/workflows/main.yaml');
  workflowFile.writeAsStringSync(gitHubWorklowFile);
  print('GitHub workflow file created at .github/workflows/main.yaml');
}

void addDi() {
  final diFile = File("${Directory.current.path}/lib/util/di/di.dart");
  final diConfigFile =
      File("${Directory.current.path}/lib/util/di/di.config.dart");

  if (!diFile.existsSync()) {
    diFile.createSync(recursive: true);
  }

  if (!diConfigFile.existsSync()) {
    diConfigFile.createSync(recursive: true);
  }

  diFile.writeAsStringSync(diFileContent);
  diConfigFile.writeAsStringSync(diConfigFileContent);
}
