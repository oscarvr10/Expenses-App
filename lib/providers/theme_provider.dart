import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData? _selectedTheme;

  ThemeData dark = ThemeData.dark().copyWith(
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[900],
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Colors.green,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.lightGreen,
      foregroundColor: Colors.white,
    ),
    colorScheme: const ColorScheme.dark(
      primary: Colors.green,
    ),
    scaffoldBackgroundColor: Colors.grey[900],
    primaryColorDark: Colors.grey[800],
    dividerColor: Colors.grey,
  );

  ThemeData light = ThemeData.light().copyWith(
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[200],
      foregroundColor: Colors.black,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.grey[300],
      selectedItemColor: Colors.green,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.grey[300],
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.lightGreen,
      foregroundColor: Colors.white,
    ),
    scaffoldBackgroundColor: Colors.grey[200],
    primaryColorDark: Colors.grey[300],
    dividerColor: Colors.black,
  );

  ThemeProvider(bool darkMode) {
    _selectedTheme = darkMode ? dark : light;
  }

  Future<void> swapTheme() async {
    if (_selectedTheme == dark) {
      _selectedTheme = light;
    } else {
      _selectedTheme = dark;
    }
    notifyListeners();
  }

  ThemeData? getTheme() => _selectedTheme;
}
