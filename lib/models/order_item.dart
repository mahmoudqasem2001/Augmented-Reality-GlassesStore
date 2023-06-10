import 'package:shop_app/models/cart_item.dart';

class OrderItem {
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;
  OrderItem({
   required this.amount,
   required this.products,
   required this.dateTime,
  });
}