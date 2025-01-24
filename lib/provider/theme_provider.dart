import 'package:flutter/material.dart';
import 'package:project_bansos/services/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  bool terang = false;
  String bahasaNow = 'id';
  SharedPreferencesServices sharedPreferencesServices =
      SharedPreferencesServices();
  void toggleTema() {
    terang = !terang;
    sharedPreferencesServices.save(KEY_TERANG, terang);
    notifyListeners();
  }

  void changeTerang(value) {
    terang = value;
    notifyListeners();
  }

  void gantiBahasa() {
    if (bahasaNow == 'en') {
      bahasaNow = 'id';
    } else {
      bahasaNow = 'en';
    }
    notifyListeners();
  }
}
