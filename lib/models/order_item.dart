import 'package:shop_app/models/product.dart';

class OrderItem {
  int quantity;
  double price;
  Product item;
  OrderItem({
    required this.quantity,
    required this.price,
    required this.item,
  });
}
