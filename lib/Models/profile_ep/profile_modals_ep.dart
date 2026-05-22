class ProfileModel {
  final String id;
  final String profile;
  final String name;
  final String? email;
  final String? bio;
  final String? phone;
  final String? province;
  final String? adress;
  final String? nif;

  ProfileModel({
    required this.id,
    required this.name,
    required this.profile,
    this.adress,
    this.bio,
    this.email,
    this.phone,
    this.province,
    this.nif
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] as String? ?? "",
      name: json['name'] as String? ?? "Sem nome",
      profile: json['profile'] as String? ?? json["photo"] as String,
      adress: json["adress"] as String? ?? "Sem endereço",
      email: json["email"] as String? ?? "Sem email",
      phone: json["phone"] as String? ?? "Sem telefone",
      province: json["province"] as String? ?? "Sem província",
      nif: json["nif"] as String? ?? "Sem NIF"
    );
  }
}
