import 'package:artisan/extensions/naming_conventions_extension.dart';

String createEntityFile(String entityName) {
  final entityContent = '''
class ${entityName.toPascalCase()}Entity {
  final int id;
  final String name;

  ${entityName.toPascalCase()}Entity({
    required this.id,
    required this.name,
  });
}
''';
  return entityContent;
}
