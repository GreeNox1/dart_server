class SignUpDto {
  SignUpDto({
    required this.email,
    required this.password,
  });

  String email;
  String password;

  factory SignUpDto.fromJson(Map<String, Object?> json) {
    return SignUpDto(
      email: json['email'] as String,
      password: json['password'] as String,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }

  @override
  int get hashCode => Object.hash(email, password);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    if (other is SignUpDto) {
      return runtimeType == other.runtimeType &&
          email == other.email &&
          password == other.password;
    }

    return false;
  }

  @override
  String toString() {
    return 'SignUpDto(email: $email, password: $password)\n';
  }
}
