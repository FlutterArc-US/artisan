import 'package:artisan/extensions/naming_conventions_extension.dart';

String datasourceFile(
    String usecaseFileName, String featureName, String datasource) {
  final usecaseClassName = usecaseFileName.toPascalCase();
  final usecaseMethodName =
      usecaseFileName.toCamelCase().replaceAll('Usecase', '');

  return '''
////********** START IMPORTS **********////
import '../../../../../infrastructure/datasource.dart';
import '../../../domain/usecases/${usecaseFileName.toSnakeCase()}_usecase.dart';
////********** END IMPORTS **********////

abstract class ${featureName.toPascalCase()}${datasource.toPascalCase()}DataSource extends DataSource {
  ////********** START METHODS **********////
  /// [${usecaseClassName}UsecaseInput] is received to [$usecaseMethodName] method as parameter
  /// [${usecaseClassName}UsecaseOutput] is returned from [$usecaseMethodName] method
  Future<${usecaseClassName}UsecaseOutput> $usecaseMethodName(${usecaseClassName}UsecaseInput input);

  ////********** END METHODS **********////
}
  ''';
}
