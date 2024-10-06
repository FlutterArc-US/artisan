String createEntityFile(String entityName) {
  final entityContent = '''
class ${entityName}Entity {
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
