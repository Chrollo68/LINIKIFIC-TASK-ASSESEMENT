import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  static const String _themeKey = 'theme_mode';

  ThemeMode _themeMode = ThemeMode.system;
  late SharedPreferences _prefs;

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode {
    if (_themeMode == ThemeMode.system) {
      // Return system setting when in system mode
      // The actual system brightness is handled by MaterialApp
      return false; // Default to light when queried directly
    }
    return _themeMode == ThemeMode.dark;
  }

  /// Initialize the theme provider and load saved preferences
  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    await _loadTheme();
  }

  /// Load theme from SharedPreferences
  Future<void> _loadTheme() async {
    final savedTheme = _prefs.getString(_themeKey);
    if (savedTheme != null) {
      switch (savedTheme) {
        case 'light':
          _themeMode = ThemeMode.light;
          break;
        case 'dark':
          _themeMode = ThemeMode.dark;
          break;
        case 'system':
        default:
          _themeMode = ThemeMode.system;
          break;
      }
    }
    notifyListeners();
  }

  /// Set theme mode to light
  Future<void> setLightTheme() async {
    _themeMode = ThemeMode.light;
    await _prefs.setString(_themeKey, 'light');
    notifyListeners();
  }

  /// Set theme mode to dark
  Future<void> setDarkTheme() async {
    _themeMode = ThemeMode.dark;
    await _prefs.setString(_themeKey, 'dark');
    notifyListeners();
  }

  /// Set theme mode to system
  Future<void> setSystemTheme() async {
    _themeMode = ThemeMode.system;
    await _prefs.setString(_themeKey, 'system');
    notifyListeners();
  }

  /// Toggle between light and dark themes
  Future<void> toggleTheme() async {
    if (_themeMode == ThemeMode.light) {
      await setDarkTheme();
    } else if (_themeMode == ThemeMode.dark) {
      await setLightTheme();
    }
  }

  /// Get current theme mode as string
  String getThemeModeString() {
    switch (_themeMode) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.system:
        return 'System';
    }
  }

  /// Get theme mode description
  String getThemeModeDescription() {
    switch (_themeMode) {
      case ThemeMode.light:
        return 'Light theme is currently active';
      case ThemeMode.dark:
        return 'Dark theme is currently active';
      case ThemeMode.system:
        return 'Following system theme settings';
    }
  }
}
