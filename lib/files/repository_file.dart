import 'package:artisan/make/make.dart';

//////*********************** Repository File ***********************//////
String repositoryFile(
  String usecaseFileName,
  String featureName,
) {
  final usecaseClassName = convertToPascalCase(usecaseFileName);
  final usecaseMethodName =
      convertToCamelCase(usecaseFileName).replaceAll('Usecase', '');

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
