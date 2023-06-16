class InputValidators {
  static bool validateEmail(String value) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
    return emailValid;
  }

  static bool validatePassword(String value) {
    if (value.length < 8) {
      return false;
    }
    return true;
  }

  static bool validatePrice(String value) {
    RegExp regex = RegExp(r'^\d+(\.\d{1,2})?$');
    bool validatePrice = regex.hasMatch(value);

    return validatePrice;
  }
}
