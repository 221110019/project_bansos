import 'package:project_bansos/provider/auth_provider.dart';
import 'package:project_bansos/provider/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String KEY_TERANG = "key_terang";
const String KEY_FIRSTTIME = 'key_firsttime';

class SharedPreferencesServices {
  late SharedPreferences preferences;
  void save(String key, value) async {
    preferences = await SharedPreferences.getInstance();
    switch (key) {
      case KEY_TERANG:
        await preferences.setBool(key, value);
        break;
      case KEY_FIRSTTIME:
        await preferences.setBool(key, value);
        break;
    }
    print('save');
  }

  Future<void> loadData(context) async {
    preferences = await SharedPreferences.getInstance();
    Provider.of<ThemeProvider>(context, listen: false)
        .changeTerang(preferences.getBool(KEY_TERANG) ?? false);
    Provider.of<AuthProvider>(context, listen: false)
        .changeFirstTime(preferences.getBool(KEY_FIRSTTIME) ?? true);

    print('load');
  }
}
