class Order {
  final String id;
  final Farm farm;
  final OrderProduct product;
  final int qtd;
  final String unit;
  final String total;
  final String status;
  final String created_at;
  final String payment_status;

  Order({
    required this.id,
    required this.farm,
    required this.product,
    required this.qtd,
    required this.unit,
    required this.total,
    required this.status,
    required this.created_at,
    required this.payment_status
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json["id"] as String,
      farm: Farm.fromJson((json['farm'] as Map<String, dynamic>?) ?? {}),
      product: OrderProduct.fromJson(
        (json['product'] as Map<String, dynamic>?) ?? {},
      ),
      qtd: json['qtd'],
      unit: json['unit'],
      total: json['total'],
      status: json['status'],
      created_at: json['created_at'],
      payment_status: json["payment_status"]
    );
  }
}

class Farm {
  final String name;
  final String profile;

  Farm({required this.name, required this.profile});

  factory Farm.fromJson(Map<String, dynamic> json) {
    return Farm(name: json['name'], profile: json['profile']);
  }
}

class OrderProduct {
  final String name;
  final String photo;
  final String type;

  OrderProduct({required this.name, required this.photo, required this.type});

  factory OrderProduct.fromJson(Map<String, dynamic> json) {
    return OrderProduct(
      name: json['name'],
      photo: json['photo'],
      type: json['type'],
    );
  }
}

class OrderProof {
  final int reference;
  final String total;
  final String farmValue;
  final String transportValue;
  final String registagroValue;
  final String? message;

  OrderProof({
    required this.reference,
    required this.farmValue,
    required this.transportValue,
    required this.registagroValue,
    required this.total,
    this.message,
  });

  factory OrderProof.fromJson(Map<String, dynamic> json) {
    return OrderProof(
      reference: json["reference"],
      farmValue: json["farmValue"],
      transportValue: json["transportValue"],
      registagroValue: json["registagroValue"],
      total: json["total"],
    );
  }
}
