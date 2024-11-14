import 'package:flutter/material.dart';
import 'package:project_bansos/services/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  bool firstTime = true;
  SharedPreferencesServices sharedPreferencesHelper =
      SharedPreferencesServices();

  void changeFirstTime(value) {
    firstTime = value;
    notifyListeners();
  }
}
