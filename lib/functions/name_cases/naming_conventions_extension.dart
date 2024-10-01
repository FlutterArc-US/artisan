extension StringCaseConversion on String {
  // Convert to Camel Case
  String toCamelCase() {
    return this
        .trim()
        .split(' ')
        .map((word) => word.toLowerCase())
        .toList()
        .asMap()
        .map((index, word) =>
            MapEntry(index, index == 0 ? word : word.capitalizeFirst()))
        .values
        .join();
  }

  // Convert to Pascal Case
  String toPascalCase() {
    return this.trim().split(' ').map((word) => word.capitalizeFirst()).join();
  }

  // Convert to Snake Case
  String toSnakeCase() {
    return this.trim().split(' ').map((word) => word.toLowerCase()).join('_');
  }

  // Convert to Kebab Case
  String toKebabCase() {
    return this.trim().split(' ').map((word) => word.toLowerCase()).join('-');
  }

  // Convert to Flat Case (no spaces)
  String toFlatCase() {
    return this.trim().replaceAll(' ', '');
  }

  // Convert to Upper Flat Case
  String toUpperFlatCase() {
    return this.trim().replaceAll(' ', '').toUpperCase();
  }

  // Convert to Pascal Snake Case
  String toPascalSnakeCase() {
    return this
        .trim()
        .split(' ')
        .map((word) => word.capitalizeFirst())
        .join('_');
  }

  // Convert to Camel Snake Case
  String toCamelSnakeCase() {
    return this
        .trim()
        .split(' ')
        .map((word) => word.toLowerCase())
        .toList()
        .asMap()
        .map((index, word) =>
            MapEntry(index, index == 0 ? word : word.capitalizeFirst()))
        .values
        .join('_');
  }

  // Convert to Screaming Snake Case
  String toScreamingSnakeCase() {
    return this.trim().split(' ').map((word) => word.toUpperCase()).join('_');
  }

  // Convert to Train Case
  String toTrainCase() {
    return this
        .trim()
        .split(' ')
        .map((word) => word.capitalizeFirst())
        .join('-');
  }

  // Convert to Cobol Case
  String toCobolCase() {
    return this.trim().split(' ').map((word) => word.toUpperCase()).join('-');
  }

  // Helper method to capitalize the first letter of a string
  String capitalizeFirst() {
    if (this.isEmpty) return '';
    return this[0].toUpperCase() + this.substring(1);
  }
}

void printNamingConventionsStyle() {
  String text = " hello world ";

  // Example usage
  print("Camel Case: ${text.toCamelCase()}"); // helloWorld
  print("Pascal Case: ${text.toPascalCase()}"); // HelloWorld
  print("Snake Case: ${text.toSnakeCase()}"); // hello_world
  print("Kebab Case: ${text.toKebabCase()}"); // hello-world
  print("Flat Case: ${text.toFlatCase()}"); // helloWorld
  print("Upper Flat Case: ${text.toUpperFlatCase()}"); // HELLOWORLD
  print("Pascal Snake Case: ${text.toPascalSnakeCase()}"); // Hello_World
  print("Camel Snake Case: ${text.toCamelSnakeCase()}"); // hello_World
  print("Screaming Snake Case: ${text.toScreamingSnakeCase()}"); // HELLO_WORLD
  print("Train Case: ${text.toTrainCase()}"); // Hello-World
  print("Cobol Case: ${text.toCobolCase()}"); // HELLO-WORLD
}
