extension ColorfulPrint on String {
  // Method to print in red
  void printRed() {
    print('\x1B[31m$this\x1B[0m');
  }

  // Method to print in green
  void printGreen() {
    print('\x1B[32m$this\x1B[0m');
  }

  // Method to print in yellow
  void printYellow() {
    print('\x1B[33m$this\x1B[0m');
  }

  // Method to print in blue
  void printBlue() {
    print('\x1B[34m$this\x1B[0m');
  }

  // Method to print in purple
  void printPurple() {
    print('\x1B[35m$this\x1B[0m');
  }

  // Method to print in indigo (we'll use cyan as indigo is not a direct color)
  void printIndigo() {
    print('\x1B[36m$this\x1B[0m');
  }

  // Method to print in orange (ANSI escape codes don't have a direct orange, using bright yellow as a substitute)
  void printOrange() {
    print('\x1B[93m$this\x1B[0m');  // Bright Yellow, closest to orange
  }
}
