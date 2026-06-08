/// User Model
/// This model represents a user in the application.
/// Used for demonstrating data passing between screens.
class User {
  final String name;
  final int age;
  final String email;
  final String city;

  /// Constructor for User model
  User({
    required this.name,
    required this.age,
    required this.email,
    required this.city,
  });

  /// Copy with method for creating modified copies of User
  /// Useful when updating user data
  User copyWith({String? name, int? age, String? email, String? city}) {
    return User(
      name: name ?? this.name,
      age: age ?? this.age,
      email: email ?? this.email,
      city: city ?? this.city,
    );
  }

  /// Convert User to string for display
  @override
  String toString() =>
      'User(name: $name, age: $age, email: $email, city: $city)';
}
