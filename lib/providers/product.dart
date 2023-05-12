import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String? id;
  final String? brand;
  final String? model;
  final double? price;
  final List<String>? imageUrls;
  final List<String>? colors;
  final String? type;
  final String? gender;
  final String? store;
  final String? border;
  final String? shape;
  bool isFavorite;

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
      this.isFavorite = false});

  bool _showAttributes = false;

  

  bool get showAttributes {
    return _showAttributes;
  }

  void toggleShowingAtrr() {
    _showAttributes = !_showAttributes;
    notifyListeners();
  }

  void _setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(String token, String userId) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();

    final url =
        'https://shop-43d63-default-rtdb.firebaseio.com/userFavorites/$userId/$id.json?auth=$token';

    try {
      final res = await http.put(Uri.parse(url), body: json.encode(isFavorite));
      if (res.statusCode >= 400) {
        _setFavValue(oldStatus);
      }
    } catch (e) {
      _setFavValue(oldStatus);
    }
  }
}
