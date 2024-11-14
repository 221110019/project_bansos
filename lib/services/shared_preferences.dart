import 'package:project_bansos/provider/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String KEY_TERANG = "key_terang";

class SharedPreferencesServices {
  late SharedPreferences preferences;
  void save(String key, value) async {
    preferences = await SharedPreferences.getInstance();
    switch (key) {
      case KEY_TERANG:
        await preferences.setBool(key, value);
        break;
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
