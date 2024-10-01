import 'package:artisan/functions/conver_to_camel_case.dart';
import 'package:artisan/functions/convert_to_pascal_case.dart';
import 'package:artisan/make/make.dart';

//////*********************** Repository File ***********************//////
String datasourceFileImp(
  String usecaseFileName,
  String featureName,
  String dataSource,
) {
  if (dataSource == "local") {
    return _localDataSourceFileImp(
      usecaseFileName,
      featureName,
      dataSource,
    );
  } else if (dataSource == 'remote') {
    return _remoteDataSourceFileImp(
      usecaseFileName,
      featureName,
      dataSource,
    );
  }

  return '';
}

/// [REMOTE DATASOURCE IMPL]
String _remoteDataSourceFileImp(
  String usecaseFileName,
  String featureName,
  String dataSource,
) {
  final usecaseClassName = convertToPascalCase(usecaseFileName);

  return '''
////********** START IMPORTS **********////
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import '../../../../../helpers/network_call_helper/network_call_helper.dart';
import '../../../domain/usecases/$usecaseFileName.dart';
import '${featureName}_remote_datasource.dart';
////********** END IMPORTS **********////

@LazySingleton(as: ${convertToPascalCase(featureName)}${convertToPascalCase(dataSource)}DataSource)
class ${convertToPascalCase(featureName)}${convertToPascalCase(dataSource)}DataSourceImp implements ${convertToPascalCase(featureName)}${convertToPascalCase(dataSource)}DataSource {
  final Logger _logger;
  final NetworkCallHelper _networkCallHelper;

  ${convertToPascalCase(featureName)}${convertToPascalCase(dataSource)}DataSourceImp({
    required Logger logger,
    required NetworkCallHelper networkCallHelper,
  })  : _logger = logger,
        _networkCallHelper = networkCallHelper;

////********** START METHODS **********////
  @override
  Future<${usecaseClassName}UsecaseOutput> ${convertToCamelCase(usecaseFileName)}(${usecaseClassName}UsecaseInput input) {
    throw UnimplementedError();
  }

////********** END METHODS **********////
}

''';
}

/// [REMOTE DATASOURCE IMPL]
String _localDataSourceFileImp(
  String usecaseFileName,
  String featureName,
  String dataSource,
) {
  final usecaseClassName = convertToPascalCase(usecaseFileName);

  return '''
////********** AUTOGENERATED FILE: DO NOT REMOVE ANY COMMENT IN THIS STYLE **********////
////********** START IMPORTS **********////
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import '../../../../../helpers/persistence/persistence_helper.dart';
import '../../../domain/usecases/$usecaseFileName.dart';
import '${featureName}_${dataSource}_datasource.dart';
////********** END IMPORTS **********////

@LazySingleton(as: ${convertToPascalCase(featureName)}${convertToPascalCase(dataSource)}DataSource)
class ${convertToPascalCase(featureName)}${convertToPascalCase(dataSource)}DataSourceImp implements ${convertToPascalCase(featureName)}${convertToPascalCase(dataSource)}DataSource {
  final Logger _logger;
  final PersistenceHelper _persistenceHelper;

  ${convertToPascalCase(featureName)}${convertToPascalCase(dataSource)}DataSourceImp({
    required Logger logger,
    required PersistenceHelper persistenceHelper,
  })  : _logger = logger,
        _persistenceHelper = persistenceHelper;

////********** START METHODS **********////
  @override
  Future<${usecaseClassName}UsecaseOutput> ${convertToCamelCase(usecaseFileName)}(${usecaseClassName}UsecaseInput input) {
    throw UnimplementedError();
  }

////********** END METHODS **********////
}


''';
}
