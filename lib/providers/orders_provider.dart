// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shop_app/core/api/status_code.dart';
import 'package:shop_app/models/brand.dart';
import 'package:shop_app/models/store.dart';
import 'package:shop_app/providers/product_provider.dart';
import 'package:shop_app/shared/constants/constants.dart';
import '../models/order_item.dart';
import 'package:http/http.dart' as http;
import '../models/order.dart' as order;

class Orders with ChangeNotifier {
  List<order.Order> _orders = [];

  List<order.Order> get orders {
    return [..._orders];
  }

  Future<void> postOrder(List<OrderItem> orderItems, int quantity) async {
    final url =
        Uri.parse('https://ar-store-production.up.railway.app/api/orders');

    final headers = {
      'accept': '*/*',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    List<Map<String, dynamic>> listOfOrders = [];
    for (var element in orderItems) {
      listOfOrders.add({
        'itemId': element.item.id,
        'quantity': element.quantity,
      });
    }

    final body = {'orderItems': listOfOrders};

    try {
      final response =
          await http.post(url, headers: headers, body: json.encode(body));
      if (response.statusCode == StatusCode.created) {
        // Request successful created
        print('order Created');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> getOrders() async {
    final url =
        Uri.parse('https://ar-store-production.up.railway.app/api/orders');

    final headers = {
      'accept': '*/*',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == StatusCode.ok) {
        final responseData =
            json.decode(response.body) as List<Map<String, dynamic>>;
        print(responseData);
        
        List<OrderItem> loadedOrderItems = [];
        for (var responseOrder in responseData) {
          for (var responseOrderItem in responseOrder['orderItems']) {
            loadedOrderItems.add(OrderItem(
                quantity: responseOrderItem['quantity'],
                price: responseOrderItem['price'],
                item: Product(
                  id: responseOrderItem['item']['id'],
                  price: responseOrderItem['item']['price'],
                  rating: responseOrderItem['item']['rating'],
                  store: Store(
                    id: responseOrderItem['item']['store']['id'],
                    name: responseOrderItem['item']['store']['name'],
                    phoneNumber: responseOrderItem['item']['store']
                        ['phoneNumber'],
                  ),
                  brand: Brand(
                    id: responseOrderItem['item']['brand']['id'],
                    name: responseOrderItem['item']['brand']['name'],
                    countryOfOrigin: responseOrderItem['item']['brand']
                        ['countryOfOrigin'],
                  ),
                  model: responseOrderItem['item']['model'],
                  color: responseOrderItem['item']['color'],
                  type: responseOrderItem['item']['type'],
                  gender: responseOrderItem['item']['gender'],
                  border: responseOrderItem['item']['border'],
                  shape: responseOrderItem['item']['shape'],
                )));
          }
        }

        List<order.Order> loadedOrders = [];
        for (var responseOrder in responseData) {
          loadedOrders.add(
            order.Order(
              id: responseOrder['id'],
              orderStatus: responseOrder['orderStatus'],
              discount: responseOrder['discount'],
              totalPrice: responseOrder['totalPrice'],
              orderItems: loadedOrderItems,
            ),
          );
        }
        _orders = loadedOrders;
      }
    } catch (e) {
      print('Error: $e');
    }
    notifyListeners();
  }
}
