import 'package:artisan/extensions/naming_conventions_extension.dart';

//////*********************** Repository File ***********************//////
String repositoryFileImp(
  String usecaseFileName,
  String featureName,
  String dataSource,
) {
  final usecaseClassName = usecaseFileName.toPascalCase();
  final usecaseMethodName =
      usecaseFileName.toCamelCase().replaceAll('Usecase', '');

  return '''
////********** START IMPORTS **********////
import '${featureName.toSnakeCase()}_repository.dart';
import 'package:injectable/injectable.dart';
import '../../data/source/${dataSource.toSnakeCase()}/${featureName.toSnakeCase()}_${dataSource.toSnakeCase()}_datasource.dart';
import '../usecases/${usecaseFileName.toSnakeCase()}.dart';
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
  /// [${usecaseClassName}UsecaseInput] is received to [$usecaseMethodName] method as parameter
  /// [${usecaseClassName}UsecaseOutput] is returned from [$usecaseMethodName] method
  @override
  Future<${usecaseClassName}UsecaseOutput> $usecaseMethodName(${usecaseClassName}UsecaseInput input) async {
    return _${featureName.toCamelCase()}${dataSource.toPascalCase()}DataSource.$usecaseMethodName(input);
  }

////********** END METHODS **********////
}
  ''';
}
