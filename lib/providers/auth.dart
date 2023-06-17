import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/cache/cacheHelper.dart';
import 'package:shop_app/core/api/status_code.dart';
import 'package:shop_app/models/customer.dart';
import 'package:shop_app/models/store.dart';
import 'package:shop_app/shared/constants/constants.dart';

class Auth with ChangeNotifier {
  bool _authenticated = false;
  bool _isLoading = false;
  String? _country = '';
  Customer _customer = Customer();
  Store _store = Store();

  Store get store => _store;
  Customer get customer => _customer;
  get country => _country;
  get authenticated => _authenticated;
  get isLoading => _isLoading;

  void setStore(Store store) {
    _store = store;
  }

  void setCountry(String country) {
    _country = country;
    notifyListeners();
  }

  void setAuthentucated(bool authenticated) {
    _authenticated = authenticated;
    notifyListeners();
  }

  void setLoadingIndicator(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  Future<bool> customerRegister({
    required String userName,
    required String userPhoneNumber,
    required String country,
    required String city,
    required String street,
    required String zip,
    required String userGender,
    required String email,
    required String password,
  }) async {
    const url =
        "https://ar-store-production.up.railway.app/api/auth/register/customer";
    Map<String, dynamic> requestRegistrationBody = {
      'email': email,
      'password': password,
      'customer': {
        'name': userName,
        'phoneNumber': userPhoneNumber,
        'gender': userGender,
      }
    };
    Map<String, String> requestHeaders = {
      'accept': '*/*',
      'Content-Type': 'application/json',
    };

    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: requestHeaders,
        body: jsonEncode(requestRegistrationBody),
      );

      if (response.statusCode == StatusCode.created) {
        print('yessCustomer......' + response.statusCode.toString());
        Map<String, dynamic> responseHeaders = response.headers;

        await CacheData.setData(
            key: 'token', value: responseHeaders['authorization']);

        addressRequest(country, city, street, zip);
        _authenticated = true;
        _isLoading = false;
        notifyListeners();
        return true;
      }
      if (response.statusCode == StatusCode.badRequest) {
        final responseBody = json.decode(response.body);

        final timestamp = responseBody['timestamp'];
        final messages = List<String>.from(responseBody['messages']);
        final status = responseBody['status'];

        print('Timestamp: $timestamp');
        print('Messages: $messages');
        print('Status: $status');
      } else {
        print('Unexpected response status: ${response.statusCode}');
      }
    } catch (e) {
      print("Exception occurred: $e");
    }
    return false;
  }

  Future<bool> storeRegister({
    required String storeName,
    required String phoneNumber,
    required String country,
    required String city,
    required String street,
    required String zip,
    required String email,
    required String password,
  }) async {
    const url =
        "https://ar-store-production.up.railway.app/api/auth/register/store";
    Map<String, dynamic> requestRegistrationBody = {
      'email': email,
      'password': password,
      'store': {
        'name': storeName,
        'phoneNumber': phoneNumber,
      }
    };
    Map<String, String> requestHeaders = {
      'accept': '*/*',
      'Content-Type': 'application/json',
    };

    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: requestHeaders,
        body: jsonEncode(requestRegistrationBody),
      );

      if (response.statusCode == StatusCode.created) {
        print('yessStore......' + response.statusCode.toString());
        Map<String, dynamic> responseHeaders = response.headers;
        await CacheData.setData(
            key: 'token', value: responseHeaders['authorization']);

        addressRequest(country, city, street, zip);
        _authenticated = true;
        _isLoading = false;
        notifyListeners();
        return true;
      }
      if (response.statusCode == StatusCode.badRequest) {
        final responseBody = json.decode(response.body);

        // Extract the necessary information from the response body
        final timestamp = responseBody['timestamp'];
        final messages = List<String>.from(responseBody['messages']);
        final status = responseBody['status'];

        print('Timestamp: $timestamp');
        print('Messages: $messages');
        print('Status: $status');
      } else {
        print('Unexpected response status: ${response.statusCode}');
      }
    } catch (e) {
      print("Exception occurred: $e");
    }
    return false;
  }

  Future<bool> login({required String email, required String password}) async {
    const url = "https://ar-store-production.up.railway.app/api/auth/login";
    final requestBody = {
      'email': email,
      'password': password,
    };
    final requestHeaders = {
      'accept': '*/*',
      'Content-Type': 'application/json',
    };
    try {
      http.Response response = await http.post(
        Uri.parse(url),
        body: json.encode(requestBody),
        headers: requestHeaders,
      );
      if (response.statusCode == StatusCode.ok) {
        _authenticated = true;
        _isLoading = false;

        var responseHeaders = response.headers;
        await CacheData.deleteItem(key: 'token');
        await CacheData.setData(
            key: 'token', value: responseHeaders['authorization']);
        token = await CacheData.getData(key: 'token');

        print("after login token is " + token!);

        notifyListeners();
        return true;
      }
      if (response.statusCode == StatusCode.badRequest) {
        final responseBody = json.decode(response.body);

        final timestamp = responseBody['timestamp'];
        final messages = List<String>.from(responseBody['messages']);
        final status = responseBody['status'];

        print('Timestamp: $timestamp');
        print('Messages: $messages');
        print('Status: $status');
      } else {
        print('Unexpected response status: ${response.statusCode}');
      }
    } catch (e) {
      print(e.toString());
    }
    return false;
  }

  Future<void> addressRequest(
      String country, String city, String street, String zip) async {
    //print(country +" "+ city + " "+ street + " "+ zip );
    const addressRequestUrl =
        "https://ar-store-production.up.railway.app/api/addresses";
    Map<String, dynamic> requestAddressBody = {
      "country": country,
      "city": city,
      "street": street,
      "zip": zip
    };
    Map<String, String> requestHeaders = {
      'accept': '*/*',
      'Authorization': 'Bearer {$token}',
      'Content-Type': 'application/json',
    };

    try {
      http.Response addressResponse = await http.post(
        Uri.parse(addressRequestUrl),
        headers: requestHeaders,
        body: jsonEncode(requestAddressBody),
      );
      print('address ........' + addressResponse.statusCode.toString());
    } catch (e) {
      print("Exception occurred: $e");
    }
  }

  Future<bool> fetchCustomerAccountInfo() async {
    const url = "https://ar-store-production.up.railway.app/api/me/customers";
    final requestHeaders = {
      'accept': '*/*',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.get(Uri.parse(url), headers: requestHeaders);
      if (response.statusCode == StatusCode.ok) {
        final responseData = json.decode(response.body);
        print(responseData['name']);
        await CacheData.setData(key: 'userType', value: 'customer');
        userType = "customer";
        _customer = Customer(
          id: responseData['id'],
          name: responseData['name'],
          phoneNumber: responseData['phoneNumber'],
          gender: responseData['gender'],
        );
        notifyListeners();
        return true;
      } else if (response.statusCode == StatusCode.forbidden) {
        print('cant authnticate customer');
        _authenticated = false;
      }
    } catch (e) {
      _customer = Customer();
    }
    notifyListeners();
    return false;
  }

  Future<bool> fetchStoreAccountInfo() async {
    const url = "https://ar-store-production.up.railway.app/api/me/stores";
    final requestHeaders = {
      'accept': '*/*',
      'Authorization': 'Bearer $token',
    };
    try {
      final response = await http.get(Uri.parse(url), headers: requestHeaders);
      if (response.statusCode == StatusCode.ok) {
        print(response.statusCode);
        final responseData = json.decode(response.body);
        print(responseData['name']);
        await CacheData.setData(key: 'userType', value: 'store');
        userType = "store";
        _store = Store(
          id: responseData['id'],
          name: responseData['name'],
          phoneNumber: responseData['phoneNumber'],
        );
        _authenticated = true;
        notifyListeners();
        return true;
      } else if (response.statusCode == StatusCode.forbidden) {
        print('cant authnticate store');
        _authenticated = false;
      }
    } catch (e) {
      _store = Store();
    }
    notifyListeners();
    return false;
  }
}
