import 'package:flutter/material.dart';
import 'package:shop_app/views/screens/edit_product_screens/edit_product.dart';
import 'package:shop_app/views/screens/login_screens/login_screen.dart';
import 'package:shop_app/views/screens/login_screens/login_success_screen.dart';
import 'package:shop_app/views/screens/profile_screens/customer_account_screen.dart';
import 'package:shop_app/views/screens/signup_screens/customer_signup_screen.dart';
import 'package:shop_app/views/screens/cart_screens/cart_screen.dart';
import 'package:shop_app/views/screens/home_screens/home_screen.dart';
import 'package:shop_app/views/screens/orders_screens/orders_screen.dart';
import 'package:shop_app/views/screens/product_details_screens/product_detail_screen.dart';
import 'package:shop_app/views/screens/profile_screens/profile_screen.dart';
import 'package:shop_app/views/screens/stores_screens/stores_screen.dart';
import 'package:shop_app/views/screens/profile_screens/store_account_screen.dart';
import 'views/screens/home_screens/product_overview_screen.dart';
import 'views/screens/signup_screens/store_signup_screen.dart';

Map<String, WidgetBuilder> routes() {
  return {
    ProductOverViewScreen.routeName: (_) => const ProductOverViewScreen(),
    ProductDetailScreen.routeName: (_) => const ProductDetailScreen(),
    CartScreen.routeName: (_) => const CartScreen(),
    OrdersScreen.routeName: (_) => const OrdersScreen(),
    StoreAccountScreen.routeName: (_) => const  StoreAccountScreen(),
    EditProduct.routeName: (_) => const EditProduct(),
    ProfileScreen.routeName: (_) => const ProfileScreen(),
    HomeScreen.routeName: (_) => const HomeScreen(),
    LoginScreen.routeName: (_) => LoginScreen(),
    CustomerSignUpScreen.routeName: (_) => CustomerSignUpScreen(),
    StoreSignUpScreen.routeName: (_) => StoreSignUpScreen(),
    LoginSuccessScreen.routeName: (_) => const LoginSuccessScreen(),
    StoresScreen.routeName: (_) => const StoresScreen(),
    CustomerAccountScreen.routeName:(_)=>  CustomerAccountScreen(),
  };
}
