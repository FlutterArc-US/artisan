// import 'package:artisan/functions/create_data_source.dart';
// import 'package:artisan/functions/create_data_source_imp.dart';
// import 'package:artisan/functions/create_model.dart';
// import 'package:artisan/functions/create_usecase.dart';
//
// import 'create_repository.dart';
// import 'create_repository_imp.dart';
//
// ///[Create File]
// createFile(String makeCommand) {
//   final fileType = makeCommand.split(' ').first;
//   final file = makeCommand
//       .split(' ')
//       .map((e) => e == fileType ? '' : e)
//       .toList()
//       .reduce((value, element) => "$value $element");
//
//   if (fileType == 'model') {
//     createModel(file);
//   } else if (fileType == 'usecase') {
//     final usecaseName = file.split(' on ').first.trim();
//     final featureAndDatasource = file.split(' on ').last.trim();
//     final featureName = featureAndDatasource.split('--').first.trim();
//     final datasource = featureAndDatasource.split('--').last.trim();
//
//     createUsecase(usecaseName, featureName, featureName == datasource);
//
//     if (featureName == datasource) {
//       ///When no arguments with -- given.
//       return;
//     }
//
//     createRepository(
//       usecaseName: usecaseName,
//       featureName: featureName,
//       datasourceName: datasource,
//     );
//     createRepositoryImp(
//       usecaseName: usecaseName,
//       featureName: featureName,
//       datasourceName: datasource,
//     );
//     createDatasource(
//       usecaseName: usecaseName,
//       featureName: featureName,
//       datasourceName: datasource,
//     );
//     createDatasourceImp(
//       usecaseName: usecaseName,
//       featureName: featureName,
//       datasourceName: datasource,
//     );
//   }
// }
