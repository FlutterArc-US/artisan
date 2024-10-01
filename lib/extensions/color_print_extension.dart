extension ColorfulPrint on String {
  // Method to print text in normal style
  void printNormal() {
    print(this);
  }

  // Method to print text in bold style without color
  void printBold() {
    print('\x1B[1m$this\x1B[0m');
  }

  // Method to print text in bold red
  void printBoldRed() {
    print('\x1B[1m\x1B[31m$this\x1B[0m');
  }

  // Method to print text in bold green
  void printBoldGreen() {
    print('\x1B[1m\x1B[32m$this\x1B[0m');
  }

  // Method to print text in bold blue
  void printBoldBlue() {
    print('\x1B[1m\x1B[34m$this\x1B[0m');
  }

  // Method to print text in bold yellow
  void printBoldYellow() {
    print('\x1B[1m\x1B[33m$this\x1B[0m');
  }

  // Method to print text in bold purple
  void printBoldPurple() {
    print('\x1B[1m\x1B[35m$this\x1B[0m');
  }

  // Method to print text in bold cyan (as a substitute for indigo)
  void printBoldCyan() {
    print('\x1B[1m\x1B[36m$this\x1B[0m');
  }

  // Method to print text in bold bright yellow (as a substitute for orange)
  void printBoldOrange() {
    print('\x1B[1m\x1B[93m$this\x1B[0m');
  }

  // Method to print text in normal red
  void printRed() {
    print('\x1B[31m$this\x1B[0m');
  }

  // Method to print text in normal green
  void printGreen() {
    print('\x1B[32m$this\x1B[0m');
  }

  // Method to print text in normal blue
  void printBlue() {
    print('\x1B[34m$this\x1B[0m');
  }

  // Method to print text in normal yellow
  void printYellow() {
    print('\x1B[33m$this\x1B[0m');
  }

  // Method to print text in normal purple
  void printPurple() {
    print('\x1B[35m$this\x1B[0m');
  }

  // Method to print text in normal cyan (as a substitute for indigo)
  void printCyan() {
    print('\x1B[36m$this\x1B[0m');
  }

  // Method to print text in normal bright yellow (as a substitute for orange)
  void printOrange() {
    print('\x1B[93m$this\x1B[0m');
  }
}

void printColorfulPrints() {
  String message = "Flutter Project with Artisan Beta initializing... Please wait...";

  // Example usage
  message.printNormal();         // Normal text
  message.printBold();           // Bold text without color
  message.printBoldRed();        // Bold Red text
  message.printBoldGreen();      // Bold Green text
  message.printBoldBlue();       // Bold Blue text
  message.printBoldYellow();     // Bold Yellow text
  message.printBoldPurple();     // Bold Purple text
  message.printBoldCyan();       // Bold Cyan text
  message.printBoldOrange();     // Bold Orange text

  message.printRed();            // Normal Red text
  message.printGreen();          // Normal Green text
  message.printBlue();           // Normal Blue text
  message.printYellow();         // Normal Yellow text
  message.printPurple();         // Normal Purple text
  message.printCyan();           // Normal Cyan text
  message.printOrange();         // Normal Orange text
}
