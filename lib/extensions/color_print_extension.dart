extension ColorfulPrint on String {
  // Method to print in red
  void printRed() {
    print('\x1B[31m$this\x1B[0m');
  }

  // Method to print in green
  void printGreen() {
    print('\x1B[32m$this\x1B[0m');
  }
}
