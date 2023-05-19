// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

import 'brand.dart';

class Product with ChangeNotifier {
  final String? id;
  final Brand? brand;
  final String? model;
  final double? price;
  final List<String>? imageUrls;
  final String? color;
  final String? type;
  final String? gender;
  final String? store;
  final String? border;
  final String? shape;

  Product({
    this.id,
    this.brand,
    this.model,
    this.price,
    this.imageUrls,
    this.color,
    this.type,
    this.gender,
    this.store,
    this.border,
    this.shape,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'brand': brand?.toMap(),
      'model': model,
      'price': price,
      'imageUrls': imageUrls,
      'color': color,
      'type': type,
      'gender': gender,
      'store': store,
      'border': border,
      'shape': shape,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] != null ? map['id'] as String : null,
      brand: map['brand'] != null
          ? Brand.fromMap(map['brand'] as Map<String, dynamic>)
          : null,
      model: map['model'] != null ? map['model'] as String : null,
      price: map['price'] != null ? map['price'] as double : null,
      imageUrls: map['imageUrls'] != null
          ? List<String>.from((map['imageUrls'] as List<String>))
          : null,
      color: map['color'] != null ? map['color'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      store: map['store'] != null ? map['store'] as String : null,
      border: map['border'] != null ? map['border'] as String : null,
      shape: map['shape'] != null ? map['shape'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);
}
