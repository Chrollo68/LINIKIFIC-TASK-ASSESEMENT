import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/settings_provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),

      body: Center(
        child: ElevatedButton(
          child: const Text("Login"),

          onPressed: () {
            Provider.of<SettingsProvider>(context, listen: false).login();
          },
        ),
      ),
    );
  }
}
