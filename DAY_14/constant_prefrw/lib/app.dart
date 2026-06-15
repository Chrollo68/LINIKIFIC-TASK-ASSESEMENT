import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/settings_provider.dart';

import 'screens/login_screen.dart';
import 'screens/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(brightness: Brightness.light),

      darkTheme: ThemeData(brightness: Brightness.dark),

      themeMode: settings.darkMode ? ThemeMode.dark : ThemeMode.light,

      home: settings.isLoggedIn ? const HomeScreen() : const LoginScreen(),
    );
  }
}
