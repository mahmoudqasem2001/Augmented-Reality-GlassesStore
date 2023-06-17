// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:shop_app/models/order_item.dart';

class Order {
  int id;
  String orderStatus;
  double discount;
double totalPrice;
  List<OrderItem> orderItems;
  Order({
    required this.id,
    required this.orderStatus,
    required this.discount,
    required this.totalPrice,
    required this.orderItems,
  });
  

  
}
