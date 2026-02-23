class ProfileModel {
  final String id;
  final String profile;
  final String name;

  ProfileModel({required this.id, required this.name, required this.profile});

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      name: json['name'],
      profile: json['profile'],
    );
  }
}
