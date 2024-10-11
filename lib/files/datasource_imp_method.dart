import 'package:artisan/extensions/naming_conventions_extension.dart';

//////*********************** Repository File Method Imp ***********************//////
String newDatasourceMethodImp(
  String usecaseFileName,
  String featureName,
  String datasourceName,
) {
  final usecaseMethodName =
      usecaseFileName.toCamelCase().replaceAll('Usecase', '');

  return '''

  /// [${usecaseFileName.toPascalCase()}UsecaseInput] is received to [$usecaseMethodName] method as parameter
  /// [${usecaseFileName.toPascalCase()}UsecaseOutput] is returned from [$usecaseMethodName] method
  /// DS Testing 7
  @override
  Future<${usecaseFileName.toPascalCase()}UsecaseOutput> $usecaseMethodName(
      ${usecaseFileName.toPascalCase()}UsecaseInput input) async {
    throw UnimplementedError();
  }
''';
}
