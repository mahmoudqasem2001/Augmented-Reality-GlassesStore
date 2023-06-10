import 'package:flutter/material.dart';
import 'package:shop_app/models/account.dart';
import 'package:shop_app/models/store.dart';

class Stores with ChangeNotifier {
  final List<Store> _stores = [
    Store(
      id: 1,
      name: 'ALKHALDY',
      phoneNumber: '0599344870',
      address: 'Jenin',
      account:
          Account(email: 'mahmoodqasim543@gmail.com', password: '123456789'),
    ),
    Store(
      id: 2,
      name: 'SHAMS',
      phoneNumber: '0599344870',
      address: 'Jenin',
      account:
          Account(email: 'mahmoodqasim543@gmail.com', password: '123456789'),
    ),
    Store(
      id: 3,
      name: 'TWEEN',
      phoneNumber: '0599344870',
      address: 'Jenin',
      account:
          Account(email: 'mahmoodqasim543@gmail.com', password: '123456789'),
    ),
    Store(
      id: 4,
      name: 'QUEEN',
      phoneNumber: '0599344870',
      address: 'Jenin',
      account:
          Account(email: 'mahmoodqasim543@gmail.com', password: '123456789'),
    ),
    Store(
      id: 5,
      name: 'QUEEN',
      phoneNumber: '0599344870',
      address: 'Jenin',
      account:
          Account(email: 'mahmoodqasim543@gmail.com', password: '123456789'),
    ),
  ];

  final Store _store = Store();

  get store {
    return _store;
  }

  List<Store> get stores {
    return _stores;
  }

  Store findById(String? id) {
    return _stores.firstWhere((store) => store.id == id);
  }
}
