# Flutter Fundamentals Demo

## Project Overview

This beginner-friendly Flutter project demonstrates fundamental Flutter concepts across four screens:

- **Home Screen**: Navigation hub with screen descriptions.
- **Profile Card Screen**: A `StatelessWidget` showing a styled profile card.
- **Simple Form Screen**: A `StatefulWidget` with validation and submitted information display.
- **Item List Screen**: A `ListView.builder` screen showing 20+ items inside `Card` and `ListTile` widgets.

The app is structured with separate folders for `/screens`, `/widgets`, and `/models` to keep the code organized and maintainable.

## Flutter Concepts Learned

- `MaterialApp`
- `Scaffold`
- `AppBar`
- `Text` and `RichText`
- `Container`
- `Row` and `Column`
- `Stack`
- `Padding`
- `Center`
- `SizedBox`
- `Expanded` and `Flexible`
- `Spacer`
- `ListView` and `ListView.builder`
- `Navigator.push` and `Navigator.pop`
- `BuildContext`
- `StatelessWidget`
- `StatefulWidget`
- `setState()`

## Widget Tree Explanation

The app uses a clear widget hierarchy:

- `MaterialApp`
  - `HomeScreen`
    - `Scaffold`
      - `AppBar`
      - `Column`
        - `ScreenDescription` (`StatelessWidget`)
        - `Container` with `Stack`
        - `Expanded` with `ListView`

Each screen follows the same `Scaffold` pattern to keep the layout consistent and easy to understand.

## StatelessWidget vs StatefulWidget

- **`StatelessWidget`**: Used when the UI does not need to change after it is built. Example: `ProfileCardScreen`.
- **`StatefulWidget`**: Used when the UI reacts to user input or other state changes. Example: `SimpleFormScreen` tracks form input and submission state.

## BuildContext Explanation

`BuildContext` is passed into `build()` methods and used by Flutter to locate theme data, navigation routes, and widget ancestors.

Examples in this app:

- `Navigator.push(context, ...)`
- `ScaffoldMessenger.of(context).showSnackBar(...)`
- `Theme.of(context)`

## Navigation Explanation

The app uses `Navigator.push` to open new screens and `Navigator.pop` to return to the previous screen.

Example:

```dart
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const ItemListScreen()),
);
```

The `SimpleFormScreen` and `ItemListScreen` also allow returning to home using `Navigator.pop(context)`.

## Project Structure

- `lib/main.dart` - Entry point for the app.
- `lib/screens/home_screen.dart` - Home screen with navigation buttons.
- `lib/screens/profile_card_screen.dart` - Profile card layout.
- `lib/screens/simple_form_screen.dart` - Form screen with validation.
- `lib/screens/item_list_screen.dart` - List view example with SnackBar.
- `lib/widgets/screen_description.dart` - Reusable widget for screen descriptions.
- `lib/models/user_profile.dart` - Profile data model.
- `lib/models/form_submission.dart` - Form submission model.
- `lib/models/list_item.dart` - Item list model.

## How to Run the Project

1. Install Flutter: https://flutter.dev/docs/get-started/install
2. Open a terminal in the project folder: `d:\Linikific Task\DAY_3`
3. Get dependencies:

```bash
flutter pub get
```

4. Run the app:

```bash
flutter run
```

5. To target a specific device, use `flutter devices` and then `flutter run -d <device_id>`.

## Git Commands Used

```bash
git init
git add .
git commit -m "Initial Flutter setup"
git commit -m "Added home screen"
git commit -m "Added profile card screen"
git commit -m "Added simple form screen"
git commit -m "Added item list screen"
git commit -m "Implemented navigation"
git commit -m "Added widget descriptions and screen explanations"
git commit -m "Added models and reusable widget components"
git commit -m "Improved UI styling and layout"
git commit -m "Added README with Flutter fundamentals"
git commit -m "Added SnackBar support for item taps"
git commit -m "Final cleanup and comments"
```

> Note: If you want to create this history manually, make each commit after applying the described feature change.

## Expected Screenshots Descriptions

1. **Home Screen**: Shows navigation buttons, a description card, and a list of screen explanations.
2. **Profile Card Screen**: Displays a circular avatar, name, email, job title, and styled card layout.
3. **Simple Form Screen**: Shows a name field, email field, submit button, and displayed submission results after valid input.
4. **Item List Screen**: Displays at least 20 items with cards and list tiles, and a SnackBar appears when an item is tapped.

## Notes

This project is designed to be beginner-friendly and showcase a strong Flutter fundamentals portfolio sample. The code is separated into screens, widgets, and models for clarity and reuse.
