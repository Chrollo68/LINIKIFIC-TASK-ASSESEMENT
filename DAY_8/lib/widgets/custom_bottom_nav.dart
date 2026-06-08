import 'package:flutter/material.dart';
import '../screens/about_screen.dart';
import '../routes/app_routes.dart';

/// Custom Bottom Navigation Bar Widget
/// Feature 6: Bottom Navigation Bar
/// Demonstrates bottom navigation with icons and labels.
///
/// This widget:
/// - Provides a clean navigation experience
/// - Integrates with the main app structure
/// - Handles navigation to different screens
/// - Preserves state when switching tabs
class CustomBottomNav extends StatefulWidget {
  const CustomBottomNav({Key? key}) : super(key: key);

  @override
  State<CustomBottomNav> createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav> {
  int _selectedIndex = 0;

  // List of navigation destinations
  final List<NavigationDestination> _destinations = const [
    NavigationDestination(
      icon: Icon(Icons.home),
      label: 'Home',
      tooltip: 'Home Screen',
    ),
    NavigationDestination(
      icon: Icon(Icons.search),
      label: 'Search',
      tooltip: 'Search Screen',
    ),
    NavigationDestination(
      icon: Icon(Icons.favorite),
      label: 'Favorites',
      tooltip: 'Favorites Screen',
    ),
    NavigationDestination(
      icon: Icon(Icons.person),
      label: 'Profile',
      tooltip: 'Profile Screen',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: _selectedIndex,
      onDestinationSelected: (int index) {
        setState(() {
          _selectedIndex = index;
        });

        // Navigate based on selected index
        // Feature 6: Bottom Navigation Bar - Navigation Handling
        switch (index) {
          case 0:
            // Home - typically you would pop to root or navigate home
            // In this case, home is already the root
            break;
          case 1:
            // Navigate to Search screen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SearchScreen()),
            );
            break;
          case 2:
            // Navigate to Favorites screen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FavoritesScreen()),
            );
            break;
          case 3:
            // Navigate to Profile using named route
            Navigator.pushNamed(context, AppRoutes.profile);
            break;
        }
      },
      destinations: _destinations,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
    );
  }
}
