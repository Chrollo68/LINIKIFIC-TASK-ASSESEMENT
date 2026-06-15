import 'package:flutter/material.dart';

import '../services/preferences_service.dart';

class SettingsProvider extends ChangeNotifier {
  final PreferencesService service = PreferencesService();

  bool darkMode = false;

  bool isLoggedIn = false;

  String language = "English";

  bool notifications = true;

  Future<void> loadSettings() async {
    darkMode = await service.getDarkMode();

    isLoggedIn = await service.getLogin();

    language = await service.getLanguage();

    notifications = await service.getNotifications();

    notifyListeners();
  }

  Future<void> toggleTheme(bool value) async {
    darkMode = value;

    await service.saveDarkMode(value);

    notifyListeners();
  }

  Future<void> login() async {
    isLoggedIn = true;

    await service.saveLogin(true);

    notifyListeners();
  }

  Future<void> logout() async {
    isLoggedIn = false;

    await service.saveLogin(false);

    notifyListeners();
  }

  Future<void> changeLanguage(String value) async {
    language = value;

    await service.saveLanguage(value);

    notifyListeners();
  }

  Future<void> changeNotification(bool value) async {
    notifications = value;

    await service.saveNotifications(value);

    notifyListeners();
  }
}
