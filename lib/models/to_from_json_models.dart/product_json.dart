import 'package:shop_app/models/to_from_json_models.dart/store_json.dart';

import 'brand_json.dart';

class ProductJson {
  final int id;
  final String description;
  final double price;
  final int rating;
  final StoreJson store;
  final BrandJson brand;
  final String model;
  final String color;
  final String type;
  final String gender;
  final String border;
  final String shape;

  ProductJson({
    required this.id,
    required this.description,
    required this.price,
    required this.rating,
    required this.store,
    required this.brand,
    required this.model,
    required this.color,
    required this.type,
    required this.gender,
    required this.border,
    required this.shape,
  });

  factory ProductJson.fromJson(Map<String, dynamic> json) {
    return ProductJson(
      id: json['id'],
      description: json['description'],
      price: json['price'].toDouble(),
      rating: json['rating'],
      store: StoreJson.fromJson(json['store']),
      brand: BrandJson.fromJson(json['brand']),
      model: json['model'],
      color: json['color'],
      type: json['type'],
      gender: json['gender'],
      border: json['border'],
      shape: json['shape'],
    );
  }
}
