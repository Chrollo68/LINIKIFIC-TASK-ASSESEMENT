// Demonstrates Dart classes and objects with a user profile model.
// Run with: dart run oop/classes_objects_demo.dart

class User {
  String name;
  int age;

  User(this.name, this.age);

  void describe() {
    print('User name: $name, age: $age');
  }
}

void main() {
  User user = User('Maya', 27);
  user.describe();
}
