class Validators {
  static final Validators validate = Validators();

  static final List<RegExp> _phoneNumberRegExp = [
    RegExp(r"([9][8][46][0-9]{7})"),
    RegExp(r"([9][8][0-2][0-9]{7})"),
    RegExp(r"([9][6][0-9]{8}|[9][8][8][0-9]{7})"),
    RegExp(r"([9][8][5][0-9]{7})"),
    RegExp(r"([9][7][4-5][0-9]{7})"),
  ];

  /// Method created for email validation
  String? validateEmail(String? value) {
    // Created pattern to match with emailid pattern
    // Using the regular expression https://www.codegrepper.com/code-examples/dart/dart+regex+for+email

    RegExp regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    // Matching the user Email id with regexp pattern
    if (value == null || value.trim().isEmpty) {
      return "Please enter email.";
    }
    // If e-mail textform field havenot any input
    else if (!regExp.hasMatch(value)) {
      return "Please enter valid email.";
    }

    return null;
  }

  /// Method created for password validation
  static String? validatePassword(String? value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);

    if (value == null || value.isEmpty) {
      return "Password required.";
    }
    // Checking  ifthe password less than 6 character
    else if (!regExp.hasMatch(value)) {
      return "Password must contain 1 digit, 1 lower-case, 1 upper-case, 1 special character and must be atleat 8 character long.";
    }

    return null;
  }

  static String? validateConfirmPassword(String? confirm, String password) {
    // Checking the password is empty or not
    if (confirm == null) {
      return "Please re-enter the password.";
    }

    if (confirm != password) {
      return "Passwords do not match";
    }
    return null;
  }

  /// Method created for Phone validation
  static String? validatePhoneNumber(String? phoneNumber) {
    // Checking if the phone is empty

    if (phoneNumber == null) {
      return "Phone number can not be blank.";
    }

    if (phoneNumber.trim().isEmpty) {
      return "Enter phone number.";
    }
    // Matching Regular expression for phone number using khalti phonenumber regular exp
    for (RegExp regEx in _phoneNumberRegExp) {
      if (regEx.hasMatch(phoneNumber)) {
        return null;
      }
    }

    return "Invalid phone number.";
  }

  static String? validateFullName(String? fullName) {
    // Checking whether the fullName is empty
    if (fullName == null) {
      return "Please enter your name";
    }

    if (fullName.trim().isEmpty) {
      return "Enter your name.";
    }
    // Matching the regular expression for full name by https://stackoverflow.com/a/35458020
    RegExp regExp = RegExp(r"^[a-zA-Z]{3,}(?: [a-zA-Z]+){0,2}$");
    if (!regExp.hasMatch(fullName)) {
      return "Enter valid Name.";
    }

    return null;
  }
}
