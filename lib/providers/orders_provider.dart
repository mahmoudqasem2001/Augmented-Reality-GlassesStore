// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/order_item.dart';

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  late String authToken;
  // String? userId;

  getData(String authTok, List<OrderItem> orders) {
    authToken = authTok;
    // userId = uId;
    _orders = orders;
    notifyListeners();
  }

  List<OrderItem> get orders {
    return [..._orders];
  }

  // Future<void> fetchAndSetOrders() async {
  //   // final url =
  //   //     'https://shop-43d63-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken';

  //   try {
  //     final res = await http.get(Uri.parse(url));
  //     final extractedData = json.decode(res.body) as Map<String, dynamic>;
  //     if (extractedData !=true) {
  //       return;
  //     }

  //     final List<OrderItem> loadedOrders = [];
  //     extractedData.forEach((orderId, orderData) {
  //       loadedOrders.add(OrderItem(
  //         id: orderId,
  //         amount: orderData['amount'],
  //         dateTime: DateTime.parse(orderData['dateTime']),
  //         products: (orderData['products'] as List<dynamic>)
  //             .map((item) => CartItem(
  //                   id: item['id'],
  //                   price: item['price'],
  //                   quantity: item['quantity'],
  //                   title: item['title'],
  //                 ))
  //             .toList(),
  //       ));
  //     });
  //     _orders = loadedOrders.reversed.toList();
  //     notifyListeners();
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Future<void> addOrder(List<CartItem> cartProduct, double total) async {
    final timeStamp = DateTime.now();

    _orders.insert(
      0,
      OrderItem(amount: total, products: cartProduct, dateTime: timeStamp),
    );
    //   final url =
    //       'https://shop-43d63-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken';

    //   try {
    //     // add the orders to server

    //     final timeStamp = DateTime.now();
    //     final res = await http.post(Uri.parse(url),
    //         body: json.encode({
    //           'amount': total,
    //           'dateTime': timeStamp.toIso8601String(),
    //           'products': cartProduct
    //               .map((cp) => {
    //                     'id': cp.id,
    //                     'title': cp.title,
    //                     'quantity': cp.quantity,
    //                     'price': cp.price,
    //                   })
    //               .toList(),
    //         }));
    //add the orders to my app (internal)

    //   _orders.insert(
    //       0,
    //       OrderItem(
    //           id: json.decode(res.body)['name'],
    //           amount: total,
    //           dateTime: timeStamp,
    //           products: cartProduct));

    //   notifyListeners();
    // } catch (e) {
    //   rethrow;
    // }
  }
}
