import "dart:core";

class Validator {
  Validator._();
  static String? validateUsername(String? value) {
    if (value!.length < 2) {
      return 'Please enter a valid username';
    } else {
      return null;
    }
  }

  static String? validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp emailRegEx = RegExp(pattern);
    if (!emailRegEx.hasMatch(value!)) {
      return 'Please enter a valid email address';
    } else {
      return null;
    }
  }

  static String? notEmpty(String? value) {
    if (value!.isEmpty) {
      return "Don't leave field empty";
    } else {
      return null;
    }
  }

  static String? validateLicensePlate(String? value) {
    String pattern =
        r'^[0-9]{3,4}( )[\u0600-\u06FF]{1}( )[\u0600-\u06FF]{1}( )[\u0600-\u06FF]{0,1}';
    RegExp lpRegEx = RegExp(pattern);
    if (!lpRegEx.hasMatch(value!)) {
      return "Please enter a valid license plate";
    } else {
      return null;
    }
  }

  static String? validatePassword(String? value) {
    String password =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    /*
  r'^
  (?=.*[A-Z])       // should contain at least one upper case
  (?=.*[a-z])       // should contain at least one lower case
  (?=.*?[0-9])      // should contain at least one digit
  (?=.*?[!@#\$&*~]) // should contain at least one Special character
  .{8,}             // Must be at least 8 characters in length
$*/
    RegExp pwregex = RegExp(password);

    if (!pwregex.hasMatch(value!)) {
      return 'Please enter a valid password';
    } else {
      return null;
    }
  }
}
