import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  Future<void> saveDarkMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool("darkMode", value);
  }

  Future<bool> getDarkMode() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool("darkMode") ?? false;
  }

  Future<void> saveLogin(bool value) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool("isLoggedIn", value);
  }

  Future<bool> getLogin() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool("isLoggedIn") ?? false;
  }

  Future<void> saveLanguage(String value) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("language", value);
  }

  Future<String> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString("language") ?? "English";
  }

  Future<void> saveNotifications(bool value) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool("notifications", value);
  }

  Future<bool> getNotifications() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool("notifications") ?? true;
  }

  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.clear();
  }
}
