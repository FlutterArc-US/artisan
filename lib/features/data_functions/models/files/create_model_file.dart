import 'dart:io';

import 'package:artisan/extensions/naming_conventions_extension.dart';

String createModelFile(String modelName, String featureName) {
  final String path = Directory.current.path;
  final modelContent = '''
import 'package:freezed_annotation/freezed_annotation.dart';
import '$path/lib/features/${featureName.toSnakeCase()}/domain/models/${modelName.toSnakeCase()}_entity.dart';

part 'rest_${modelName.toSnakeCase()}_model.freezed.dart';
part 'rest_${modelName.toSnakeCase()}_model.g.dart';

@freezed
class Rest${modelName.toPascalCase()}Entity extends ${modelName.toPascalCase()}Entity with _\$Rest${modelName.toPascalCase()}Entity {
  const factory Rest${modelName.toPascalCase()}Entity({
    required int id,
    required String name,
  }) = _Rest${modelName.toPascalCase()}Entity;

  factory RestAddressEntity.fromJson(Map<String, Object?> json) =>
      _\$Rest${modelName.toPascalCase()}EntityFromJson(json);
}
  ''';
  return modelContent;
}
