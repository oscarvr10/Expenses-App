import 'package:shared_preferences/shared_preferences.dart';

class UserPrefs {
  static const darkModeKey = 'DarkMode';
  static const hourKey = 'NotifHour';
  static const minuteKey = 'NotifMinute';
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

  int get hour {
    return _prefs!.getInt(hourKey) ?? 99;
  }

  set hour(int value) {
    _prefs!.setInt(hourKey, value);
  }

  int get minute {
    return _prefs!.getInt(minuteKey) ?? 99;
  }

  set minute(int value) {
    _prefs!.setInt(minuteKey, value);
  }

  deleteTime() {
    _prefs!.remove(hourKey);
    _prefs!.remove(minuteKey);
  }
}
