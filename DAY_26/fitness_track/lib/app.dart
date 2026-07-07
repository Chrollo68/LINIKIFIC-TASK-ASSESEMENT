import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/auth_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/workout_provider.dart';
import 'providers/routine_provider.dart';
import 'routes.dart';
import 'screens/auth/auth_screen.dart';
import 'screens/onboarding/health_metrics_screen.dart';
import 'screens/splash/splash_screen.dart';
import 'screens/main_shell.dart';
import 'screens/workout/workout_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/routines/routines_screen.dart';
import 'screens/routines/routine_detail_screen.dart';
import 'theme/app_theme.dart';

class FitnessApp extends StatelessWidget {
  const FitnessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => WorkoutProvider()),
        ChangeNotifierProvider(create: (_) => RoutineProvider()),
      ],
      child: const AppShell(),
    );
  }
}

class AppShell extends StatelessWidget {
  const AppShell({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp(
      title: 'FitFlow',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme.copyWith(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      darkTheme: AppTheme.darkTheme.copyWith(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      themeMode: themeProvider.themeMode,
      initialRoute: AppRoutes.splash,
      routes: {
        AppRoutes.splash: (_) => const SplashScreen(),
        AppRoutes.auth: (_) => const AuthScreen(),
        AppRoutes.healthMetrics: (_) => const HealthMetricsScreen(),
        AppRoutes.home: (_) => const MainShell(),
        AppRoutes.workouts: (_) => const WorkoutScreen(),
        AppRoutes.profile: (_) => const ProfileScreen(),
        AppRoutes.routines: (_) => const RoutinesScreen(),
        AppRoutes.routinesDetail: (_) => const RoutineDetailScreen(),
      },
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
