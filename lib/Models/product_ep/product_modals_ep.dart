import 'package:projecto_registagro/Models/profile_ep/profile_modals_ep.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final String price;
  final String type;
  final String qtd;
  final String unit;
  final String transport;
  final String photo;
  final ProfileModel farm;

  Product({
    required this.farm,
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.type,
    required this.qtd,
    required this.unit,
    required this.transport,
    required this.photo,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      farm: json['farm'],
      id: json['id'],
      name: json['name'],
      description: json['description'],
      photo: json['photo'],
      price: json['price'],
      type: json['type'],
      qtd: json['qtd'],
      unit: json['unit'],
      transport: json['transport'],
    );
  }
}
