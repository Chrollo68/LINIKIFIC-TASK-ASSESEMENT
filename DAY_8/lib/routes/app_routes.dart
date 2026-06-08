/// App Routes Configuration
/// This file defines all named routes used in the application.
/// Named routes provide a centralized location for route definitions
/// and make it easy to navigate using route names instead of creating
/// new MaterialPageRoute instances each time.

/// Route path constants - use these strings in Navigator.pushNamed()
class AppRoutes {
  // Home and basic routes
  static const String home = '/';
  static const String details = '/details';
  static const String form = '/form';
  static const String result = '/result';

  // Navigation pattern routes
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String about = '/about';
  static const String search = '/search';
  static const String favorites = '/favorites';

  // Nested navigation routes
  static const String nestedHome = '/nested_home';
  static const String nestedSearch = '/nested_search';

  // Article details (for TabBar demonstration)
  static const String articleDetails = '/article_details';
}
