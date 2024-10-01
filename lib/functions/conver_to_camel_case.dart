/// [Convert to camelCase]
String convertToCamelCase(String input) {
  var words = input.split('_');
  var result = words.first;

  for (var i = 1; i < words.length; i++) {
    result += words[i].trim()[0].toUpperCase() + words[i].trim().substring(1);
  }

  return result;
}
