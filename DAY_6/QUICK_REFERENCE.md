# Quick Reference Guide - Flutter Theming App

## 🚀 Quick Start

```bash
# 1. Navigate to project
cd DAY_6

# 2. Get dependencies
flutter pub get

# 3. Run app
flutter run
```

## 📱 App Navigation

| Tab | Purpose | Key Features |
|-----|---------|--------------|
| 🏠 Home | Featured components showcase | Buttons, cards, progress bars |
| 📝 Forms | Form components demo | Input validation, dropdowns, checkboxes |
| 🧩 Components | Complete UI showcase | Colors, typography, dialogs, lists |
| ⚙️ Settings | Theme management | Light/dark/system mode selection |

## 🎨 Color Usage

### Access Colors in Code

```dart
// Using AppColors constants
AppColors.primary
AppColors.secondary
AppColors.success

// Using Theme.of(context)
Theme.of(context).primaryColor
Theme.of(context).colorScheme.secondary
```

### Key Colors

```dart
// Light Theme
AppColors.primary = #6200EE (Purple)
AppColors.lightBackground = #FAFAFA
AppColors.lightSurface = #FFFFFF

// Dark Theme  
AppColors.darkBackground = #121212
AppColors.darkSurface = #1E1E1E

// Semantic
AppColors.success = #4CAF50
AppColors.error = #B3261E
AppColors.warning = #FFC107
AppColors.info = #2196F3
```

## 📏 Spacing Quick Reference

```dart
AppSpacing.xs    // 4.0   - Minimal
AppSpacing.sm    // 8.0   - Small
AppSpacing.md    // 16.0  - Standard
AppSpacing.lg    // 24.0  - Large
AppSpacing.xl    // 32.0  - Extra large
AppSpacing.xxl   // 48.0  - Huge

// Radius
AppSpacing.radiusSmall    // 4.0
AppSpacing.radiusMedium   // 8.0
AppSpacing.radiusLarge    // 16.0
AppSpacing.radiusXLarge   // 28.0
```

## 📝 Common Code Patterns

### Using Theme Colors

```dart
Container(
  color: Theme.of(context).primaryColor,
  child: Text(
    'Themed Text',
    style: Theme.of(context).textTheme.titleLarge,
  ),
)
```

### Creating Buttons

```dart
// Elevated Button
ElevatedButton(
  onPressed: () {},
  child: const Text('Button'),
)

// Outlined Button
OutlinedButton(
  onPressed: () {},
  child: const Text('Button'),
)

// Text Button
TextButton(
  onPressed: () {},
  child: const Text('Button'),
)
```

### Styled TextField

```dart
TextFormField(
  decoration: InputDecoration(
    labelText: 'Label',
    hintText: 'Hint',
    prefixIcon: const Icon(Icons.edit),
  ),
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Required';
    }
    return null;
  },
)
```

### Theme Switching

```dart
// Get ThemeProvider
final themeProvider = Provider.of<ThemeProvider>(context);

// Set theme
themeProvider.setLightTheme();
themeProvider.setDarkTheme();
themeProvider.setSystemTheme();
themeProvider.toggleTheme();

// Get current mode
themeProvider.themeMode
themeProvider.isDarkMode
themeProvider.getThemeModeString()
```

### Using Custom Widgets

```dart
// Header
CustomHeader(
  title: 'Title',
  subtitle: 'Subtitle',
)

// Demo Card
DemoCard(
  title: 'Card Title',
  description: 'Card description',
  icon: Icon(Icons.star),
  onTap: () {},
)

// Responsive Grid
ResponsiveGrid(
  mobileColumns: 1,
  tabletColumns: 2,
  desktopColumns: 3,
  children: [...],
)
```

## 🔧 Theme Customization

### Change Primary Color

Edit `lib/themes/app_theme.dart`:
```dart
class AppColors {
  static const Color primary = Color(0xFF6200EE); // Change this
}
```

### Update Light Theme

Edit `lib/themes/light_theme.dart`:
```dart
ThemeData lightTheme() {
  return ThemeData(
    // Modify styling here
    elevatedButtonTheme: ...,
    cardTheme: ...,
  );
}
```

### Add New Color

```dart
class AppColors {
  static const Color myCustomColor = Color(0xFFHEXVALUE);
}

// Use anywhere
Color color = AppColors.myCustomColor;
```

## 🔄 Hot Reload Commands

| Command | Effect |
|---------|--------|
| `r` | Hot reload (keeps state) |
| `R` | Hot restart (resets state) |
| `q` | Quit app |

## 📱 Responsive Breakpoints

