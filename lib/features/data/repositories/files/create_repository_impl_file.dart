import 'package:artisan/extensions/naming_conventions_extension.dart';
import 'package:artisan/utils/functions/get_app_package_name.dart';

//////*********************** Repository File ***********************//////
String repositoryFileImp(
    String usecaseFileName,
    String featureName,
    String dataSource,
    ) {
  final usecaseClassName = usecaseFileName.toPascalCase();
  final usecaseMethodName =
  usecaseFileName.toCamelCase().replaceAll('Usecase', '');
  final basePath = 'package:${getPackageName()}';
  final featurePath = '$basePath/features/${featureName.toSnakeCase()}';

  return '''
////********** START IMPORTS **********////
import '$featurePath/domain/repository/${featureName.toSnakeCase()}_repository.dart';
import 'package:injectable/injectable.dart';
import '$basePath/features/${featureName.toSnakeCase()}/data/source/${dataSource.toSnakeCase()}/${featureName.toSnakeCase()}_${dataSource.toSnakeCase()}_datasource.dart';
import '$featurePath/domain/usecases/${usecaseFileName.toSnakeCase()}_usecase.dart';
////********** END IMPORTS **********////

@LazySingleton(as: ${featureName.toPascalCase()}Repository)
class ${featureName.toPascalCase()}RepositoryImp implements ${featureName.toPascalCase()}Repository {
////********** START VARIABLES **********////
  final ${featureName.toPascalCase()}${dataSource.toPascalCase()}DataSource _${featureName.toCamelCase()}${dataSource.toPascalCase()}DataSource;
////********** END VARIABLES **********////

${featureName.toPascalCase()}RepositoryImp({
////********** START RECEIVE VALUES **********////
    required ${featureName.toPascalCase()}${dataSource.toPascalCase()}DataSource ${featureName.toCamelCase()}${dataSource.toPascalCase()}DataSource,
////********** END RECEIVE VALUES **********////
  })  :
////********** START SET VALUES **********////
        _${featureName.toCamelCase()}${dataSource.toPascalCase()}DataSource = ${featureName.toCamelCase()}${dataSource.toPascalCase()}DataSource
////********** END SET VALUES **********////
  ;

////********** START METHODS **********////
$newRepoMethodImp(usecaseFileName, featureName, dataSource)
////********** END METHODS **********////
}
''';
}

/// Generates the implementation of the new repository method.
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
