import 'package:projecto_registagro/Models/profile_ep/profile_modals_ep.dart';

class DataKeys {
  final ProfileModel farm;
  final List<Product> products;

  DataKeys({required this.farm, required this.products});

  factory DataKeys.fromJson(Map<String, dynamic> json) {
    return DataKeys(
      farm: ProfileModel.fromJson(
        (json['farm'] as Map<String, dynamic>?) ?? {},
      ),
      products: (json['products'] as List<dynamic>? ?? [])
          .map((p) => Product.fromJson(p as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Product {
  final String id;
  final String name;
  final String? description;
  final String? price;
  final String? type;
  final String? qtd;
  final String? unit;
  final String? transport;
  final String? photo;
  //final ProfileModel? farm;

  Product({
    //required this.farm,
    required this.id,
    required this.name,
    this.description,
    this.price,
    this.type,
    this.qtd,
    this.unit,
    this.transport,
    this.photo,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      //farm: ProfileModel.fromJson(json['farm'] as Map<String, dynamic>),
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? 'Produto sem nome',
      description: json['description'] as String?,
      price: json['price'] as String,
      type: json['type'] as String?,
      qtd: json['qtd'] ?? '0',
      unit: json['unit'] as String?,
      transport: json['transport'] as String?,
      photo: json['photo'] as String?,
    );
  }
}
