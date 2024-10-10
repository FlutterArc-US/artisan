import 'package:artisan/extensions/naming_conventions_extension.dart';

String onlyUsecaseFile(String usecaseName, String featureName) {
  final className = usecaseName.toPascalCase();
  return '''
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
  Future<${className}UsecaseOutput> call(${className}UsecaseInput input) async {
    // Implement use case logic here
    return ${className}UsecaseOutput();
  }
}
''';
}
