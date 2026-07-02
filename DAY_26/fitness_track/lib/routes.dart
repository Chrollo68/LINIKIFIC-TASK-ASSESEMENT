import 'package:flutter/material.dart';

import 'screens/auth/auth_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/splash/splash_screen.dart';
import 'screens/workout/workout_screen.dart';
import 'screens/main_shell.dart';

class AppRoutes {
  static const String splash = '/';
  static const String auth = '/auth';
  static const String home = '/home';
  static const String workouts = '/workouts';
  static const String profile = '/profile';

  static final Map<String, WidgetBuilder> routes = {
    splash: (_) => const SplashScreen(),
    auth: (_) => const AuthScreen(),
    home: (_) => const MainShell(),
    workouts: (_) => const WorkoutScreen(),
    profile: (_) => const ProfileScreen(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute<dynamic>(
      builder: (context) => switch (settings.name) {
        AppRoutes.home => const MainShell(),
        AppRoutes.workouts => const WorkoutScreen(),
        AppRoutes.profile => const ProfileScreen(),
        AppRoutes.auth => const AuthScreen(),
        _ => const SplashScreen(),
      },
      settings: settings,
    );
  }
}
