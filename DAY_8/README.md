# Navigation Showcase - Complete Flutter Navigation Guide

![Flutter](https://img.shields.io/badge/Flutter-Latest%20Stable-blue.svg)
![Material 3](https://img.shields.io/badge/Material-3-blue.svg)
![Dart](https://img.shields.io/badge/Dart-3.0%2B-blue.svg)
![License](https://img.shields.io/badge/License-MIT-green.svg)

A comprehensive Flutter application demonstrating all major navigation concepts and best practices. This project is designed to be educational, well-structured, and suitable for beginners learning Flutter navigation.

## 📋 Table of Contents

- [Project Overview](#project-overview)
- [Features](#features)
- [Concepts Learned](#concepts-learned)
- [Project Structure](#project-structure)
- [Installation & Setup](#installation--setup)
- [Navigation Patterns](#navigation-patterns)
- [Code Examples](#code-examples)
- [Best Practices](#best-practices)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)

## 🎯 Project Overview

The **Navigation Showcase App** is an educational Flutter application that demonstrates all major navigation concepts using Material 3 design system. It serves as a practical guide for developers learning Flutter navigation patterns.

### Key Objectives

✅ Demonstrate practical navigation implementations
✅ Show clean architecture and code organization
✅ Provide well-commented, beginner-friendly code
✅ Use Material 3 design system
✅ Include comprehensive documentation
✅ Follow Flutter best practices

## ✨ Features

### 1. Basic Navigation (Navigator.push/pop)
- Push new screens onto the navigation stack
- Pop screens to return to previous page
- Material transitions and animations
- Back button integration

**File:** `lib/screens/home_screen.dart`
**Key Methods:** `Navigator.push()`, `Navigator.pop()`, `MaterialPageRoute()`

### 2. Passing Data Forward
- Pass objects between screens
- Constructor-based data passing
- Display received data on destination screen

**File:** `lib/screens/home_screen.dart` → `lib/screens/home_screen.dart` (DetailsScreen)
**Key Concept:** Pass User object through constructor

### 3. Returning Data Backward
- Return data from child to parent screen
- Use `Navigator.pop()` with data argument
- Handle Future result with async/await

**File:** `lib/screens/home_screen.dart` → `lib/screens/home_screen.dart` (FormScreen)
**Key Code:**
```dart
final result = await Navigator.push<String>(context, route);
Navigator.pop(context, 'Message: "$data"');
```

### 4. Named Routes
- Centralized route definitions
- Navigate using route names instead of MaterialPageRoute
- Pass arguments through named routes
- Extract arguments at destination

**File:** `lib/routes/app_routes.dart`, `lib/main.dart`
**Key Methods:** `Navigator.pushNamed()`, `ModalRoute.of(context)`

### 5. Navigation Drawer
- Modern drawer with header (avatar, name, email)
- Multiple navigation items
- Proper icon usage
- Automatic drawer closing after selection
- Navigation integration with routes

**File:** `lib/widgets/app_drawer.dart`
**Features:**
- Custom drawer header
- Profile section
- Multiple navigation items
- Professional styling

### 6. Bottom Navigation Bar
- NavigationBar with multiple destinations
- Icon and label for each tab
- Tab selection handling
- Integration with navigation
- State preservation across tabs

**File:** `lib/widgets/custom_bottom_nav.dart`
**Tabs:**
1. Home
2. Search
3. Favorites
4. Profile

### 7. TabBar Navigation
- TabBar with multiple tabs
- TabBarView with tab content
- Custom tab indicator
- Smooth tab switching
- Independent content per tab

**File:** `lib/screens/home_screen.dart` (TabBarScreen)
**Tabs:**
- News (Icon: newspapers)
- Sports (Icon: sports_basketball)
- Technology (Icon: computer)

### 8. Nested Navigation
- Independent navigation stacks per tab
- Back button respects nested structure
- Demonstrates complex navigation hierarchies
- Screen-in-screen navigation

**File:** `lib/screens/home_screen.dart` (NestedNavigationScreen)
**Features:**
- Separate navigation stacks for each tab
- Visual stack representation
- Back button handling
- Multi-level navigation

## 📚 Concepts Learned

### Navigation Methods
```dart
// Basic Navigation
Navigator.push(context, route);
Navigator.pop(context);

// Named Routes
Navigator.pushNamed(context, routeName);
Navigator.pushNamed(context, routeName, arguments: data);

// Extract Arguments
final args = ModalRoute.of(context)?.settings.arguments as Type?;

// Return Data
Navigator.pop(context, returnValue);
await Navigator.push(...);
```

### Route Types
```dart
// Material Route with transition
MaterialPageRoute(builder: (context) => Screen());

// Custom transitions
CupertinoPageRoute(builder: (context) => Screen());

// Named routes
/home, /profile, /settings, etc.
```

### Data Passing Patterns
1. **Constructor Parameters** - Pass objects through screen constructor
2. **Named Route Arguments** - Pass data via pushNamed arguments
3. **Pop with Data** - Return data when popping
4. **Shared State** - Use Provider/GetX (advanced)

### Navigation Widgets
- `Navigator` - Manages navigation stack
- `MaterialApp` - Configures routes
- `Scaffold` - Contains AppBar and drawer
- `Drawer` - Side navigation menu
- `NavigationBar` - Bottom navigation
- `TabBar/TabBarView` - Tab-based navigation

## 📁 Project Structure

```
lib/
├── main.dart                    # App entry point, route configuration
│
├── screens/
│   ├── home_screen.dart        # Home, Details, Form, TabBar, Nested screens
│   ├── profile_screen.dart     # Profile with named route arguments
│   ├── settings_screen.dart    # Settings page
│   └── about_screen.dart       # About, Search, Favorites screens
│
├── widgets/
│   ├── app_drawer.dart         # Navigation drawer with header
│   └── custom_bottom_nav.dart  # Bottom navigation bar
│
├── models/
│   └── user.dart               # User data model
│
└── routes/
    └── app_routes.dart         # Route path constants

pubspec.yaml                     # Project dependencies
README.md                        # This file
```

### File Descriptions

| File | Purpose | Lines | Concepts |
|------|---------|-------|----------|
| `main.dart` | App entry, routes, theme | 200+ | Material 3, Named routes, Theme |
| `home_screen.dart` | Home, Details, Form, TabBar, Nested | 500+ | Push/pop, Data passing, TabBar |
| `profile_screen.dart` | Profile display | 100+ | Named routes, Arguments |
| `settings_screen.dart` | Settings UI | 150+ | Navigation drawer integration |
| `about_screen.dart` | About + Search/Favorites | 200+ | Bottom nav integration |
| `app_drawer.dart` | Drawer widget | 100+ | Drawer navigation |
| `custom_bottom_nav.dart` | Bottom nav widget | 80+ | Bottom navigation |
| `user.dart` | User model | 40+ | Data passing |
| `app_routes.dart` | Route constants | 30+ | Route management |

## 🚀 Installation & Setup

### Prerequisites
- Flutter SDK (Latest Stable)
- Dart 3.0+
- Android Studio or VS Code with Flutter extension
- Physical device or emulator

### Step 1: Clone/Download Project
```bash
# If from repository
git clone <repository-url>
cd navigation_showcase

# Or navigate to DAY_8 folder
cd DAY_8
```

### Step 2: Install Dependencies
```bash
flutter pub get
```

### Step 3: Configure Flutter
```bash
# Check Flutter setup
flutter doctor

# Update Flutter (optional but recommended)
flutter upgrade
```

### Step 4: Run the App
```bash
# Run on connected device
flutter run

# Run in debug mode
flutter run -d <device_id>

# Run in release mode
flutter run --release
```

### Step 5: View in Browser (Optional)
```bash
# Enable web
flutter config --enable-web

# Run on web
flutter run -d web-server
```

## 🗺️ Navigation Patterns

### Pattern 1: Basic Push/Pop Navigation

**When to use:** Simple screen transitions without data passing

```dart
// Home Screen
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const DetailsScreen()),
);

// Details Screen - Go Back
Navigator.pop(context);
```

**Example in app:** Home → Details Screen button

### Pattern 2: Passing Data Forward

**When to use:** Send data to next screen

```dart
// Home Screen
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => DetailsScreen(user: sampleUser),
  ),
);

// Details Screen - Receive in Constructor
class DetailsScreen extends StatelessWidget {
  final User? user;
  const DetailsScreen({Key? key, this.user}) : super(key: key);
}
```

**Example in app:** Pass User Data to Details Screen

### Pattern 3: Returning Data Backward

**When to use:** Get data back from child screen

```dart
// Home Screen - Wait for Result
final result = await Navigator.push<String>(
  context,
  MaterialPageRoute(builder: (context) => const FormScreen()),
);

// Form Screen - Return Data
if (message.isNotEmpty) {
  Navigator.pop(context, 'Message: "$message"');
}
```

**Example in app:** Form Screen → Return Message

### Pattern 4: Named Routes

**When to use:** Large apps with many routes, centralized route management

```dart
// main.dart - Define Routes
MaterialApp(
  routes: {
    '/': (context) => const HomeScreen(),
    '/profile': (context) {
      final user = ModalRoute.of(context)?.settings.arguments as User?;
      return ProfileScreen(user: user);
    },
  },
)

// Any Screen - Navigate
Navigator.pushNamed(context, '/profile', arguments: user);
```

**Example in app:** Navigate using Named Routes button

### Pattern 5: Navigation Drawer

**When to use:** App-level navigation menu

```dart
// Scaffold with Drawer
Scaffold(
  drawer: const AppDrawer(),
  // ... rest of scaffold
)

// AppDrawer - Handle Navigation
ListTile(
  title: const Text('Profile'),
  onTap: () {
    Navigator.pop(context); // Close drawer
    Navigator.pushNamed(context, '/profile');
  },
)
```

**Example in app:** Open drawer menu from home

### Pattern 6: Bottom Navigation

**When to use:** Main tabs at bottom of screen

```dart
NavigationBar(
  selectedIndex: _selectedIndex,
  onDestinationSelected: (int index) {
    // Handle tab selection
    Navigator.push(context, route);
  },
  destinations: [...],
)
```

**Example in app:** Bottom navigation bar in home

### Pattern 7: TabBar Navigation

**When to use:** Multiple views under single screen header

```dart
// Create TabController
_tabController = TabController(length: 3, vsync: this);

// AppBar with TabBar
AppBar(
  bottom: TabBar(
    controller: _tabController,
    tabs: const [Tab(text: 'News'), ...],
  ),
)

// Content with TabBarView
TabBarView(
  controller: _tabController,
  children: [NewsTab(), SportsTab(), TechTab()],
)
```

**Example in app:** TabBar Navigation Screen

### Pattern 8: Nested Navigation

**When to use:** Independent stacks per tab, complex hierarchies

```dart
// Maintain separate stacks
List<List<String>> _navigationStacks = [
  ['Home Tab - Screen A'],
  ['Search Tab - Home'],
];

// Push to specific stack
_navigationStacks[tabIndex].add(screenName);

// Back button pops from current stack
if (_navigationStacks[_selectedIndex].length > 1) {
  _navigationStacks[_selectedIndex].removeLast();
}
```

**Example in app:** Nested Navigation Demo

## 💻 Code Examples

### Example 1: Complete Navigation Flow

```dart
// Start from Home Screen
Home Screen
  ↓
  (Tap "Navigate to Details")
  ↓
Details Screen (received data)
  ↓
  (Tap back button)
  ↓
Home Screen (restored state)
```

**Code:**
```dart
// Home Screen
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => DetailsScreen(user: sampleUser),
  ),
);

// Details Screen receives User and displays it
```

### Example 2: Returning Data from Form

```dart
// Home Screen - Request data
final result = await Navigator.push<String>(
  context,
  MaterialPageRoute(builder: (context) => const FormScreen()),
);

setState(() => returnedMessage = result);

// Form Screen - Send data back
Navigator.pop(context, 'User Input: "$text"');
```

### Example 3: Named Route with Arguments

```dart
// main.dart - Configure route
'/profile': (context) {
  final user = ModalRoute.of(context)?.settings.arguments as User?;
  return ProfileScreen(user: user);
}

// Any screen - Navigate with data
Navigator.pushNamed(
  context,
  '/profile',
  arguments: User(
    name: 'John',
    age: 28,
    email: 'john@example.com',
    city: 'New York',
  ),
);
```

### Example 4: Drawer Navigation

```dart
// Drawer Item
ListTile(
  leading: const Icon(Icons.person),
  title: const Text('Profile'),
  onTap: () {
    Navigator.pop(context); // Close drawer
    Navigator.pushNamed(context, AppRoutes.profile);
  },
)
```

## 🎨 Best Practices

### 1. Route Organization
✅ Define all routes in `app_routes.dart` constant file
✅ Use named constants instead of string literals
✅ Group related routes together
❌ Don't hardcode route strings throughout app

### 2. Data Passing
✅ Use constructors for simple data (1-2 objects)
✅ Use named routes with arguments for complex data
✅ Type-check extracted arguments
❌ Don't use global variables for navigation data
❌ Don't pass large objects unnecessarily

### 3. Navigation Stack
✅ Use `Navigator.pop()` for natural back behavior
✅ Clear navigation history when needed with `pushReplacementNamed()`
✅ Handle back button in custom ways with `WillPopScope`
❌ Don't create navigation loops
❌ Don't ignore back button behavior

### 4. State Management
✅ Keep state close to where it's used
✅ Use `setState()` for local state
✅ Use Provider/GetX for shared state (advanced)
❌ Don't create too much nested state
❌ Don't lose state on navigation

### 5. UI/UX
✅ Provide visual feedback for navigation
✅ Use consistent icons and labels
✅ Auto-close drawers after selection
✅ Show loading states during async operations
❌ Don't make navigation confusing
❌ Don't surprise users with navigation

### 6. Code Quality
✅ Add meaningful comments
✅ Use descriptive variable names
✅ Keep files organized in folders
✅ Follow Dart style guidelines
✅ Use null safety
❌ Don't ignore warnings
❌ Don't skip code formatting

### 7. Performance
✅ Lazy load screens when possible
✅ Dispose resources in `dispose()`
✅ Use `const` constructors
✅ Avoid rebuilding entire navigation structure
❌ Don't create excessive widgets
❌ Don't ignore memory leaks

### 8. Accessibility
✅ Use proper semantic widgets
✅ Add meaningful labels to buttons
✅ Test with screen readers
✅ Use sufficient color contrast
❌ Don't rely on color alone for information
❌ Don't create inaccessible navigation

## 📖 Learning Path

### Beginner Level
1. Understand basic push/pop navigation
2. Learn MaterialPageRoute
3. Practice simple screen transitions
4. **Files to study:** `home_screen.dart` (Basic Navigation section)

### Intermediate Level
1. Master data passing patterns
2. Learn named routes
3. Implement drawer navigation
4. Understand TabBar
5. **Files to study:** `main.dart`, `app_routes.dart`, `app_drawer.dart`

### Advanced Level
1. Implement nested navigation
2. Handle complex state with navigation
3. Create custom transitions
4. Optimize navigation performance
5. **Files to study:** `home_screen.dart` (NestedNavigationScreen)

## 🐛 Troubleshooting

### Issue: "No route named '/route'" Error
**Solution:** 
- Check route name in `app_routes.dart`
- Verify route is defined in `main.dart` routes map
- Ensure route name matches exactly

### Issue: Arguments not received in destination screen
**Solution:**
```dart
// Correct way
final args = ModalRoute.of(context)?.settings.arguments as Type?;

// Check if args is null before using
if (args != null) {
  // Use args
}
```

### Issue: Back button not working
**Solution:**
- Ensure you're using `Navigator.pop()` for normal screens
- For custom behavior, use `WillPopScope` widget
- Check navigation stack depth

### Issue: Drawer not closing after navigation
**Solution:**
```dart
// Always close drawer first
Navigator.pop(context); // Closes drawer
Navigator.pushNamed(context, routeName); // Navigate
```

### Issue: State lost when navigating
**Solution:**
- Use `StatefulWidget` to preserve state
- Don't create new instances on rebuild
- Use `PageStorage` for preserving list scroll position
- Consider using state management solution (Provider, GetX)

### Issue: Memory leak warnings
**Solution:**
```dart
@override
void dispose() {
  _controller?.dispose();
  _tabController?.dispose();
  super.dispose();
}
```

## 📚 Additional Resources

### Flutter Documentation
- [Navigation and Routing](https://docs.flutter.dev/development/ui/navigation)
- [Material Design](https://material.io/design)
- [Material 3 in Flutter](https://docs.flutter.dev/development/ui/material-components/material-3)

### Recommended Learning
- Official Flutter Navigation Tutorials
- Material 3 Design Guidelines
- Dart Language Documentation

## 🤝 Contributing

Contributions are welcome! To improve this educational project:

1. Fork the repository
2. Create a feature branch
3. Make your improvements
4. Add comments and documentation
5. Submit a pull request

## 📝 License

This project is provided as an educational resource. Feel free to use it for learning purposes.

## 👨‍💻 Author

Created as an educational Flutter navigation guide for beginners and intermediate developers.

---

## 🔍 Quick Reference

### Navigation Patterns at a Glance

| Pattern | When to Use | Key Code |
|---------|------------|----------|
| **Basic Push/Pop** | Simple transitions | `Navigator.push()` / `pop()` |
| **Data Forward** | Pass objects to next screen | Constructor parameters |
| **Data Backward** | Return data to previous screen | `Navigator.pop(context, data)` |
| **Named Routes** | Centralized routing | `Navigator.pushNamed()` |
| **Drawer** | App-level menu | `Drawer` widget + `pop()` then `pushNamed()` |
| **Bottom Nav** | Main tabs | `NavigationBar` + `onDestinationSelected` |
| **TabBar** | Sub-navigation under header | `TabBar` + `TabBarView` + `TabController` |
| **Nested** | Multiple stacks per tab | Track stacks per tab |

### Key Flutter Classes

| Class | Purpose |
|-------|---------|
| `Navigator` | Manages navigation stack |
| `MaterialPageRoute` | Transition animation |
| `MaterialApp` | Configure routes globally |
| `Scaffold` | App structure with drawer |
| `Drawer` | Side navigation menu |
| `NavigationBar` | Bottom navigation (Material 3) |
| `TabBar` + `TabBarView` | Tabbed content |
| `ModalRoute` | Access route arguments |

---

**Happy Learning! 🚀**

For questions or suggestions, feel free to reach out or create an issue.
