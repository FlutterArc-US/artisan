import 'package:artisan/make/make.dart';

//////*********************** Model File ***********************//////
String modelFile(String className, String fileName) {
  final file = '''
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/models/${fileName.split('.').first}/entity.dart';

part '${fileName.split('.').first}.freezed.dart';
part '${fileName.split('.').first}.g.dart';

@freezed
class ${className}Imp with _\$$className implements ${convertToPascalCase(fileName.split('.').first)} {
  const factory ${className}Imp({
  }) = _${className}Imp;

  factory ${className}Imp.fromJson(Map<String, Object?> json) => _\$${className}ImpFromJson(json);
}
  ''';

  return file;
}
