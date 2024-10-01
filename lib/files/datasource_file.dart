import 'package:artisan/functions/create_repository_imp.dart';
import 'package:artisan/functions/name_cases/conver_to_camel_case.dart';
import 'package:artisan/functions/name_cases/convert_to_pascal_case.dart';
import 'package:artisan/functions/name_cases/naming_conventions_extension.dart';
import 'package:artisan/make/make.dart';

//////*********************** Repository File ***********************//////
String datasourceFile(
    String usecaseFileName, String featureName, String datasource) {
  final usecaseClassName = usecaseFileName.toPascalCase();
  final usecaseMethodName =
      usecaseFileName.toCamelCase().replaceAll('Usecase', '');

  return '''
////********** START IMPORTS **********////
import '../../../../../infrastructure/datasource.dart';
import '../../../domain/usecases/$usecaseFileName.dart';
////********** END IMPORTS **********////

abstract class ${convertToPascalCase(featureName)}${convertToPascalCase(datasource)}DataSource extends DataSource {
  ////********** START METHODS **********////
  /// [${usecaseClassName}UsecaseInput] is received to [$usecaseMethodName] method as parameter
  /// [${usecaseClassName}UsecaseOutput] is returned from [$usecaseMethodName] method
  Future<${usecaseClassName}UsecaseOutput> $usecaseMethodName(${usecaseClassName}UsecaseInput input);

////********** END METHODS **********////
}
  ''';
}
