import 'package:appentus_project/utils/strings.dart';

class Validations {
  static String? nameValidator(String value) {
    if (value.isEmpty) {
      return emptyNameError;
    } else if (value.length < 3) {
      return nameError;
    } else {
      return null;
    }
  }

  static String? phoneValidator(String value) {
    if (value.isEmpty) {
      return emptyPhoneError;
    } else if (value.length < 8 || value.length > 16) {
      return invalidPhoneError;
    } else {
      return null;
    }
  }


  static String? emailValidator(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty) {
      return emailError;
    } else if (!regex.hasMatch(value)) {
      return invalidEmailError;
    } else {
      return null;
    }
  }

  static String? pwdValidator(String value, {String? emptyError}) {
    if (value.isEmpty) {
      return emptyError ?? passblank;
    } else if (value.length < 8) {
      return passError;
    } else {
      return null;
    }
  }


  static String? confirmPwdValidator(String value, String pass, {String? errorMsg , String? emptyError}) {
    if (value.isEmpty) return emptyError ?? conPassError;
    if (value != pass) return errorMsg ?? confirmPassError;
    return null;
  }


  static String? emptyValidator(String value, {required String errorName}) {
    if (value.isEmpty) {
      return errorName;
    } else {
      return null;
    }
  }
}
