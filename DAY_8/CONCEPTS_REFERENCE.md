# Navigation Concepts Reference Guide

Quick reference for all Flutter navigation concepts demonstrated in this project.

---

## 📚 Table of Contents

1. [Basic Navigation](#basic-navigation)
2. [Data Passing](#data-passing)
3. [Named Routes](#named-routes)
4. [Drawer Navigation](#drawer-navigation)
5. [Bottom Navigation](#bottom-navigation)
6. [TabBar Navigation](#tabbar-navigation)
7. [Nested Navigation](#nested-navigation)
8. [Common Patterns](#common-patterns)

---

## Basic Navigation

### What is it?
The fundamental way to move between screens in Flutter using the Navigator widget.

### Key Classes
- `Navigator` - Manages navigation stack
- `MaterialPageRoute` - Standard Material transition
- `CupertinoPageRoute` - iOS-style transition (optional)

### How to Use

#### Push (Go to Next Screen)
```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const NextScreen(),
  ),
);
```

#### Pop (Go Back)
```dart
Navigator.pop(context);
```

### Example in Project
```
Home Screen → "Navigate to Details" button → Details Screen
Details Screen → Back button or "Back to Home" button → Home Screen
```

**Location:** `lib/screens/home_screen.dart` - Feature 1

### Key Concepts
- `push()` adds screen to stack
- `pop()` removes top screen from stack
- Back button automatically calls `pop()`
- Default material transition (slide up from bottom)

---

## Data Passing

### Pattern 1: Forward (Constructor Parameters)

**When to use:** Simple objects, 1-2 parameters

#### Send Data
```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => DetailsScreen(user: userData),
  ),
);
```

#### Receive Data
```dart
class DetailsScreen extends StatelessWidget {
  final User? user;
  
  const DetailsScreen({Key? key, this.user}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    // Use user here
    print(user?.name);
  }
}
```

**Location:** `lib/screens/home_screen.dart` - Feature 2

---

### Pattern 2: Backward (Using Pop)

**When to use:** Return data from child to parent screen

#### Send Result Back
```dart
if (userInput.isNotEmpty) {
  // Pop with data as second argument
  Navigator.pop(context, 'User entered: $userInput');
}
```

#### Receive Returned Data
```dart
// Use async/await to wait for result
final result = await Navigator.push<String>(
  context,
  MaterialPageRoute(
    builder: (context) => const FormScreen(),
  ),
);

// Handle the returned data
if (result != null) {
  print('Received: $result');
}
```

**Location:** `lib/screens/home_screen.dart` - Feature 3

### Key Concepts
- Use `<Type>` to specify return type: `Navigator.push<String>`
- `Navigator.pop(context, value)` to return data
- Parent screen awaits with `async/await`
- Only first `pop()` returns data to original caller

---

## Named Routes

### What is it?
Centralized route definitions that allow navigation by name instead of creating routes inline.

### Configuration (main.dart)
```dart
MaterialApp(
  routes: {
    '/': (context) => const HomeScreen(),
    '/profile': (context) {
      // Extract arguments if provided
      final user = ModalRoute.of(context)?.settings.arguments as User?;
      return ProfileScreen(user: user);
    },
    '/settings': (context) => const SettingsScreen(),
  },
)
```

### Route Constants (app_routes.dart)
```dart
class AppRoutes {
  static const String home = '/';
  static const String profile = '/profile';
  static const String settings = '/settings';
}
```

### Navigation (Any Screen)
```dart
// Without arguments
Navigator.pushNamed(context, AppRoutes.profile);

// With arguments
Navigator.pushNamed(
  context,
  AppRoutes.profile,
  arguments: user,
);
```

### Extract Arguments (Destination Screen)
```dart
final user = ModalRoute.of(context)?.settings.arguments as User?;
```

**Location:** `lib/routes/app_routes.dart`, `lib/main.dart`, `lib/screens/profile_screen.dart`

### Key Concepts
- Define all routes in `MaterialApp.routes`
- Use string constants to avoid typos
- Arguments passed via `pushNamed()` parameter
- Extract using `ModalRoute.of(context).settings.arguments`
- Type-safe extraction with `as Type?`

---

## Drawer Navigation

### What is it?
A side menu that provides top-level navigation options.

### Implementation
```dart
Scaffold(
  drawer: const AppDrawer(),
  appBar: AppBar(
    title: const Text('Title'),
  ),
  body: // ... screen content
)
```

### Drawer Widget
```dart
class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Drawer Header
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: // ... header content
          ),
          
          // Navigation Items
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pop(context); // Close drawer
              // Navigate if needed
            },
          ),
        ],
      ),
    );
  }
}
```

### Navigation Pattern
```dart
ListTile(
  title: const Text('Profile'),
  onTap: () {
    Navigator.pop(context); // IMPORTANT: Close drawer first!
    Navigator.pushNamed(context, AppRoutes.profile);
  },
)
```

**Location:** `lib/widgets/app_drawer.dart`

### Key Concepts
- Add `Drawer` widget to `Scaffold.drawer`
- Use `DrawerHeader` for user info
- Use `ListTile` for menu items
- **Always close drawer before navigating** - `Navigator.pop(context)`
- Proper icon selection improves UX
- DrawerHeader can contain avatar, name, email

---

## Bottom Navigation

### What is it?
Main navigation tabs at the bottom of the screen (Material 3: NavigationBar).

### Implementation
```dart
Scaffold(
  body: // ... screen content
  bottomNavigationBar: NavigationBar(
    selectedIndex: _selectedIndex,
    onDestinationSelected: (int index) {
      setState(() {
        _selectedIndex = index;
      });
      // Handle navigation based on index
    },
    destinations: const [
      NavigationDestination(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      NavigationDestination(
        icon: Icon(Icons.search),
        label: 'Search',
      ),
    ],
  ),
)
```

### Navigation Handling
```dart
onDestinationSelected: (int index) {
  setState(() => _selectedIndex = index);
  
  switch (index) {
    case 0:
      // Home - already there or pop to home
      break;
    case 1:
      Navigator.push(context, route);
      break;
    case 2:
      Navigator.pushNamed(context, AppRoutes.favorites);
      break;
  }
}
```

**Location:** `lib/widgets/custom_bottom_nav.dart`

### Key Concepts
- Use `NavigationBar` (Material 3) instead of `BottomNavigationBar`
- `selectedIndex` tracks current tab
- `onDestinationSelected` handles tab selection
- `destinations` define tab icons and labels
- Each tab can navigate to different screen
- Update state when tab changes

### Important
- Don't use `NavigationBar` in newer Material 3 projects
- Use `BottomNavigationBar` only for legacy apps
- Material 3 provides better animations and UX

---

## TabBar Navigation

### What is it?
Multiple views accessible via tabs in the AppBar or custom widget.

### Setup
```dart
class TabViewScreen extends StatefulWidget {
  const TabViewScreen({Key? key}) : super(key: key);

  @override
  State<TabViewScreen> createState() => _TabViewScreenState();
}

class _TabViewScreenState extends State<TabViewScreen> 
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'News', icon: Icon(Icons.newspaper)),
            Tab(text: 'Sports', icon: Icon(Icons.sports)),
            Tab(text: 'Tech', icon: Icon(Icons.computer)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          NewsTab(),
          SportsTab(),
          TechTab(),
        ],
      ),
    );
  }
}
```

**Location:** `lib/screens/home_screen.dart` - TabBarScreen class

### Key Concepts
- Use `SingleTickerProviderStateMixin` for TabController
- `TabController(length: X)` - X = number of tabs
- `TabBar` in AppBar.bottom with tab definitions
- `TabBarView` in body with matching number of children
- **Always dispose TabController** in `dispose()`
- Smooth animations between tabs

---

## Nested Navigation

### What is it?
Independent navigation stacks for each tab, allowing back button to work within tab context.

### Implementation
```dart
class NestedNavigationScreen extends StatefulWidget {
  @override
  State<NestedNavigationScreen> createState() => _NestedNavigationScreenState();
}

class _NestedNavigationScreenState extends State<NestedNavigationScreen> {
  int _selectedIndex = 0;

  // Separate stack for each tab
  final List<List<String>> _navigationStacks = [
    ['Home Tab - Screen A'],
    ['Search Tab - Home'],
  ];

  void _pushToStack(int tabIndex, String screenName) {
    setState(() {
      _navigationStacks[tabIndex].add(screenName);
    });
  }

  void _popFromStack(int tabIndex) {
    if (_navigationStacks[tabIndex].length > 1) {
      setState(() {
        _navigationStacks[tabIndex].removeLast();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Pop from nested stack first
            if (_navigationStacks[_selectedIndex].length > 1) {
              _popFromStack(_selectedIndex);
            } else {
              // Exit screen when stack is at root
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: Column(
        children: [
          // Show current screen content
          Expanded(
            child: Text(_navigationStacks[_selectedIndex].last),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() => _selectedIndex = index);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        ],
      ),
    );
  }
}
```

**Location:** `lib/screens/home_screen.dart` - NestedNavigationScreen class

### Key Concepts
- Maintain separate `List<List<String>>` for each tab's stack
- `_navigationStacks[tabIndex]` tracks screens in that tab
- When user taps back, pop from current tab's stack first
- Switch tabs without losing history (push to stack)
- Only when tab's stack is empty does back exit screen

---

## Common Patterns

### Pattern: Pop to Root (Home)
```dart
// Remove all routes and go to home
Navigator.of(context).pushNamedAndRemoveUntil(
  AppRoutes.home,
  (Route<dynamic> route) => false,
);
```

### Pattern: Replace Current Route
```dart
// Replace current screen with new one
Navigator.pushReplacementNamed(context, AppRoutes.profile);
```

### Pattern: Multiple Pops
```dart
// Pop multiple screens at once
Navigator.of(context).popUntil((route) => route.isFirst);
```

### Pattern: Conditional Navigation
```dart
if (isLoggedIn) {
  Navigator.pushNamed(context, '/home');
} else {
  Navigator.pushNamed(context, '/login');
}
```

### Pattern: Dialog Navigation
```dart
showDialog(
  context: context,
  builder: (context) => AlertDialog(
    title: const Text('Confirm'),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('Cancel'),
      ),
    ],
  ),
);
```

### Pattern: Anonymous Routes
```dart
// Without named route configuration
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const NextScreen()),
);
```

### Pattern: Deep Linking
```dart
// Route mapping for deep links
onGenerateRoute: (settings) {
  if (settings.name == '/user/123') {
    return MaterialPageRoute(
      builder: (context) => UserScreen(id: 123),
    );
  }
  return MaterialPageRoute(builder: (context) => const HomeScreen());
}
```

---

## 🎯 Quick Decision Tree

**Need to navigate?**

1. **Simple transition (no data)?**
   → Use `Navigator.push()` with `MaterialPageRoute`

2. **Pass object to next screen?**
   → Pass through constructor: `NextScreen(data: myData)`

3. **Return data to previous screen?**
   → Use `await Navigator.push()` and `Navigator.pop(context, data)`

4. **Many routes in large app?**
   → Use Named Routes with `routes:` in MaterialApp

5. **Drawer menu?**
   → Add `drawer:` to Scaffold, use `Navigator.pop()` then `pushNamed()`

6. **Bottom tabs?**
   → Use `NavigationBar` with `onDestinationSelected:`

7. **Top tabs with swipe?**
   → Use `TabBar` + `TabBarView` with `TabController`

8. **Tabs with independent back navigation?**
   → Implement Nested Navigation with separate stacks per tab

---

## 🔗 Related Files

- **Routes Definition:** `lib/routes/app_routes.dart`
- **Main App Setup:** `lib/main.dart`
- **All Screens:** `lib/screens/`
- **Navigation Widgets:** `lib/widgets/`
- **Full Documentation:** `README.md`
- **Setup Instructions:** `SETUP_GUIDE.md`

---

## 💡 Best Practice Reminders

✅ Always type-check extracted arguments
✅ Dispose controllers in `dispose()` method
✅ Close drawer before navigating
✅ Use const constructors when possible
✅ Keep routes organized in separate file
✅ Use meaningful route names
✅ Test all back button scenarios
✅ Handle null values appropriately
✅ Add helpful comments in code
✅ Follow Material 3 guidelines

---

**Happy Learning! 🚀**
