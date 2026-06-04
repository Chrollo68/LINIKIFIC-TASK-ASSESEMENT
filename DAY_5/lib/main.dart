import 'package:flutter/material.dart';
import 'package:material_design_showcase_app/screens/buttons_showcase_screen.dart';
import 'package:material_design_showcase_app/screens/cards_listtiles_screen.dart';
import 'package:material_design_showcase_app/screens/dialogs_showcase_screen.dart';
import 'package:material_design_showcase_app/screens/forms_showcase_screen.dart';
import 'package:material_design_showcase_app/screens/home_screen.dart';
import 'package:material_design_showcase_app/screens/profile_screen.dart';
import 'package:material_design_showcase_app/screens/success_screen.dart';
import 'package:material_design_showcase_app/screens/snackbar_banner_screen.dart';
import 'package:material_design_showcase_app/theme/app_theme.dart';

void main() {
  runApp(const MaterialDesignShowcaseApp());
}

class MaterialDesignShowcaseApp extends StatelessWidget {
  const MaterialDesignShowcaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material Design Showcase App',
      theme: AppTheme.lightTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/buttons': (context) => const ButtonsShowcaseScreen(),
        '/cards': (context) => const CardsListTilesScreen(),
        '/forms': (context) => const FormsShowcaseScreen(),
        '/dialogs': (context) => const DialogsShowcaseScreen(),
        '/snackbar': (context) => const SnackBarBannerScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/success') {
          final userName = settings.arguments as String?;
          return MaterialPageRoute(
            builder: (context) => SuccessScreen(userName: userName ?? 'Guest'),
          );
        }
        return null;
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
