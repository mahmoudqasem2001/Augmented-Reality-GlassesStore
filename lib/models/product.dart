// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:shop_app/models/store.dart';

import 'brand.dart';

class Product  {
  final int? id;
  final Brand? brand;
  final String? model;
  final String? description;
  final double? price;
  final int? quantity;
  final double? rating;
  final List<String>? imageUrls;
  final String? color;
  final String? type;
  final String? gender;
  final Store? store;
  final String? border;
  final String? shape;

  Product({
    this.id,
    this.brand,
    this.model,
    this.description,
    this.price,
    this.quantity,
    this.rating,
    this.imageUrls,
    this.color,
    this.type,
    this.gender,
    this.store,
    this.border,
    this.shape,
  });

  get getId => id;
}
