import 'package:artisan/extensions/naming_conventions_extension.dart';

String createFutureNotifierProviderFile(
    String providerName, String featureName) {
  final providerContent = '''
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '${providerName.toSnakeCase()}_provider.g.dart';

@riverpod
class ${providerName.toPascalCase()} extends _\$${providerName.toPascalCase()} {
  @override
  FutureOr<String> build() async {
    return  'Hello World';
  }
}
''';

  return providerContent;
}
