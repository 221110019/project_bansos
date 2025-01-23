import 'package:flutter/material.dart';

class OwnerMetaProvider extends ChangeNotifier {
  int currentIndex = 0;
  int jumlahStHabis = 0;
  int jumlahExp = 0;

  void setIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  void countStokHabis(int updateJumlah) {
    jumlahStHabis = updateJumlah;
    notifyListeners();
  }

  void countExp(int updateJumlah) {
    jumlahExp = updateJumlah;
    notifyListeners();
  }
}
