import 'package:flutter/material.dart';

class General with ChangeNotifier {
  int _selectedIndex = 0;
  var _productQuantity = 0;

  get productQuantity {
    return _productQuantity;
  }

  int get selectedIndex {
    return _selectedIndex;
  }

  void setProductQuantity(var count) {
    _productQuantity = count;
    notifyListeners();
  }

  void setSelectedIndex(index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