```dart
AppBreakpoints.mobileMax     // 600.0 (max for mobile)
AppBreakpoints.tabletMin     // 600.0 (min for tablet)
AppBreakpoints.tabletMax     // 1200.0 (max for tablet)
AppBreakpoints.desktopMin    // 1200.0 (min for desktop)

// Usage
if (screenWidth < AppBreakpoints.tabletMin) {
  // Mobile layout
} else if (screenWidth < AppBreakpoints.desktopMin) {
  // Tablet layout
} else {
  // Desktop layout
}
```

## 🎯 File Locations

```
lib/
├── main.dart                    - App entry point
├── providers/
│   └── theme_provider.dart      - State management
├── themes/
│   ├── app_theme.dart          - Constants
│   ├── light_theme.dart        - Light theme
│   └── dark_theme.dart         - Dark theme
├── screens/
│   ├── home_screen.dart        - Home page
│   ├── form_screen.dart        - Forms demo
│   ├── components_screen.dart  - Components
│   └── settings_screen.dart    - Settings
└── widgets/
    └── custom_widgets.dart     - Custom widgets
```

## 🧪 Testing the App

### Manual Testing Checklist

- [ ] App launches without errors
- [ ] Home screen displays correctly
- [ ] All buttons are clickable
- [ ] Form validation works
- [ ] Light theme applies correctly
- [ ] Dark theme applies correctly
- [ ] Theme persists after restart
- [ ] Navigation bar works
- [ ] All colors are visible
- [ ] Text is readable

## 🐛 Debugging Tips

### Enable Debug Logging
```bash
flutter run -v
```

### Hot Reload Not Working
```bash
# Use hot restart instead
R in terminal
```

### Theme Not Persisting
- Check `ThemeProvider.initialize()` is called in `main()`
- Verify SharedPreferences dependency is added

### Colors Not Updating
- Ensure widget is wrapped with `Consumer<ThemeProvider>`
- Use `Theme.of(context)` inside build method

## 📚 Documentation Files

| File | Purpose |
|------|---------|
| README.md | Comprehensive documentation |
| SETUP_GUIDE.md | Installation & setup steps |
| PROJECT_OVERVIEW.md | Project structure & stats |
| QUICK_REFERENCE.md | This quick guide |

## 🎨 Text Styles Reference

```dart
Theme.of(context).textTheme.displayLarge    // 57sp
Theme.of(context).textTheme.displayMedium   // 45sp
Theme.of(context).textTheme.headlineLarge   // 32sp
Theme.of(context).textTheme.headlineMedium  // 28sp
Theme.of(context).textTheme.titleLarge      // 22sp
Theme.of(context).textTheme.bodyLarge       // 16sp
Theme.of(context).textTheme.bodyMedium      // 14sp
Theme.of(context).textTheme.labelLarge      // 14sp
```

## 🔌 Dependencies

```yaml
provider: ^6.1.0             # State management
shared_preferences: ^2.2.2   # Local storage
flutter: Latest SDK
dart: 3.0.0+
```

## 💡 Pro Tips

1. **Always use Theme.of(context)** instead of hardcoded colors
2. **Wrap with Consumer** to listen to theme changes
3. **Use const constructors** for performance
4. **Test on multiple devices** for responsive design
5. **Use MediaQuery** for responsive layouts

## 🚀 Build & Deployment

### Build APK (Android)
```bash
flutter build apk --release
```

### Build IPA (iOS)
```bash
flutter build ios --release
```

### Build Web
```bash
flutter build web --release
```

## 📊 App Performance

| Metric | Value |
|--------|-------|
| Build Time | ~45 seconds |
| Hot Reload | <2 seconds |
| APK Size | 30-40MB |
| Memory | 80-120MB |

## 🎓 Learning Resources

- [Flutter Docs](https://flutter.dev/docs)
- [Material Design](https://material.io/design)
- [Provider Package](https://pub.dev/packages/provider)
- [Dart Language](https://dart.dev/guides)

## ❓ FAQ

**Q: How do I change the primary color?**
A: Edit `AppColors.primary` in `app_theme.dart`

**Q: How does theme persist?**
A: Uses SharedPreferences to save/restore theme preference

**Q: Can I add custom themes?**
A: Yes, create new `ThemeData` in `themes/` folder

**Q: How do I make the app responsive?**
A: Use `ResponsiveGrid` or check `MediaQuery.of(context).size.width`

**Q: Where should I avoid hardcoded colors?**
A: Everywhere! Always use `Theme.of(context)` or `AppColors`

---

**Version**: 1.0.0
**Last Updated**: 2024
