import '../models/user_model.dart';

abstract interface class IUserRepository {

  UserModel? findByEmail(String email);

  bool existsByEmail(String email);

  void save(UserModel user);
}

class UserRepositoryImpl implements IUserRepository {
  final List<UserModel?> _users = [];

  @override
  bool existsByEmail(String email) {
    return _users.any((user) => user?.email == email);
  }

  @override
  UserModel? findByEmail(String email) {
    return _users.firstWhere((user) => user?.email == email, orElse: () => null,);
  }

  @override
  void save(UserModel user) {
    _users.add(user);
  }

}