class UserModel {
  final String name;
  final String email;
  final String phone;
  final String bio;
  final String? photoPath;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.bio,
    this.photoPath,
  });

  UserModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? bio,
    String? photoPath,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      bio: bio ?? this.bio,
      photoPath: photoPath ?? this.photoPath,
    );
  }
}