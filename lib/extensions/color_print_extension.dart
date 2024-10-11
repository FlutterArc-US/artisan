extension ColorfulPrint on String {
  // Method to print text in normal style (debug mode only)
  void printNormal() {
    assert(() {
      print(this);
      return true;
    }());
  }

  // Method to print text in bold style without color (debug mode only)
  void printBold() {
    assert(() {
      print('\x1B[1m$this\x1B[0m');
      return true;
    }());
  }

  // Method to print text in bold red (debug mode only)
  void printBoldRed() {
    assert(() {
      print('\x1B[1m\x1B[31m$this\x1B[0m');
      return true;
    }());
  }

  // Method to print text in bold green (debug mode only)
  void printBoldGreen() {
    assert(() {
      print('\x1B[1m\x1B[32m$this\x1B[0m');
      return true;
    }());
  }

  // Method to print text in bold blue (debug mode only)
  void printBoldBlue() {
    assert(() {
      print('\x1B[1m\x1B[34m$this\x1B[0m');
      return true;
    }());
  }

  // Method to print text in bold yellow (debug mode only)
  void printBoldYellow() {
    assert(() {
      print('\x1B[1m\x1B[33m$this\x1B[0m');
      return true;
    }());
  }

  // Method to print text in bold purple (debug mode only)
  void printBoldPurple() {
    assert(() {
      print('\x1B[1m\x1B[35m$this\x1B[0m');
      return true;
    }());
  }

  // Method to print text in bold cyan (debug mode only, as a substitute for indigo)
  void printBoldCyan() {
    assert(() {
      print('\x1B[1m\x1B[36m$this\x1B[0m');
      return true;
    }());
  }

  // Method to print text in bold bright yellow (debug mode only, as a substitute for orange)
  void printBoldOrange() {
    assert(() {
      print('\x1B[1m\x1B[93m$this\x1B[0m');
      return true;
    }());
  }

  // Method to print text in normal red (debug mode only)
  void printRed() {
    assert(() {
      print('\x1B[31m$this\x1B[0m');
      return true;
    }());
  }

  // Method to print text in normal green (debug mode only)
  void printGreen() {
    assert(() {
      print('\x1B[32m$this\x1B[0m');
      return true;
    }());
  }

  // Method to print text in normal blue (debug mode only)
  void printBlue() {
    assert(() {
      print('\x1B[34m$this\x1B[0m');
      return true;
    }());
  }

  // Method to print text in normal yellow (debug mode only)
  void printYellow() {
    assert(() {
      print('\x1B[33m$this\x1B[0m');
      return true;
    }());
  }

  // Method to print text in normal purple (debug mode only)
  void printPurple() {
    assert(() {
      print('\x1B[35m$this\x1B[0m');
      return true;
    }());
  }

  // Method to print text in normal cyan (debug mode only, as a substitute for indigo)
  void printCyan() {
    assert(() {
      print('\x1B[36m$this\x1B[0m');
      return true;
    }());
  }

  // Method to print text in normal bright yellow (debug mode only, as a substitute for orange)
  void printOrange() {
    assert(() {
      print('\x1B[93m$this\x1B[0m');
      return true;
    }());
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
