# DAY 7: Flutter State Management Examples

## Learning Objectives
- Understand state in Flutter
- Master `setState`
- Handle user interactions
- Build interactive UIs

## What’s included
- Counter app with `setState`
- Todo list with add, delete, toggle, and search
- Form example with `TextEditingController`, focus management, validation, and submit handling
- Quiz app with score tracking and stateful flow

## State Concepts

### What is state?
State is the data that determines how the UI looks and behaves. In Flutter, widgets can rebuild to reflect changes in state.

### Local vs app-wide state
- Local state: State used only by a single widget or screen, such as a counter value or form input.
- App-wide state: State shared across many widgets or screens, such as user authentication or theme preferences. This often requires a state management solution beyond `setState`.

### Ephemeral state
Ephemeral state is temporary UI state that lives in a widget and is not preserved long-term. Examples include the current value of a text field, the selected tab, or whether a checkbox is checked.

### When to use `setState`
Use `setState` for local, ephemeral state inside a `StatefulWidget`. It rebuilds the widget when state changes.

## Run the app
1. Open the `DAY_7` folder in VS Code.
2. Run `flutter pub get`.
3. Start the app with `flutter run`.

## Notes
- `CounterScreen` demonstrates basic `setState` updates.
- `TodoScreen` demonstrates list management, item CRUD, and search filtering.
- `FormScreen` demonstrates form state, input controllers, focus handling, and validation.
- `QuizScreen` demonstrates navigation through questions and score management.
