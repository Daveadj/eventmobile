import 'package:eventmobile/logging.dart';

class Validator {
  static String? emailValidator(String value) {
    bool emailValid =
        RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(value);
    if (value.isEmpty) {
      return 'Enter Email';
    } else if (!emailValid) {
      return 'Enter a Valid Email';
    } else {
      return null;
    }
  }

  static String? passwordValidator(String value) {
    final hasNumber = RegExp(r'[0-9]').hasMatch(value);
    final hasUppercase = RegExp(r'[A-Z]').hasMatch(value);
    final hasSpecialCharacter =
        RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value);
    if (value.isEmpty) {
      return 'Enter Password';
    } else if (value.length < 8) {
      return 'Password Length should be more than 8 characters';
    } else if (!hasNumber) {
      return 'Password must have has least one Number';
    } else if (!hasUppercase) {
      return 'Password must have has least one UpperCase Letter';
    } else if (!hasSpecialCharacter) {
      return 'Password must have has least a special character';
    } else {
      return null;
    }
  }

  static String? userNameValidator(String value) {
    if (value.isEmpty) {
      return 'Enter UserName';
    } else if (value.length < 2 || value.length > 10) {
      return 'Name Length should be between 2 to 10 characters';
    } else if (value.contains(RegExp(r'\s'))) {
      return 'Username must not contain white spaces';
    } else {
      return null;
    }
  }

  static String? nameValidator(String value) {
    if (value.isEmpty) {
      return 'Enter Name';
    } else if (value.length < 2 || value.length > 10) {
      return 'Name Length should be between 2 to 15 characters';
    } else if (value.contains(RegExp(r'\s'))) {
      return 'name must not contain white spaces';
    } else {
      return null;
    }
  }

  static String? titleValidator(
      String? value, int lessthan, int greaterthan, String label) {
    if (value!.isEmpty) {
      Log.i(value);
      return 'Enter $label';
    } else if (value.length < lessthan || value.length > greaterthan) {
      return 'Title Length should be between $lessthan to $greaterthan characters';
    } else {
      return null;
    }
  }
}
