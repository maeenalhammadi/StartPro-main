// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NewUserModel {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final DateTime? createdAt;

  NewUserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    this.createdAt,
  });

  NewUserModel copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    DateTime? createdAt,
  }) {
    return NewUserModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'createdAt': createdAt?.millisecondsSinceEpoch,
    };
  }

  factory NewUserModel.fromMap(Map<String, dynamic> map) {
    return NewUserModel(
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      createdAt: map['createdAt'] != null ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NewUserModel.fromJson(String source) => NewUserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NewUserModel(firstName: $firstName, lastName: $lastName, email: $email, password: $password, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant NewUserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.firstName == firstName &&
      other.lastName == lastName &&
      other.email == email &&
      other.password == password &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
      lastName.hashCode ^
      email.hashCode ^
      password.hashCode ^
      createdAt.hashCode;
  }
}
