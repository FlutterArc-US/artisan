import 'package:artisan/extensions/naming_conventions_extension.dart';

String usecaseFile(String usecaseName, String featureName) {
  final className = usecaseName.toPascalCase();
  return '''
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

  ${className}Usecase({required ${featureName.toPascalCase()}Repository ${featureName.toCamelCase()}Repository})
      : _${featureName.toCamelCase()}Repository = ${featureName.toCamelCase()}Repository;

  @override
  Future<${className}UsecaseOutput> call(${className}UsecaseInput input) async {
    // Call the repository function and return the result
    return await _${featureName.toCamelCase()}Repository.${usecaseName.toCamelCase().replaceAll('_usecase', '')}(input);
  }
}
''';
}
