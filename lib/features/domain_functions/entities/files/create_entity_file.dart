import 'package:artisan/extensions/naming_conventions_extension.dart';

String createEntityFile(String entityName) {
  final entityContent = '''
class ${entityName.toPascalCase}Entity {
  final String state;
  final String postalCode;
  final String city;
  final String streetAddress;

  ${entityName}Entity({
    required this.state,
    required this.postalCode,
    required this.city,
    required this.streetAddress,
  });
}
''';
  return entityContent;
}
