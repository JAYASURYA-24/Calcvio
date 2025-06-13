// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ThemeProvider with ChangeNotifier {
//   static const _themeKey = 'isDarkMode';
//   ThemeMode _themeMode = ThemeMode.system;
//   bool _isLoading = true;

//   ThemeMode get themeMode => _themeMode;
//   bool get isDarkMode => _themeMode == ThemeMode.dark;
//   bool get isLoading => _isLoading;

//   ThemeProvider() {
//     _loadThemeFromPrefs();
//   }

//   void toggleTheme(bool isOn) {
//     _themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
//     _saveThemeToPrefs(_themeMode);
//     notifyListeners();
//   }

//   Future<void> _loadThemeFromPrefs() async {
//     final prefs = await SharedPreferences.getInstance();
//     final isDark = prefs.getBool(_themeKey);
//     if (isDark != null) {
//       _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
//     }
//     _isLoading = false;
//     notifyListeners();
//   }

//   Future<void> _saveThemeToPrefs(ThemeMode mode) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool(_themeKey, mode == ThemeMode.dark);
//   }
// }
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  static const _themeKey = 'isDarkMode';
  ThemeMode _themeMode;

  ThemeProvider({required bool initialDarkMode})
    : _themeMode = initialDarkMode ? ThemeMode.dark : ThemeMode.light;

  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) async {
    _themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, isOn);
    notifyListeners();
  }
}
