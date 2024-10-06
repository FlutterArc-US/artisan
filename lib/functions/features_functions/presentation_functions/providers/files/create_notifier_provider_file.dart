import 'package:artisan/extensions/naming_conventions_extension.dart';

String createNotifierProviderFile(String providerName, String featureName) {
  final providerContent = '''
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '${providerName.toSnakeCase()}_provider.g.dart';

@riverpod
class ${providerName.toPascalCase()} extends _\$${providerName.toPascalCase()} {
  @override
  String build() {
    return 'Hello World';
  }
}
''';

  return providerContent;
}
