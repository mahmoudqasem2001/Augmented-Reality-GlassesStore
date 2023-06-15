import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shop_app/models/store.dart';
import 'package:http/http.dart' as http;
import '../core/api/status_code.dart';
import '../shared/constants/constants.dart';

class Stores with ChangeNotifier {
  List<Store> _stores = [];

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
        final responseData =
            json.decode(response.body) as List<dynamic>;
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
}
