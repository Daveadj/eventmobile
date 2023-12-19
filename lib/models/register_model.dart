import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Register {
  final String firstName;
  final String lastName;
  final String userName;
  final String email;
  final String password;
  final String confirmPassword;
  Register({
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'userName': userName,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
    };
  }

  factory Register.fromMap(Map<String, dynamic> map) {
    return Register(
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      userName: map['userName'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      confirmPassword: map['confirmPassword'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Register.fromJson(String source) => Register.fromMap(json.decode(source) as Map<String, dynamic>);
}
