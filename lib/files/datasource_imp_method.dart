import 'package:artisan/make/make.dart';

//////*********************** Repository File Method Imp ***********************//////
String newDatasourceMethodImp(
  String usecaseFileName,
  String featureName,
  String datasourceName,
) {
  final usecaseClassName = convertToPascalCase(usecaseFileName);
  final usecaseMethodName =
      convertToCamelCase(usecaseFileName).replaceAll('Usecase', '');

  return '''

  /// [${usecaseClassName}UsecaseInput] is received to [$usecaseMethodName] method as parameter
  /// [${usecaseClassName}UsecaseOutput] is returned from [$usecaseMethodName] method
  @override
  Future<${usecaseClassName}UsecaseOutput> $usecaseMethodName(${usecaseClassName}UsecaseInput input) async {
    throw UnimplementedError();
  }
''';
}
