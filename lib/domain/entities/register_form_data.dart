class RegisterFormData {
  final String email;
  final String password;
  final String name;
  final String? phoneNumber;

  RegisterFormData({
    required this.email,
    required this.password,
    required this.name,
    this.phoneNumber,
  });

  RegisterFormData copyWith({
    String? email,
    String? password,
    String? name,
    String? phoneNumber,
  }) {
    return RegisterFormData(
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}
