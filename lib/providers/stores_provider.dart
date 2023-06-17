import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shop_app/models/store.dart';
import 'package:http/http.dart' as http;
import '../core/api/status_code.dart';
import '../models/brand.dart';
import '../shared/constants/constants.dart';

class Stores with ChangeNotifier {
  List<Store> _stores = [];
  List<Brand> _brands = [];

  List<Brand> get brands => _brands;

  Store _store = Store();

  bool _isLoading = true;

  get isLoadingIndicator => _isLoading;

  get store {
    return _store;
  }

  List<Store> get stores {
    return _stores;
  }

  void setIsLoadingIndicator(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  Store findById(int? id) {
    return _stores.firstWhere((store) => store.id == id);
  }

  Future getAllBrands() async {
    const url = 'https://ar-store-production.up.railway.app/api/brands';
    final requestHeaders = {
      'accept': '*/*',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.get(Uri.parse(url), headers: requestHeaders);

      if (response.statusCode == StatusCode.ok) {
        print("get All Brands");
        final responseData = json.decode(response.body) as List<dynamic>;
        List<Brand> loadedBrands = [];
        for (var brand in responseData) {
          loadedBrands.add(
            Brand(
                id: brand['id'],
                name: brand['name'],
                countryOfOrigin: brand['countryOfOrigin']),
          );
        }
        _brands = loadedBrands;
        print(_brands.length);
        notifyListeners();
        return true;
      }
    } catch (e) {
      throw "Error : $e";
    }
    notifyListeners();
    return false;
  }

  Future getStoreRequest() async {
    const url = "https://ar-store-production.up.railway.app/api/stores";
    final requestHeaders = {
      'accept': '*/*',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.get(Uri.parse(url), headers: requestHeaders);
      if (response.statusCode == StatusCode.ok) {
        print("get Store");
        final responseData = json.decode(response.body);
        print(responseData['name']);

        _store = Store(
          id: responseData['id'],
          name: responseData['name'],
          phoneNumber: responseData['phoneNumber'],
        );

        notifyListeners();
        return true;
      }
    } catch (e) {
      throw "Error : $e";
    }
    notifyListeners();
    return false;
  }

  Future getAllStores() async {
    const url = "https://ar-store-production.up.railway.app/api/stores";
    final requestHeaders = {
      'accept': '*/*',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.get(Uri.parse(url), headers: requestHeaders);
      if (response.statusCode == StatusCode.ok) {
        print("get All Stores");
        final responseData = json.decode(response.body) as List<dynamic>;
        List<Store> loadedStores = [];
        for (var store in responseData) {
          loadedStores.add(
            Store(
              id: store['id'],
              name: store['name'],
              phoneNumber: store['phoneNumber'],
            ),
          );
        }
        _stores = loadedStores;
        _isLoading = false;
        notifyListeners();
        return true;
      }
    } catch (e) {
      throw "Error : $e";
    }
    notifyListeners();
    return false;
  }

  Future<void> createBrand(String name, String countryOfOrigin) async {
  final url = Uri.parse('https://ar-store-production.up.railway.app/api/brands');

  final headers = {
    'accept': '*/*',
    'Authorization':
        'Bearer $token',
    'Content-Type': 'application/json',
  };

  final body = json.encode({
    "name": name,
    "countryOfOrigin":countryOfOrigin
  });

  final response = await http.post(
    url,
    headers: headers,
    body: body,
  );

  if (response.statusCode == StatusCode.created) {
    print('Brand Request successful');
  } 
}

}
