import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'providers/settings_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final settingsProvider = SettingsProvider();

  await settingsProvider.loadSettings();

  runApp(
    ChangeNotifierProvider.value(value: settingsProvider, child: const MyApp()),
  );
}
