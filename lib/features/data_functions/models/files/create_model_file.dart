import 'package:artisan/extensions/naming_conventions_extension.dart';
import 'package:artisan/functions/get_app_package_name.dart';

String createModelFile(String modelName, String featureName) {
  final modelContent = '''
import 'package:freezed_annotation/freezed_annotation.dart';
import '${getPackageName()}/lib/features/${featureName.toSnakeCase()}/domain/entities/${modelName.toSnakeCase()}_entity.dart';

part 'rest_${modelName.toSnakeCase()}_model.freezed.dart';
part 'rest_${modelName.toSnakeCase()}_model.g.dart';

@freezed
class Rest${modelName.toPascalCase()}Entity extends ${modelName.toPascalCase()}Entity with _\$Rest${modelName.toPascalCase()}Entity {
  const factory Rest${modelName.toPascalCase()}Entity({
    required int id,
    required String name,
  }) = _Rest${modelName.toPascalCase()}Entity;

  factory Rest${modelName.toPascalCase()}Entity.fromJson(Map<String, Object?> json) =>
      _\$Rest${modelName.toPascalCase()}EntityFromJson(json);
}
  ''';
  return modelContent;
}
