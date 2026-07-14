class UserModel {
  final String id;
  final String fullName;
  final String email;
  final String? avatar;
  final String? bio;
  final String? phone;
  final DateTime? createdAt;

  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    this.avatar,
    this.bio,
    this.phone,
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      fullName: json['full_name'] ?? '',
      email: json['email'] ?? '',
      avatar: json['avatar'],
      bio: json['bio'],
      phone: json['phone'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'email': email,
      'avatar': avatar,
      'bio': bio,
      'phone': phone,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  UserModel copyWith({
    String? id,
    String? fullName,
    String? email,
    String? avatar,
    String? bio,
    String? phone,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      bio: bio ?? this.bio,
      phone: phone ?? this.phone,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
