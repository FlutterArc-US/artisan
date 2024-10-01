/// [Convert to PascalCase]
String convertToPascalCase(String input) {
  var words = input.split('_');
  var result = '';

  for (final word in words) {
    result += word.trim()[0].toUpperCase() + word.trim().substring(1);
  }

  return result;
}
