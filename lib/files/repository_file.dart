import 'package:artisan/files/datasource_file.dart';
import 'package:artisan/functions/name_cases/conver_to_camel_case.dart';
import 'package:artisan/functions/name_cases/convert_to_pascal_case.dart';
import 'package:artisan/functions/name_cases/naming_conventions_extension.dart';


//////*********************** Repository File ***********************//////
String repositoryFile(
  String usecaseFileName,
  String featureName,
) {
  final usecaseClassName = convertToPascalCase(usecaseFileName);
  final usecaseMethodName =
      usecaseFileName.toCamelCase().replaceAll('Usecase', '');

  return '''
////********** START IMPORTS **********////
import '../../../../infrastructure/repository.dart';
import '../usecases/$usecaseFileName.dart';
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
