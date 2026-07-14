import '../../data/models/user_model.dart';

class RegisteredUserModel {
  final String id;
  final String fullName;
  final String email;
  final String password;
  final String? avatar;
  final String? bio;
  final String? phone;
  final DateTime createdAt;

  RegisteredUserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.password,
    this.avatar,
    this.bio,
    this.phone,
    required this.createdAt,
  });

  factory RegisteredUserModel.fromMap(Map<dynamic, dynamic> map) {
    return RegisteredUserModel(
      id: map['id'] as String,
      fullName: map['full_name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      avatar: map['avatar'] as String?,
      bio: map['bio'] as String?,
      phone: map['phone'] as String?,
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'full_name': fullName,
      'email': email,
      'password': password,
      'avatar': avatar,
      'bio': bio,
      'phone': phone,
      'created_at': createdAt.toIso8601String(),
    };
  }

  UserModel toUserModel() {
    return UserModel(
      id: id,
      fullName: fullName,
      email: email,
      avatar: avatar,
      bio: bio,
      phone: phone,
      createdAt: createdAt,
    );
  }

  RegisteredUserModel copyWith({
    String? fullName,
    String? email,
    String? password,
    String? avatar,
    String? bio,
    String? phone,
  }) {
    return RegisteredUserModel(
      id: id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      avatar: avatar ?? this.avatar,
      bio: bio ?? this.bio,
      phone: phone ?? this.phone,
      createdAt: createdAt,
    );
  }
}
