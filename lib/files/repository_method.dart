import 'package:artisan/functions/name_cases/conver_to_camel_case.dart';
import 'package:artisan/functions/name_cases/convert_to_pascal_case.dart';

//////*********************** Repository File ***********************//////
String newRepoMethod(String usecaseFileName, String featureName) {
  final usecaseClassName = convertToPascalCase(usecaseFileName);
  final usecaseMethodName =
      convertToCamelCase(usecaseFileName).replaceAll('Usecase', '');

  return '''

  /// [${usecaseClassName}UsecaseInput] is received to [$usecaseMethodName] method as parameter
  /// [${usecaseClassName}UsecaseOutput] is returned from [$usecaseMethodName] method
  Future<${usecaseClassName}UsecaseOutput> $usecaseMethodName(${usecaseClassName}UsecaseInput input);
''';
}
