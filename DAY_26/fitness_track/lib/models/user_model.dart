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

  final int id;
  final String name;
  final String email;
  final String password;
  final String? photoPath;
  final double height;
  final double weight;

  double get bmi => weight / ((height / 100) * (height / 100));

  /// Convert UserModel to JSON map
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'email': email, 'password': password};
  }

  /// Create UserModel from JSON map
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
    );
  }

  UserModel copyWith({
    int? id,
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
