import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/cache/cacheHelper.dart';
import 'package:shop_app/core/api/status_code.dart';
import 'package:shop_app/models/address.dart';
import 'package:shop_app/models/customer.dart';
import 'package:shop_app/shared/constants/constants.dart';

class Auth with ChangeNotifier {
  bool _authenticated = false;
  bool _isLoading = false;
  String? _country = '';
  Customer _customer = Customer();

  Customer get customer => _customer;
  get country => _country;
  get authenticated => _authenticated;
  get isLoading => _isLoading;

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
        String location = responseHeaders['location'];
        final id = location.split('/').last;

        await CacheData.setData(
            key: 'token', value: responseHeaders['authorization']);
        await CacheData.setData(key: 'id', value: id);
        await CacheData.setData(
            key: id, value: responseHeaders['authorization']);
        await login(email: email, password: password);
        await addressRequest(country, city, street, zip);
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
        String location = responseHeaders['location'];
        final id = location.split('/').last;

        await CacheData.setData(
            key: 'token', value: responseHeaders['authorization']);
        await CacheData.setData(key: 'id', value: id);
        await CacheData.setData(
            key: id, value: responseHeaders['authorization']);

        await login(email: email, password: password);
        await addressRequest(country, city, street, zip);
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
        body: jsonEncode(requestBody),
        headers: requestHeaders,
      );
      if (response.statusCode == StatusCode.ok) {
        var responseHeaders = response.headers;
        await CacheData.deleteItem(key: 'token');
        await CacheData.setData(
            key: 'token', value: responseHeaders['authorization']);

        token = await CacheData.getData(key: 'token');
        _authenticated = true;
        print("after login token is " + token!);
        
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
      print(addressResponse.statusCode);
      if (addressResponse.statusCode == StatusCode.created) {
        print('address yes........' + addressResponse.statusCode.toString());
      }
    } catch (e) {
      print("Exception occurred: $e");
    }
  }

  Future<void> fetchAccountInfo() async {
    final url =
        "https://ar-store-production.up.railway.app/api/customers/${id}";
    final requestHeaders = {
      'accept': '*/*',
      'Authorization': 'Bearer ${token}',
    };
    print(id);
    print(token);
    try {
      final response = await http.get(Uri.parse(url), headers: requestHeaders);
      if (response.statusCode == StatusCode.ok) {
        print(response.statusCode);
        final responseData = json.decode(response.body);
        print(responseData['name']);

        _customer = Customer(
          id: responseData['id'],
          name: responseData['name'],
          phoneNumber: responseData['phoneNumber'],
          gender: responseData['gender'],
          // address: Address(
          //   country: responseData['addresses'][0]['country'],
          //   city: responseData['addresses'][0]['city'],
          //   street: responseData['addresses'][0]['street'],
          //   zip: responseData['addresses'][0]['zip'],
          // ),
        );
        notifyListeners();
      } else if (response.statusCode == StatusCode.forbidden) {
        print('cant authnticate');
        _authenticated = false;
      }
    } catch (e) {
      _customer = Customer(id: 0);
    }
    notifyListeners();
  }
}
