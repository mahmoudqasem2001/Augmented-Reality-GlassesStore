import 'package:flutter/material.dart';

class Home with ChangeNotifier{
    int _bottomBarSelectedIndex = 0;

int get bottomBarSelectedIndex {
    return _bottomBarSelectedIndex;
  }

  void setBottomBarSelectedIndex(index) {
    _bottomBarSelectedIndex = index;
    notifyListeners();
  }
}