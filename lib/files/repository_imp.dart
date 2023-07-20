import 'package:artisan/make/make.dart';

//////*********************** Repository File ***********************//////
String repositoryFileImp(
  String usecaseFileName,
  String featureName,
  String dataSource,
) {
  final usecaseClassName = convertToPascalCase(usecaseFileName);
  final usecaseMethodName = convertToCamelCase(usecaseFileName).replaceAll('Usecase', '');

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
