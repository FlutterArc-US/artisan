import 'package:artisan/make/make.dart';

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
