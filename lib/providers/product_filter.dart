import 'package:flutter/material.dart';
import 'products.dart' ;
class ProductFilter with ChangeNotifier {
  double _minPrice=0;
  double _maxPrice=0;
  List<String> _genders = [];

  double get minPrice => _minPrice;
  double get maxPrice => _maxPrice;
  List<String> get genders => _genders;

  void applyFilter(List<String> genders, double minPrice, double maxPrice) {
    _genders = genders;
    _minPrice = minPrice;
    _maxPrice = maxPrice;
  
    notifyListeners();
  }

  void clearFilter() {
    _genders.clear();
    _minPrice = 0;
    _maxPrice = 0;
    notifyListeners();
  }
}
