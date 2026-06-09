import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/about_screen.dart';
import 'models/user.dart';
import 'routes/app_routes.dart';

/// Main Entry Point
/// This is where the Flutter application starts.
///
/// Key Features Configured:
/// - Material 3 Design enabled
/// - Named routes defined
/// - Theme configuration
/// - Material Color Scheme (useMaterial3: true)
void main() {
  runApp(const NavigationShowcaseApp());
}

/// Navigation Showcase Application
///
/// This is the root widget of the application.
/// It configures:
/// - Material 3 design system
/// - Navigation routes
/// - App theme
/// - Initial route
class NavigationShowcaseApp extends StatelessWidget {
  const NavigationShowcaseApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Showcase',
      debugShowCheckedModeBanner: false,

      // Feature 4: Named Routes Configuration
      // All navigation routes are defined here
      // This provides a centralized location for route definitions
      // making it easy to manage navigation across the app

      // Define named routes using a Map
      // Routes can be accessed using Navigator.pushNamed(context, routeName)
      routes: {
        AppRoutes.home: (context) => const HomeScreen(),

        // Profile Route - can receive User object as arguments
        AppRoutes.profile: (context) {
          // Extract arguments passed through Navigator.pushNamed()
          final user = ModalRoute.of(context)?.settings.arguments as User?;
          return ProfileScreen(user: user);
        },

        // Settings Route
        AppRoutes.settings: (context) => const SettingsScreen(),

        // About Route
        AppRoutes.about: (context) => const AboutScreen(),

        // Search Route
        AppRoutes.search: (context) => const SearchScreen(),

        // Favorites Route
        AppRoutes.favorites: (context) => const FavoritesScreen(),
      },

      // Theme Configuration - Material 3
      theme: ThemeData(
        // Use Material 3 design system
        // Material 3 provides modern design guidelines and components
        useMaterial3: true,

        // Color Scheme - defines primary, secondary, tertiary colors
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),

        // AppBar Theme
        appBarTheme: AppBarTheme(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.blue.shade50,
          foregroundColor: Colors.black87,
        ),

        // Button Theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 12,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),

        // Card Theme
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),

        // Input Decoration Theme
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),

        // Navigation Bar Theme
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: Colors.white,
          height: 70,
          indicatorShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),

      // Dark Theme Configuration (optional)
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
      ),

      // Use light theme by default
      themeMode: ThemeMode.light,
    );
  }
}

