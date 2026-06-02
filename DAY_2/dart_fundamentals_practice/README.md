# Dart Fundamentals Practice

This repository contains a collection of Dart examples and small console applications designed to demonstrate core language concepts, from basics and collections to object-oriented programming, null safety, asynchronous operations, and mini projects.

## Overview

The repository is organized into focused modules for learning Dart with runnable examples. Each file is self-contained and prints clear output to the console.

## Concepts Covered

- Variables, data types, and constants
- Operators, conditions, and loops
- Functions with positional, named, optional, and arrow syntax
- Lists, sets, maps, and collection literals
- List transformations and common list methods
- Classes, constructors, getters/setters, inheritance, abstract classes, interfaces, and mixins
- Null safety with nullable types, null-aware operators, `late`, and `required`
- Asynchronous programming with `Future`, `async`/`await`, `Stream`, and simulated API calls
- Console mini projects for everyday logic

## Folder Structure

```
dart_fundamentals_practice/
├── basics/
├── collections/
├── oop/
├── null_safety/
├── async/
├── mini_projects/
├── README.md
├── pubspec.yaml
```

## Sample Commands to Run

```bash
dart run basics/variables_demo.dart
dart run basics/loops_demo.dart
dart run collections/list_methods_demo.dart
dart run oop/inheritance_overriding_demo.dart
dart run null_safety/null_aware_demo.dart
dart run async/async_await_demo.dart
dart run mini_projects/todo_list_app.dart
```

## What I Learned

- Dart uses strong static typing with modern null safety.
- Functions can be defined with flexible parameter styles and meaningful return values.
- Dart collections support expressive operations like `map`, `where`, `reduce`, `sort`, and collection literals with `if`/`for`.
- Object-oriented design in Dart includes constructors, inheritance, and mixins.
- Async programming in Dart relies on `Future`, `async`/`await`, and streams for reactive patterns.

## Dart Syntax Summary

- `var`, `final`, and `const` for variable declarations
- Built-in types: `int`, `double`, `String`, `bool`, `List`, `Set`, `Map`
- `if`, `else`, `switch`, `for`, `while`, `for-in`, `forEach`
- Function signatures, optional and named arguments, and arrow functions

## OOP Summary

- Classes define blueprints and constructors initialize object state
- Getters/setters control property access
- Inheritance allows subclass specialization
- Abstract classes and mixins enable reusable behavior and interfaces

## Async/Await Summary

- `Future` models asynchronous operations
- `async` functions pause execution until results are ready
- `await` simplifies asynchronous workflows
- `Stream` supports sequences of events over time
