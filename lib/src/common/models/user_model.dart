import 'package:dart_server/src/common/utils/enum/role.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String username;
  final String email;
  final String password;
  final Role role;

  UserModel({
    required this.username,
    required this.email,
    required this.password,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, Object?> json) {
    return UserModel(
      username: json['username'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      role: switch (json['role'] as String?) {
        "admin" => Role.admin,
        "root" => Role.root,
        _ => Role.user,
      },
    );
  }

  Map<String, Object?> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'role': role.name,
    };
  }

  List<String> get authorities => [role.name];

  @override
  List<Object?> get props => [
        password,
        username,
        email,
        role,
      ];
}
