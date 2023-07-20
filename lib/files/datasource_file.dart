import 'package:artisan/make/make.dart';

//////*********************** Repository File ***********************//////
String datasourceFile(String usecaseFileName, String featureName, String datasource) {
  final usecaseClassName = convertToPascalCase(usecaseFileName);
  final usecaseMethodName = convertToCamelCase(usecaseFileName).replaceAll('Usecase', '');

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
