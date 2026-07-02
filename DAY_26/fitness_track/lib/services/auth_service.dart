import '../models/user_model.dart';

class AuthService {
  AuthService() {
    _users = [
      const UserModel(
        id: '1',
        name: 'Admin User',
        email: 'admin@gmail.com',
        password: '123456',
        height: 176,
        weight: 72,
      ),
    ];
  }

  late final List<UserModel> _users;
  UserModel? currentUser;

  Future<UserModel?> login(String email, String password) async {
    await Future<void>.delayed(const Duration(milliseconds: 700));
    final match = _users
        .where((user) => user.email == email && user.password == password)
        .firstOrNull;
    if (match != null) {
      currentUser = match;
      return match;
    }
    return null;
  }

  Future<UserModel?> register(
    String name,
    String email,
    String password,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 700));
    final exists = _users.any((user) => user.email == email);
    if (exists) {
      return null;
    }

    final newUser = UserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      email: email,
      password: password,
    );
    _users.add(newUser);
    currentUser = newUser;
    return newUser;
  }

  Future<void> logout() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    currentUser = null;
  }
}

extension IterableX<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
