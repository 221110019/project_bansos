import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool terang = false;

  void toggleTema() {
    terang = !terang;
    notifyListeners();
  }
}
