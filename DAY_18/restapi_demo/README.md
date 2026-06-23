# REST API Demo

A Flutter app demonstrating REST API consumption using `http` and JSON parsing.

## Features

- Fetches posts from the JSONPlaceholder public API
- Search posts by title using query parameters
- Pull-to-refresh list view
- Detailed post screen with comments
- Create a new post using POST
- Update a post using PUT
- Patch a post title using PATCH
- Delete a post using DELETE
- Handles loading states and error messages
- Uses headers, query parameters, timeout handling, and network error handling

## Packages

- `http` for REST API calls

## Project structure

- `lib/main.dart` - main app UI, search, list display, create post dialog
- `lib/services/api_service.dart` - REST API service, JSON parsing, error handling
- `lib/models/post.dart` - Post model with `fromJson()` and `toJson()`
- `lib/models/comment.dart` - Comment model with `fromJson()` and `toJson()`
- `lib/screens/post_detail_screen.dart` - post detail screen with comments and HTTP actions

## Getting Started

1. Open the project in a Flutter-compatible editor.
2. Run `flutter pub get`.
3. Run `flutter run`.

## Notes

- The app is built against JSONPlaceholder, a free REST API for testing.
- HTTP calls include custom headers and timeout handling.
- Error handling is implemented using `try/catch` and custom exceptions.
- The app demonstrates multiple HTTP methods and JSON serialization in Flutter.
