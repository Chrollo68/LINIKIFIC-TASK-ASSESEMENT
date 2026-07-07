import 'package:flutter/material.dart';

import 'screens/auth/auth_screen.dart';
import 'screens/onboarding/health_metrics_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/splash/splash_screen.dart';
import 'screens/workout/workout_screen.dart';
import 'screens/main_shell.dart';

class AppRoutes {
  static const String splash = '/';
  static const String auth = '/auth';
  static const String healthMetrics = '/health-metrics';
  static const String home = '/home';
  static const String workouts = '/workouts';
  static const String profile = '/profile';
  static const String routines = '/routines';
  static const String routinesDetail = '/routines/detail';

  static final Map<String, WidgetBuilder> routes = {
    splash: (_) => const SplashScreen(),
    auth: (_) => const AuthScreen(),
    healthMetrics: (_) => const HealthMetricsScreen(),
    home: (_) => const MainShell(),
    workouts: (_) => const WorkoutScreen(),
    profile: (_) => const ProfileScreen(),
    routines: (_) => const SizedBox.shrink(),
    routinesDetail: (_) => const SizedBox.shrink(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    // Custom route transitions for routines
    if (settings.name == AppRoutes.routines) {
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (_, __, ___) => const SizedBox.shrink(),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      );
    }

    if (settings.name == AppRoutes.routinesDetail) {
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, _, __) => const SizedBox.shrink(),
        transitionsBuilder: (_, animation, __, child) {
          final offset = Tween(
            begin: const Offset(0.0, 1.0),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut));
          return SlideTransition(position: offset, child: child);
        },
      );
    }

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
