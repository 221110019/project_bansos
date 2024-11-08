import 'package:flutter/material.dart';
import 'package:project_bansos/helper/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  bool terang = false;
  SharedPreferencesHelper sharedPreferencesHelper = SharedPreferencesHelper();
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
