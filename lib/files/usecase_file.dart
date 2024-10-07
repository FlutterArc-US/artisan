import 'package:artisan/extensions/naming_conventions_extension.dart';
import 'package:artisan/functions/name_cases/conver_to_camel_case.dart';
import 'package:artisan/functions/name_cases/convert_to_pascal_case.dart';
import 'package:artisan/make/make.dart';

//////*********************** Usecase File ***********************//////
String usecaseFile(String fileName, String featureName) {
  final className = fileName.toPascalCase;
  final file = '''
import 'package:injectable/injectable.dart';

import '../../../../infrastructure/usecase.dart';
import '../../../../infrastructure/usecase_input.dart';
import '../../../../infrastructure/usecase_output.dart';

import '../repository/${featureName.toSnakeCase()}_repository.dart';

class ${className}UsecaseInput extends Input {
  ${className}UsecaseInput();
}

class ${className}UsecaseOutput extends Output {
  ${className}UsecaseOutput();
}

@lazySingleton
class ${className}Usecase extends Usecase<${className}UsecaseInput, ${className}UsecaseOutput> {
  final ${featureName.toPascalCase()}Repository _${featureName.toCamelCase()}Repository;

  ${className}Usecase({required ${convertToPascalCase(featureName)}Repository ${convertToCamelCase(featureName)}Repository})
      : _${featureName.toCamelCase()}Repository = ${featureName.toCamelCase()}Repository;

  @override
  Future<${className}UsecaseOutput> call(
      ${className}UsecaseInput input) async {
        return await _${featureName.toCamelCase()}Repository.${(fileName.toCamelCase().replaceAll('_usecase', ''))}(input);
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
