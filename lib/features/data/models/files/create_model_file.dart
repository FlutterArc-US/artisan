import 'package:artisan/extensions/naming_conventions_extension.dart';
import 'package:artisan/utils/functions/get_app_package_name.dart';

String createModelFile(String modelName, String featureName) {
  final modelContent = '''
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:${getPackageName()}/features/${featureName.toSnakeCase()}/domain/entities/${modelName.toSnakeCase()}/${modelName.toSnakeCase()}_entity.dart';

part 'rest_${modelName.toSnakeCase()}_model.freezed.dart';
part 'rest_${modelName.toSnakeCase()}_model.g.dart';

@freezed
class Rest${modelName.toPascalCase()}Model extends ${modelName.toPascalCase()}Entity with _\$Rest${modelName.toPascalCase()}Model {
  const factory Rest${modelName.toPascalCase()}Model({
    required int id,
    required String name,
  }) = _Rest${modelName.toPascalCase()}Model;

  factory Rest${modelName.toPascalCase()}Model.fromJson(Map<String, Object?> json) =>
      _\$Rest${modelName.toPascalCase()}ModelFromJson(json);
}
  ''';
  return modelContent;
}
