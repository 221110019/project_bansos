import 'package:flutter/foundation.dart';

class RegisterProvider extends ChangeNotifier {
  String? emailError = null;
  String? passwordError = null;
  String? confirmPasswordError = null;
  void changeEmailError(value) {
    emailError = value;
    notifyListeners();
  }

  void changePasswordError(value) {
    passwordError = value;
    notifyListeners();
  }

  void changeConfirmPassword(value) {
    confirmPasswordError = value;
    notifyListeners();
  }

  void resetError() {
    emailError = null;
    passwordError = null;
    confirmPasswordError = null;
    notifyListeners();
  }
}
