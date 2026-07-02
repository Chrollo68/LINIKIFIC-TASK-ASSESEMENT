class UserModel {
  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    this.photoPath,
    this.height = 175,
    this.weight = 70,
  });

  final String id;
  final String name;
  final String email;
  final String password;
  final String? photoPath;
  final double height;
  final double weight;

  double get bmi => weight / ((height / 100) * (height / 100));

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? photoPath,
    double? height,
    double? weight,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      photoPath: photoPath ?? this.photoPath,
      height: height ?? this.height,
      weight: weight ?? this.weight,
    );
  }
}
