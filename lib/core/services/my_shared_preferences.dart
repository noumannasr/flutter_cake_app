import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreference {
  static SharedPreferences? _preferences;

  static init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setIsFirstLogin(bool isFirstLogin) async {
    return await _preferences!.setBool('isFirstLogin', isFirstLogin);
  }

  static bool getIsFirstLogin() {
    return _preferences!.getBool('isFirstLogin') ?? true;
  }

  static Future<bool> setSelectedLang(String lang) async {
    return await _preferences!.setString('selectedLang', lang);
  }

  static String getLang() {
    return _preferences!.getString('selectedLang') ?? "English";
  }
}
