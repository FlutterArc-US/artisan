import 'package:artisan/extensions/naming_conventions_extension.dart';
import 'package:artisan/make/make.dart';

import '../functions/name_cases/conver_to_camel_case.dart';
import '../functions/name_cases/convert_to_pascal_case.dart';

//////*********************** Repository File Method Imp ***********************//////
String newRepoMethodImp(
  String usecaseFileName,
  String featureName,
  String datasourceName,
) {
  final usecaseClassName = usecaseFileName.toPascalCase();
  final usecaseMethodName =
      (usecaseFileName.toCamelCase()).replaceAll('Usecase', '');

  return '''

  /// [${usecaseClassName}UsecaseInput] is received to [$usecaseMethodName] method as parameter
  /// [${usecaseClassName}UsecaseOutput] is returned from [$usecaseMethodName] method
  @override
  Future<${usecaseClassName}UsecaseOutput> $usecaseMethodName(${usecaseClassName}UsecaseInput input) async {
    return _${featureName.toCamelCase()}${datasourceName.toPascalCase()}DataSource.$usecaseMethodName(input);
  }
''';
}
