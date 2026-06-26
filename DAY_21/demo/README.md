# Flutter Package Demo

A small Flutter application built for a college practical presentation.

## Packages used

1. GetX
   - Purpose:
     - State management
     - Navigation
     - Dependency injection

2. Dio
   - Purpose:
     - API communication
     - Better HTTP handling

3. Hive
   - Purpose:
     - Local NoSQL storage

4. Share Plus
   - Purpose:
     - Sharing content

5. URL Launcher
   - Purpose:
     - Opening external links

## Project Structure

lib/
│
├── main.dart
│
├── controllers/
│   └── counter_controller.dart
│
├── services/
│   ├── api_service.dart
│   └── hive_service.dart
│
├── screens/
│   ├── home_screen.dart
│   ├── api_screen.dart
│   └── storage_screen.dart
│
└── utils/
    └── helpers.dart

## Features

- Counter demo with GetX reactive state management
- API demo using Dio to fetch data from `jsonplaceholder.typicode.com`
- Hive local storage demo with save and load functionality
- Share app text using Share Plus
- Launch external URL using URL Launcher

## Comparisons

### GetX vs Provider
- GetX has less boilerplate.
- Provider is more Flutter-standard.

### Dio vs HTTP
- Dio provides interceptors, cancellation, and advanced features.
- HTTP is simpler for basic requests.

### Hive vs SQLite
- Hive is lightweight and fast.
- SQLite supports relational queries.

## Running the app

1. Open the project in VS Code or your IDE.
2. Run `flutter pub get`.
3. Run the app with `flutter run`.

This demo is designed to be simple, clean, and easy to present.
