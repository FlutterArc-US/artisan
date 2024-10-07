import 'package:artisan/files/datasource_file.dart';
import 'package:artisan/functions/get_app_package_name.dart';
import 'package:artisan/functions/name_cases/conver_to_camel_case.dart';
import 'package:artisan/functions/name_cases/convert_to_pascal_case.dart';
import 'package:artisan/extensions/naming_conventions_extension.dart';

//////*********************** Repository File ***********************//////
String repositoryFile(
  String usecaseFileName,
  String featureName,
) {
  final usecaseClassName = usecaseFileName.toPascalCase();
  final usecaseMethodName =
      usecaseFileName.toCamelCase().replaceAll('Usecase', '');

  return '''
////********** START IMPORTS **********////
import 'package:${getPackageName()}/infrastructure/repository.dart';
import 'package:${getPackageName()}/features/${featureName.toSnakeCase()}/domain/usecases/${usecaseFileName.toSnakeCase()}.dart';
////********** END IMPORTS **********////

abstract class ${convertToPascalCase(featureName)}Repository extends Repository {
////********** START METHODS **********////
  /// [${usecaseClassName}UsecaseInput] is received to [$usecaseMethodName] method as parameter
  /// [${usecaseClassName}UsecaseOutput] is returned from [$usecaseMethodName] method
  Future<${usecaseClassName}UsecaseOutput> $usecaseMethodName(${usecaseClassName}UsecaseInput input);

////********** END METHODS **********////
}
  ''';
}
