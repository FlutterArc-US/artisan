//////*********************** Model File ***********************//////
String modelFile(String className, String fileName) {
  final file = '''
import 'package:freezed_annotation/freezed_annotation.dart';

part '${fileName.split('.').first}.freezed.dart';
part '${fileName.split('.').first}.g.dart';

@freezed
class $className with _\$$className {
  const factory $className({
  }) = _$className;

  factory $className.fromJson(Map<String, Object?> json) => _\$${className}FromJson(json);
}
  ''';

  return file;
}
