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

  // Helper method to capitalize the first letter of a string
  String capitalizeFirst() {
    if (this.isEmpty) return '';
    return this[0].toUpperCase() + this.substring(1);
  }
}
