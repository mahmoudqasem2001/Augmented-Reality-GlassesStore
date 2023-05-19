// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:shop_app/models/order_item.dart';

import 'customer.dart';

class Order {
  Customer? customer;
  List<OrderItem>? orderItems;
  DateTime? orderDate;
  String? shippingCompany;
  String? status;
  double? discount;
  Order({
    this.customer,
    this.orderItems,
    this.orderDate,
    this.shippingCompany,
    this.status, 
    this.discount,
  });
}
