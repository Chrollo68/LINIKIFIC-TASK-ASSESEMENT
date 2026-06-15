import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/settings_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),

      body: Column(
        children: [
          SwitchListTile(
            title: const Text("Dark Mode"),

            value: settings.darkMode,

            onChanged: settings.toggleTheme,
          ),

          ListTile(
            title: const Text("Language"),

            subtitle: Text(settings.language),

            onTap: () {
              showDialog(
                context: context,

                builder: (context) {
                  return AlertDialog(
                    title: const Text("Select Language"),

                    content: Column(
                      mainAxisSize: MainAxisSize.min,

                      children: ["English", "Hindi", "Marathi"].map((lang) {
                        return ListTile(
                          title: Text(lang),

                          onTap: () {
                            settings.changeLanguage(lang);

                            Navigator.pop(context);
                          },
                        );
                      }).toList(),
                    ),
                  );
                },
              );
            },
          ),

          SwitchListTile(
            title: const Text("Notifications"),

            value: settings.notifications,

            onChanged: settings.changeNotification,
          ),

          ListTile(
            title: const Text("Logout"),

            onTap: () {
              settings.logout();

              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
