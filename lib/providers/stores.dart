import 'package:flutter/material.dart';
import 'package:shop_app/models/account.dart';
import 'package:shop_app/providers/store.dart';

class Stores with ChangeNotifier {
  final List<Store> _stores = [
    Store(
      id: 'a1',
      name: 'ALKHALDY',
      phoneNumber: '0599344870',
      address: 'Jenin',
      account:
          Account(email: 'mahmoodqasim543@gmail.com', password: '123456789'),
    ),
    Store(
      id: 'a2',
      name: 'SHAMS',
      phoneNumber: '0599344870',
      address: 'Jenin',
      account:
          Account(email: 'mahmoodqasim543@gmail.com', password: '123456789'),
    ),
    Store(
      id: 'a3',
      name: 'TWEEN',
      phoneNumber: '0599344870',
      address: 'Jenin',
      account:
          Account(email: 'mahmoodqasim543@gmail.com', password: '123456789'),
    ),
    Store(
      id: 'a4',
      name: 'QUEEN',
      phoneNumber: '0599344870',
      address: 'Jenin',
      account:
          Account(email: 'mahmoodqasim543@gmail.com', password: '123456789'),
    ),
    Store(
      id: 'a5',
      name: 'QUEEN',
      phoneNumber: '0599344870',
      address: 'Jenin',
      account:
          Account(email: 'mahmoodqasim543@gmail.com', password: '123456789'),
    ),
  ];
  List<Store> get stores {
    return _stores;
  }

  Store findById(String? id) {
    return _stores.firstWhere((store) => store.id == id);
  }
}
