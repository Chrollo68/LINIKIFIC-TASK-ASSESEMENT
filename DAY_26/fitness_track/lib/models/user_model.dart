class UserModel {
  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    this.authId,
    this.photoPath,
    this.height = 175.0,
    this.weight = 70.0,
  });

  final int id;
  final String name;
  final String email;
  final String password;
  final String? authId;
  final String? photoPath;
  final double height;
  final double weight;

  double get bmi => weight / ((height / 100) * (height / 100));

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'auth_id': authId,
      'height': height,
      'weight': weight,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final idValue = json['id'];
    final parsedId = idValue is int
        ? idValue
        : int.tryParse(idValue?.toString() ?? '') ?? 0;

    final heightValue = json['height'];
    final weightValue = json['weight'];

    return UserModel(
      id: parsedId,
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      password: json['password']?.toString() ?? '',
      authId: json['auth_id']?.toString(),
      photoPath: json['photo_path']?.toString(),
      height: heightValue is num ? heightValue.toDouble() : 175.0,
      weight: weightValue is num ? weightValue.toDouble() : 70.0,
    );
  }

  UserModel copyWith({
    int? id,
    String? name,
    String? email,
    String? password,
    String? authId,
    String? photoPath,
    double? height,
    double? weight,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      authId: authId ?? this.authId,
      photoPath: photoPath ?? this.photoPath,
      height: height ?? this.height,
      weight: weight ?? this.weight,
    );
  }
}
