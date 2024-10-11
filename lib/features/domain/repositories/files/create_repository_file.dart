import 'package:artisan/extensions/naming_conventions_extension.dart';
import 'package:artisan/utils/functions/get_app_package_name.dart';

String repositoryFile(
    String usecaseFileName,
    String featureName,
    ) {
  final usecaseClassName = usecaseFileName.toPascalCase();
  final usecaseMethodName =
  usecaseFileName.toCamelCase().replaceAll('Usecase', '');
  final basePath = 'package:${getPackageName()}';

  return '''
////********** START IMPORTS **********////
import '$basePath/infrastructure/repository.dart';
import 'package:${getPackageName()}/features/${featureName.toSnakeCase()}/domain/usecases/${usecaseFileName.toSnakeCase()}_usecase.dart';
////********** END IMPORTS **********////

abstract class ${featureName.toPascalCase()}Repository extends Repository {
////********** START METHODS **********////
  /// [${usecaseClassName}UsecaseInput] is received to [$usecaseMethodName] method as parameter
  /// [${usecaseClassName}UsecaseOutput] is returned from [$usecaseMethodName] method
  Future<${usecaseClassName}UsecaseOutput> $usecaseMethodName(${usecaseClassName}UsecaseInput input);

////********** END METHODS **********////
}
  ''';
}
