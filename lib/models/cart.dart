import 'package:shop_app/models/cart_item.dart';
import 'customer.dart';

class Cart {
  Customer? customer;
  CartItem? cartItem;

  Cart({this.customer, this.cartItem});
}
