import 'package:flutter/material.dart';
import 'brand.dart';

class Product with ChangeNotifier {
  final String? id;
  final Brand? brand;
  final String? model;
  final double? price;
  final List<String>? imageUrls;
  final List<String>? colors;
  final String? type;
  final String? gender;
  final String? store;
  final String? border;
  final String? shape;
  

  Product(
      {this.id,
      this.brand,
      this.model,
      this.price,
      this.imageUrls,
      this.colors,
      this.type,
      this.gender,
      this.store,
      this.border,
      this.shape,
      });

    
}


