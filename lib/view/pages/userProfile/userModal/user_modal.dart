class UserModel {
  final String name;
  final String email;
  final String phone;
  final String? bio;
  final String? photoPath;
  final String province;
  final String adress;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    this.bio,
    required this.province,
    required this.adress,
    this.photoPath,
  });

  UserModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? province,
    String? adress,
    String? bio,
    String? photoPath,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      bio: bio ?? this.bio,
      photoPath: photoPath ?? this.photoPath,
      province: province ?? "",
      adress: adress ?? ""
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json, {UserModel? farm}) {
    return UserModel(
      name: json['name'] as String? ?? 'Sem nome',
      email: json['email'] as String,
      phone: json['phone'] as String,
      photoPath: json['profile'],
      province: json['province'] as String,
      adress: json['adress'] as String,
    );
  }
}
