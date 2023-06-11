import 'package:artisan/make/make.dart';

//////*********************** Usecase File ***********************//////
String usecaseFile(String fileName, String featureName) {
  final className = convertToPascalCase(fileName);
  final file = '''
import 'package:injectable/injectable.dart';

import '../../../../infrastructure/usecase.dart';
import '../../../../infrastructure/usecase_input.dart';
import '../../../../infrastructure/usecase_output.dart';

import '../repository/${featureName}_repository.dart';

class ${className}UsecaseInput extends Input {
  ${className}UsecaseInput();
}

class ${className}UsecaseOutput extends Output {
  ${className}UsecaseOutput();
}

@lazySingleton
class ${className}Usecase extends Usecase<${className}UsecaseInput, ${className}UsecaseOutput> {
  final ${convertToPascalCase(featureName)}Repository _${convertToCamelCase(featureName)}Repository;

  ${className}Usecase({required ${convertToPascalCase(featureName)}Repository ${convertToCamelCase(featureName)}Repository})
      : _${convertToCamelCase(featureName)}Repository = ${convertToCamelCase(featureName)}Repository;

  @override
  Future<${className}UsecaseOutput> call(
      ${className}UsecaseInput input) async {
        return await _${convertToCamelCase(featureName)}Repository.${convertToCamelCase(fileName.replaceAll('_usecase', ''))}(input);
     }
}
''';

  return file;
}

//////*********************** Only Usecase File ***********************//////
String onlyUsecaseFile(String fileName, String featureName) {
  final className = convertToPascalCase(fileName);
  final file = '''
import 'package:injectable/injectable.dart';

import '../../../../infrastructure/usecase.dart';
import '../../../../infrastructure/usecase_input.dart';
import '../../../../infrastructure/usecase_output.dart';

class ${className}UsecaseInput extends Input {
  ${className}UsecaseInput();
}

class ${className}UsecaseOutput extends Output {
  ${className}UsecaseOutput();
}

@lazySingleton
class ${className}Usecase extends Usecase<${className}UsecaseInput, ${className}UsecaseOutput> {
  @override
  Future<${className}UsecaseOutput> call(
      ${className}UsecaseInput input) async {
      return ${className}UsecaseOutput();
     }
}
''';

  return file;
}
