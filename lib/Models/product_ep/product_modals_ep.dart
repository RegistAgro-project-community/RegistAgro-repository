import 'package:projecto_registagro/Models/profile_ep/profile_modals_ep.dart';

class Product {
  final String id;
  final String title;
  final String price;
  final String image;
  final String description;
  final String subTitle;
  final String category;
  final String province;
  final String quantity;
  final String stockStatus;
  final String recommendedTransport;
  final ProfileModel supplier;

  Product({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.price,
    required this.image,
    required this.description,
    required this.category,
    required this.province,
    required this.quantity,
    required this.recommendedTransport,
    required this.supplier,
    String? stockStatus,
  }) : stockStatus =
        (stockStatus == null || stockStatus.trim().isEmpty)
            ? "Desconhecido"
            : stockStatus;
}
