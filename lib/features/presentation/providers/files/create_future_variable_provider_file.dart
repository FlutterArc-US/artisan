import 'package:artisan/extensions/naming_conventions_extension.dart';

String createFutureVariableProviderFile(
    String providerName, String featureName) {
  final providerContent = '''
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '${providerName.toSnakeCase()}_provider.g.dart';

@riverpod
Future<String> ${providerName.toCamelCase()}(${providerName.toPascalCase()}Ref ref) async {
  return 'Hello World';
}
''';

  return providerContent;
}
