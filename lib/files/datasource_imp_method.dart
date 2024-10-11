import 'package:artisan/extensions/naming_conventions_extension.dart';

//////*********************** Repository File Method Imp ***********************//////
String newDatasourceMethodImp(
  String usecaseFileName,
  String featureName,
  String datasourceName,
) {
  final usecaseClassName = usecaseFileName.toPascalCase;
  final usecaseMethodName =
      usecaseFileName.toCamelCase().replaceAll('Usecase', '');

  return '''

  /// [${usecaseClassName}UsecaseInput] is received to [$usecaseMethodName] method as parameter
  /// [${usecaseClassName}UsecaseOutput] is returned from [$usecaseMethodName] method
  /// DS Testing 7
  @override
  Future<${usecaseClassName}UsecaseOutput> $usecaseMethodName(${usecaseClassName}UsecaseInput input) async {
    throw UnimplementedError();
  }
''';
}
