import 'package:flutter/material.dart';

class FilterStockProvider with ChangeNotifier {
  int selectedChoiceIndex = 0;
  String selectedValue = 'Kue';
  void changeSelectedChoice(value) {
    selectedChoiceIndex = value;
    notifyListeners();
  }

  void changeSelectedValue(value) {
    selectedValue = value;
    notifyListeners();
  }
}
