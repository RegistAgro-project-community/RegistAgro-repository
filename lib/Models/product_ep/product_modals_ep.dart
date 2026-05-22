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

class FarmPorducts {
  final ProfileModel farm;
  final List<Product> products;

  FarmPorducts({required this.farm, required this.products});

  factory FarmPorducts.fromJson(Map<String, dynamic> json) {
    return FarmPorducts(
      farm: ProfileModel.fromJson((json['farm'] as Map<String, dynamic>?) ?? {}),
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
  final ProfileModel? farm;

  Product({
    required this.id,
    required this.name,
    this.description,
    this.price,
    this.type,
    this.qtd,
    this.unit,
    this.transport,
    this.photo,
    this.farm,
  }); 

  factory Product.fromJson(Map<String, dynamic> json, {ProfileModel? farm}) {
    return Product(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? 'Produto sem nome',
      description: json['description'] as String?,
      price: json['price'] as String,
      type: json['type'] as String?,
      qtd: json['qtd'] ?? '0',
      unit: json['unit'] as String?,
      transport: json['transport'] as String?,
      photo: json['photo'] as String?,
      farm: farm,
    );
  }

  Product copyWith({
    String? id,
    String? name,
    String? description,
    String? price,
    String? type,
    String? qtd,
    String? unit,
    String? transport,
    String? photo,
    ProfileModel? farm,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      type: type ?? this.type,
      qtd: qtd ?? this.qtd,
      unit: unit ?? this.unit,
      transport: transport ?? this.transport,
      photo: photo ?? this.photo,
      farm: farm ?? this.farm,
    );
  }
}
