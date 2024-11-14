import 'package:flutter/foundation.dart';

class LoginProvider extends ChangeNotifier {
  String? emailError = null;
  String? passwordError = null;

  void changeEmailError(value) {
    emailError = value;
    notifyListeners();
  }

  void changePasswordError(value) {
    passwordError = value;
    notifyListeners();
  }

  void resetError() {
    emailError = null;
    passwordError = null;
    notifyListeners();
  }
}
