import "dart:core";

class Validator {
  String? validateEmail(value) {
    String pattern = r'^[a-zA-Z0-9.]+@([a-ZA-Z0-9]+\.+[a-zA-Z]+';
    RegExp emailRegEx = RegExp(pattern);
    if (!emailRegEx.hasMatch(value)) {
      return 'Please enter a valid email address';
    } else {
      return '';
    }
  }

  String? validateLicensePlate(String value) {
    String pattern =
        r'^[0-9]{3,4}( )[\u0600-\u06FF]{1}( )[\u0600-\u06FF]{1}( )[\u0600-\u06FF]{0,1}';
    RegExp lpRegEx = RegExp(pattern);
    if (!lpRegEx.hasMatch(value)) {
      return "Invalid license plate";
    } else {
      return '';
    }
  }

  String? validateCreditCard(String value) {
    String visaCard = r'^4[0-9]{12}(?:[0-9]{3})?$';
    String masterCard =
        r'^(5[1-5][0-9]{14}|2(22[1-9][0-9]{12}|2[3-9][0-9]{13}|[3-6][0-9]{14}|7[0-1][0-9]{13}|720[0-9]{12}))$';
    RegExp vCard = RegExp(visaCard);
    RegExp mCard = RegExp(masterCard);
    if (!(vCard.hasMatch(value) || mCard.hasMatch(value))) {
      return "Invalid card number";
    } else {
      return '';
    }
  }
}
