# Material Design Showcase App

A complete Flutter application that demonstrates Material Design 3 components, multi-screen navigation, input validation, dialogs, snackbars, banners, and modern Material theming.

## Project Overview

Material Design is a design system created by Google that emphasizes tactile surfaces, meaningful motion, and adaptable interfaces. This app shows how Flutter brings Material 3 to life with expressive components, responsive layouts, and consistent theming.

## Material 3

- **Dynamic Colors**: In Flutter Material 3, color schemes are derived from a seed color and adapt as the theme changes. This app uses a Material 3 color palette with a deep purple seed.
- **Typography**: Material 3 improves text hierarchy and legibility with updated typography styles, such as `headlineSmall`, `titleMedium`, and `bodyLarge`.
- **Components**: Material 3 includes updated buttons, cards, dialogs, banners, and floating action buttons with new surfaces and elevation.
- **Theming**: The theme is configured with `ThemeData(useMaterial3: true)` to enable the modern Material design system.

## Widgets Used

- **ElevatedButton**: A raised button used for primary actions and interactive controls.
- **TextButton**: A text-based button used for lower-emphasis actions.
- **OutlinedButton**: A button with an outline border for secondary actions.
- **IconButton**: A compact button that displays an icon and triggers actions.
- **FloatingActionButton**: A circular or extended action button for prominent tasks.
- **Card**: A surface container that highlights content using elevation and shape.
- **ListTile**: A row layout with leading icons, titles, subtitles, and trailing actions.
- **AlertDialog**: A modal dialog for confirming actions or displaying important information.
- **SimpleDialog**: A modal dialog presenting a list of selectable options.
- **SnackBar**: A lightweight message that appears at the bottom of the screen.
- **MaterialBanner**: A persistent banner shown at the top of content for important messages.
- **TextFormField**: A form field with validation and input decoration.
- **Navigator**: The navigation system for moving between screens in the app.

## Navigation Concepts

- **Navigator.push()**: Pushes a new route onto the navigation stack so the user can move forward to a new screen.
- **Navigator.pop()**: Removes the current route from the stack to return to the previous screen.
- **Named Routes**: Routes are registered with names such as `/`, `/buttons`, `/forms`, and `/success` to simplify navigation and route handling.
- **Passing Data**: The app passes the user's name from the form screen to the success screen using route arguments.

## Form Validation

- **Form**: A container that groups multiple form fields and manages validation state.
- **GlobalKey**: Used to identify and validate the form state from outside the widget tree.
- **Validators**: Functions attached to `TextFormField` to enforce rules like non-empty input, valid email, and matching passwords.
- **InputDecoration**: Styling and labeling for text fields, including icons, hints, and error messages.

## Project Structure

```
DAY_5/
  pubspec.yaml
  README.md
  lib/
    main.dart
    theme/
      app_theme.dart
    screens/
      home_screen.dart
      buttons_showcase_screen.dart
      cards_listtiles_screen.dart
      forms_showcase_screen.dart
      dialogs_showcase_screen.dart
      snackbar_banner_screen.dart
      profile_screen.dart
      success_screen.dart
```

## Learning Outcomes

This project demonstrates how to build a polished Flutter app with Material 3 theming, navigation between multiple screens, validated forms, actionable dialogs, interactive snackbars, and modern UI components. You learn how to structure a Flutter app cleanly, manage named routes, pass data between pages, and use common Material widgets in production quality code.
