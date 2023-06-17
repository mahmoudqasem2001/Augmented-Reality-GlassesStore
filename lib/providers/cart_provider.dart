import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/cart_item.dart';
import '../shared/constants/constants.dart';

class Cart with ChangeNotifier {
  Map<int, CartItem> _items = {};
  bool _isLoadingIndicator = false;

  get isLoadingIndicator => _isLoadingIndicator;

  Map<int, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price! * cartItem.quantity!;
    });
    return total;
  }

  void setIsLoadingIndicator(bool isLoading) {
    _isLoadingIndicator = isLoading;
    notifyListeners();
  }

  void addItem(
      int? productId, double? price, String? title, int? prodQuantity) {
    if (productId != null &&
        price != null &&
        title != null &&
        prodQuantity != null) {
      if (_items.containsKey(productId)) {
        _items.update(
            productId,
            (existingCartItem) => CartItem(
                  id: productId.toString(),
                  title: existingCartItem.title,
                  price: existingCartItem.price,
                  quantity: existingCartItem.quantity! + prodQuantity,
                ));
      } else {
        _items.putIfAbsent(
          productId,
          () => CartItem(
            id: DateTime.now().toIso8601String(),
            title: title,
            quantity: prodQuantity,
            price: price,
          ),
        );
      }

      notifyListeners();
    } else {
      return;
    }
  }

  Future<void> addToCartRequest(
    int productId,
    int quantity,
    double price,
    String title,
  ) async {
    const url = "https://ar-store-production.up.railway.app/api/cartItems";

    Map<String, dynamic> requestRegistrationBody = {
      'itemId': productId,
      'quantity': quantity,
      'id': {
        'itemId': productId,
      }
    };
    Map<String, String> requestHeaders = {
      'accept': '*/*',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: requestHeaders,
        body: jsonEncode(requestRegistrationBody),
      );
      if (response.statusCode == 201) {
        print('---------------product added');
        _isLoadingIndicator = true;
        //addItem(productId, price, title, quantity);
      } else {
        print('not added');
      }
    } catch (e) {}
    notifyListeners();
  }

  void removeItem(int productId) {
    _items.remove(productId);
    notifyListeners();
  }

  Future<void> removeFromCartRequest(int prodId) async {
    final url =
        'https://ar-store-production.up.railway.app/api/cartItems/$prodId';
    Map<String, String> requestHeaders = {
      'accept': '*/*',
      'Authorization': 'Bearer $token',
    };

    try {
      http.Response response =
          await http.delete(Uri.parse(url), headers: requestHeaders);

      if (response.statusCode == 200) {
        print('product deleted ' + response.statusCode.toString());
        removeItem(prodId);
      }
    } catch (e) {
      throw "Error : $e";
    }
  }

  void removeSingleItem(int productId) {
    if (!_items.containsKey(productId)) {
      return;
    }

    if (_items[productId]!.quantity! > 1) {
      _items.update(
          productId,
          (existingCartItem) => CartItem(
                id: productId.toString(),
                title: existingCartItem.title,
                price: existingCartItem.price,
                quantity: existingCartItem.quantity! - 1,
              ));
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }

  Future<bool> fetchCartItems() async {
    const url = 'https://ar-store-production.up.railway.app/api/cartItems';
    Map<String, String> requestHeaders = {
      'accept': '*/*',
      'Authorization': 'Bearer $token',
    };

    try {
      http.Response response =
          await http.get(Uri.parse(url), headers: requestHeaders);

      if (response.statusCode == 200) {
        print('Fetch cart ' + response.statusCode.toString());
        final responseData = json.decode(response.body);
        for (var element in responseData) {
          _items.putIfAbsent(
            element['item']['id'],
            () => CartItem(
                id: element['item']['id'].toString(),
                title: element['item']['brand']['name'],
                quantity: element['quantity'],
                price: element['item']['price']),
          );
        }
        //_isLoadingIndicator = false;
        print(_items.length);
        _isLoadingIndicator = false;
        notifyListeners();
        return true;
      }
    } catch (e) {}
    _isLoadingIndicator = true;
    notifyListeners();
    return false;
  }
}
