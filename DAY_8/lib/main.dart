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
      home: const HomeScreen(),

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

/*
================================================================================
                          NAVIGATION CONCEPTS GUIDE
================================================================================

This application demonstrates all major Flutter navigation patterns:

1. BASIC NAVIGATION (Navigator.push/pop)
   - Located in: home_screen.dart
   - How it works: 
     * Navigator.push() creates new route and pushes to stack
     * MaterialPageRoute creates the transition animation
     * Navigator.pop() removes current route from stack
   - Code: Navigator.push(context, MaterialPageRoute(...))

2. PASSING DATA FORWARD
   - Located in: home_screen.dart (Home → Details)
   - How it works:
     * Pass objects through constructor parameters
     * Build the screen with required data
   - Code: DetailsScreen(user: sampleUser)

3. RETURNING DATA BACKWARD
   - Located in: home_screen.dart (Home → Form)
   - How it works:
     * Navigator.push() returns Future<dynamic>
     * Navigator.pop(context, data) sends data back
     * Use async/await to wait for result
   - Code: final result = await Navigator.push(...);
           Navigator.pop(context, returnValue);

4. NAMED ROUTES
   - Located in: main.dart (routes configuration)
   - How it works:
     * Define all routes in MaterialApp.routes
     * Use AppRoutes constants for route names
     * Extract arguments from ModalRoute.of(context)
   - Code: Navigator.pushNamed(context, '/profile', arguments: data);

5. NAVIGATION DRAWER
   - Located in: widgets/app_drawer.dart
   - How it works:
     * Add Drawer to Scaffold
     * ListTile for each drawer item
     * Close drawer before navigating
   - Code: Navigator.pop(context); // Close drawer
           Navigator.pushNamed(...); // Navigate

6. BOTTOM NAVIGATION BAR
   - Located in: widgets/custom_bottom_nav.dart
   - How it works:
     * Add NavigationBar to Scaffold.bottomNavigationBar
     * Handle onDestinationSelected callback
     * Use index to determine which screen to show
   - Code: NavigationBar(onDestinationSelected: ...)

7. TAB BAR NAVIGATION
   - Located in: home_screen.dart (TabBarScreen)
   - How it works:
     * Create TabController with length
     * Use TabBar with tabs
     * Use TabBarView with matching children count
   - Code: TabBar(...) + TabBarView(...)

8. NESTED NAVIGATION
   - Located in: home_screen.dart (NestedNavigationScreen)
   - How it works:
     * Maintain separate navigation stacks per tab
     * Track navigation history in lists
     * Back button pops from stack first
   - Code: _navigationStacks[tabIndex].add(screen);

================================================================================
                          BEST PRACTICES USED
================================================================================

✓ Separation of Concerns
  - Routes in routes/app_routes.dart
  - Screens in screens/
  - Widgets in widgets/
  - Models in models/

✓ Code Organization
  - Clear folder structure
  - Meaningful file names
  - Reusable widgets

✓ Null Safety
  - All variables properly typed
  - Null-coalescing operators used
  - Optional parameters with ?

✓ Clean Code
  - Helper methods for repeated UI patterns
  - Meaningful variable names
  - Comprehensive comments

✓ Material 3 Design
  - Modern color schemes
  - Proper spacing and typography
  - Responsive layouts

✓ State Management
  - StatelessWidget where no state needed
  - StatefulWidget with proper lifecycle
  - Local state in widgets

================================================================================
                          NAVIGATION FLOW EXAMPLES
================================================================================

Example 1: Basic Push/Pop
  Home Screen → Navigator.push() → Details Screen
  Details Screen → Navigator.pop() → Home Screen

Example 2: Data Forward and Backward
  Home Screen → Navigator.push() → Form Screen
  Form Screen → Navigator.pop(context, data) → Home Screen receives result

Example 3: Named Routes with Arguments
  Home Screen → Navigator.pushNamed(profile, arguments: user)
  Profile Screen → Extract user from arguments

Example 4: Drawer Navigation
  Home Screen → Drawer → Select Profile
  Drawer → Navigator.pop() → Navigator.pushNamed(profile)
  Profile Screen displays

Example 5: Bottom Navigation
  Home Screen → Bottom Nav → Tap Search
  Search Screen displays
  Tap Profile → Profile Screen displays

Example 6: TabBar Navigation
  Home Screen → Navigate to TabBar Screen
  TabBar Screen → Tap Sports Tab
  Sports content displays
  Tap Tech Tab → Tech content displays

Example 7: Nested Navigation
  Home Tab → Screen A
  Tap Screen B → Screen A → Screen B (in same tab stack)
  Switch to Search Tab (independent stack)
  Search Tab → Search Details

================================================================================
*/
