import 'package:artisan/extensions/naming_conventions_extension.dart';

/// Generates a repository method template for the given usecase.
String newRepoMethod(String usecaseFileName, String featureName) {
  // Convert the usecase file name to PascalCase for class names
  final usecaseClassName = usecaseFileName.toPascalCase();

  // Convert the usecase file name to camelCase for method names, removing 'Usecase'
  final usecaseMethodName =
  usecaseFileName.toCamelCase().replaceAll('Usecase', '');

  // Generate the repository method with input and output comments
  return '''

  /// [${usecaseClassName}UsecaseInput] is received by the [$usecaseMethodName] method as a parameter.
  /// [${usecaseClassName}UsecaseOutput] is returned from the [$usecaseMethodName] method.
  Future<${usecaseClassName}UsecaseOutput> $usecaseMethodName(${usecaseClassName}UsecaseInput input);
''';
}
