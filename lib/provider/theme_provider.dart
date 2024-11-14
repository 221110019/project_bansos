import 'package:flutter/material.dart';
import 'package:project_bansos/services/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  bool terang = false;
  SharedPreferencesServices sharedPreferencesHelper =
      SharedPreferencesServices();
  void toggleTema() {
    terang = !terang;
    sharedPreferencesHelper.save(KEY_TERANG, terang);
    notifyListeners();
  }

  void changeTerang(value) {
    terang = value;
    notifyListeners();
  }
}
