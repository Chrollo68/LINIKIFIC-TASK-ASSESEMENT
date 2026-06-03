# Flutter Layout Showcase

## Project Overview

Flutter Layout Showcase is a clean Flutter application built to demonstrate advanced layout widgets, responsive design, and modern Material 3 experiences. The app includes multiple example screens that showcase real-world UI patterns such as an Instagram-style post, chat UI, e-commerce gallery, dashboard, settings page, and stack-based layered layouts.

## Features

- Clean Material 3 theme with adaptive typography
- Home screen navigation to eight layout examples
- Responsive layouts for mobile, tablet, and desktop
- Reusable widgets and consistent spacing
- Performance-friendly scrolling using builder widgets

## Layout Demonstrations

### Instagram Post Card

The Instagram Post Card screen uses `Row`, `Column`, and `Expanded` to arrange the avatar row, image placeholder, action bar, and caption. The layout is responsive by switching between stacked and side-by-side content based on available width.

### WhatsApp Chat UI

The WhatsApp Chat UI uses `ListView.builder` to render a scrollable chat history. Each message is rendered with custom alignment and decoration for sent and received bubbles.

### E-Commerce Product Grid

The E-Commerce Product Grid uses `GridView` and responsive column counts to display product cards with image placeholders, price, rating, and an add-to-cart button.

### Settings Screen

The Settings screen uses `ListTile`, `SwitchListTile`, and category headers to organize profile settings and toggles with modern spacing and dividers.

### Dashboard Screen

The Dashboard screen demonstrates nested layouts with `Rows`, `Columns`, responsive statistics cards, quick actions, and a recent activity list.

### Stack UI Demo

The Stack UI Demo uses `Stack`, `Positioned`, and layered widgets to build a hero banner, profile badge, notification badge, and floating action card.

## Widget Hierarchy

A simplified widget tree for the home screen:

- `MaterialApp`
  - `HomeScreen`
    - `SafeArea`
      - `ListView`
        - `Card`
        - `ListTile`
        - `Divider`

## Challenges Faced

- Creating adaptive layouts for mobile, tablet, and desktop
- Organizing nested `Row` and `Column` combinations for complex cards
- Maintaining smooth scrolling performance with large lists

## Key Learnings

- Row and Column composition for flexible layouts
- Using Expanded and Flexible for proportional spacing
- Building layered UIs with Stack and Positioned
- Efficient long lists with ListView.builder
- Responsive grids with GridView.builder and LayoutBuilder
- Theme-driven design using Material 3

## Reusable Layout Patterns

- `SectionHeader` for screen titles
- `ProductCard` for grid item presentation
- `StatisticCard` for dashboard metrics
- `ChatBubble` for sent and received messages

## Screenshots Section

Include your own screenshots of each example screen once the app is running.

## How to Run

1. Install Flutter SDK: https://flutter.dev/docs/get-started/install
2. Open the `DAY_4` folder in your IDE
3. Run `flutter pub get`
4. Launch with `flutter run`

## Folder Structure

- `lib/`
  - `app.dart`
  - `main.dart`
  - `theme/app_theme.dart`
  - `models/product.dart`
  - `screens/`
  - `widgets/`
- `pubspec.yaml`
- `README.md`
