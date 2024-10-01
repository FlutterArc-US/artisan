import 'package:artisan/files/datasource_file.dart';
import 'package:artisan/functions/name_cases/conver_to_camel_case.dart';
import 'package:artisan/functions/name_cases/naming_conventions_extension.dart';
import 'package:artisan/make/make.dart';

import '../functions/name_cases/convert_to_pascal_case.dart';

//////*********************** Repository File ***********************//////
String repositoryFileImp(
  String usecaseFileName,
  String featureName,
  String dataSource,
) {
  final usecaseClassName = convertToPascalCase(usecaseFileName);
  final usecaseMethodName = usecaseFileName.toCamelCase().replaceAll('Usecase', '');

  return '''
////********** START IMPORTS **********////
import '${featureName}_repository.dart';
import 'package:injectable/injectable.dart';
import '../../data/source/$dataSource/${featureName}_${dataSource}_datasource.dart';
import '../usecases/$usecaseFileName.dart';
////********** END IMPORTS **********////

@LazySingleton(as: ${convertToPascalCase(featureName)}Repository)
class ${convertToPascalCase(featureName)}RepositoryImp implements ${convertToPascalCase(featureName)}Repository {
////********** START VARIABLES **********////
  final ${convertToPascalCase(featureName)}${convertToPascalCase(dataSource)}DataSource _${convertToCamelCase(featureName)}${convertToPascalCase(dataSource)}DataSource;
////********** END VARIABLES **********////

${convertToPascalCase(featureName)}RepositoryImp({
////********** START RECEIVE VALUES **********////
    required ${convertToPascalCase(featureName)}${convertToPascalCase(dataSource)}DataSource ${convertToCamelCase(featureName)}${convertToPascalCase(dataSource)}DataSource,
////********** END RECEIVE VALUES **********////
  })  :
////********** START SET VALUES **********////
        _${convertToCamelCase(featureName)}${convertToPascalCase(dataSource)}DataSource = ${convertToCamelCase(featureName)}${convertToPascalCase(dataSource)}DataSource
////********** END SET VALUES **********////
  ;

////********** START METHODS **********////
  /// [${usecaseClassName}UsecaseInput] is received to [$usecaseMethodName] method as parameter
  /// [${usecaseClassName}UsecaseOutput] is returned from [$usecaseMethodName] method
  @override
  Future<${usecaseClassName}UsecaseOutput> $usecaseMethodName(${usecaseClassName}UsecaseInput input) async {
    return _${convertToCamelCase(featureName)}${convertToPascalCase(dataSource)}DataSource.$usecaseMethodName(input);
  }

////********** END METHODS **********////
}
  ''';
}
