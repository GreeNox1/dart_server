class SignUpDto {
  SignUpDto({
    required this.email,
    required this.username,
    required this.password,
  });

  String email;
  String username;
  String password;

  factory SignUpDto.fromJson(Map<String, Object?> json) {
    return SignUpDto(
      email: json['email'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'email': email,
      'username': username,
      'password': password,
    };
  }

  @override
  int get hashCode => Object.hash(email, username, password);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    if (other is SignUpDto) {
      return runtimeType == other.runtimeType &&
          email == other.email &&
          username == other.username &&
          password == other.password;
    }

    return false;
  }

  @override
  String toString() {
    return 'SignUpDto(email: $email, username: $username, password: $password)\n';
  }
}
