// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop_app/models/store.dart';

import '../models/brand.dart';

class Product with ChangeNotifier {
  final int? id;
  final Brand? brand;
  final String? model;
  final double? price;
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
    this.price,
    this.rating,
    this.imageUrls,
    this.color,
    this.type,
    this.gender,
    this.store,
    this.border,
    this.shape,
  });
}
