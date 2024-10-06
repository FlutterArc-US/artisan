import 'package:artisan/extensions/naming_conventions_extension.dart';

String createVariableProviderFile(String providerName, String featureName) {
  final providerContent = '''
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '${providerName.toSnakeCase()}_provider.g.dart';

@riverpod
String ${providerName.toCamelCase()}(${providerName.toPascalCase()}Ref ref) {
  return 'Hello World';
}
''';

  return providerContent;
}
