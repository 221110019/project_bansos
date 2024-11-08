import 'package:flutter/material.dart';
import 'package:project_bansos/provider/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String KEY_TERANG = "key_terang";

class SharedPreferencesHelper {
  late SharedPreferences preferences;
  void save(String key, value) async {
    preferences = await SharedPreferences.getInstance();
    switch (key) {
      case KEY_TERANG:
        await preferences.setBool(key, value);
        break;
      // case KEY_TOPRIGHT:
      //   await preferences.setDouble(KEY_TOPRIGHT, topRight);
      //   break;
      // case KEY_BOTTOMLEFT:
      //   await preferences.setDouble(KEY_BOTTOMLEFT, bottomLeft);
      //   break;
      // case KEY_BOTTOMRIGHT:
      //   await preferences.setDouble(KEY_BOTTOMRIGHT, bottomRight);
      //   break;
    }
    print('save');
  }

  Future<void> loadData(context) async {
    preferences = await SharedPreferences.getInstance();
    Provider.of<ThemeProvider>(context, listen: false)
        .changeTerang(preferences.getBool(KEY_TERANG) ?? false);
    print('load');
  }
}
