import 'package:shared_preferences/shared_preferences.dart';

class UserPrefs {
  static const darkModeKey = 'DarkMode';
  static final UserPrefs _instance = UserPrefs._();

  factory UserPrefs() {
    return _instance;
  }

  UserPrefs._();

  SharedPreferences? _prefs;

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  bool get darkMode {
    return _prefs!.getBool(darkModeKey) ?? true;
  }

  set darkMode(bool value) {
    _prefs!.setBool(darkModeKey, value);
  }
}
