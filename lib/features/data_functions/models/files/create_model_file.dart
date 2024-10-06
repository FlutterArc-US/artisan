import 'package:artisan/extensions/naming_conventions_extension.dart';

String createModelFile(String modelName, String featureName) {
  final modelContent = '''
import 'package:freezed_annotation/freezed_annotation.dart';
import '../features/${featureName.toSnakeCase()}/domain/models/${modelName.toSnakeCase()}/${modelName.toSnakeCase()}_entity.dart';

part 'rest_${modelName.toSnakeCase()}_entity.freezed.dart';
part 'rest_${modelName.toSnakeCase()}_entity.g.dart';

@freezed
class Rest${modelName.toPascalCase()}Entity extends ${modelName.toPascalCase()}Entity with _\$Rest${modelName.toPascalCase()}Entity {
  const factory Rest${modelName.toPascalCase()}Entity({
    required String name,
    required int id,
  }) = _Rest${modelName.toPascalCase()}Entity;

  factory RestAddressEntity.fromJson(Map<String, Object?> json) =>
      _\$Rest${modelName.toPascalCase()}EntityFromJson(json);
}
  ''';
  return modelContent;
}
