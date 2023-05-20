import 'package:flutter/material.dart';
import 'package:shop_app/views/screens/auth_screen.dart';
import 'package:shop_app/views/screens/login_screens/login_screen.dart';
import 'package:shop_app/views/screens/login_screens/login_success_screen.dart';
import 'package:shop_app/views/screens/signup_screens/signup_screen.dart';
import 'package:shop_app/views/screens/cart_screens/cart_screen.dart';
import 'package:shop_app/views/screens/edit_product_screens/edit_product_screen.dart';
import 'package:shop_app/views/screens/home_screens/home_screen.dart';
import 'package:shop_app/views/screens/orders_screens/orders_screen.dart';
import 'package:shop_app/views/screens/product_details_screens/product_detail_screen.dart';
import 'package:shop_app/views/screens/profile_screens/profile_screen.dart';
import 'package:shop_app/views/screens/stores_screens/stores_screen.dart';
import 'package:shop_app/views/screens/manage_products_screen/manage_products_screen.dart';

import 'views/screens/home_screens/product_overview_screen.dart';

Map<String, WidgetBuilder> routes() {
  return {
    ProductOverViewScreen.routeName: (_) => const ProductOverViewScreen(),
    ProductDetailScreen.routeName: (_) => const ProductDetailScreen(),
    CartScreen.routeName: (_) => const CartScreen(),
    OrdersScreen.routeName: (_) => const OrdersScreen(),
    ManageProductsScreen.routeName: (_) => const ManageProductsScreen(),
    EditProductScreen.routeName: (_) => const EditProductScreen(),
    AuthScreen.routeName: (_) => const AuthScreen(),
    ProfileScreen.routeName: (_) => const ProfileScreen(),
    HomeScreen.routeName: (_) => const HomeScreen(),
    LoginScreen.routeName: (_) =>  LoginScreen(),
    SignUpScreen.routeName: (_) => SignUpScreen(),
    LoginSuccessScreen.routeName: (_) => const LoginSuccessScreen(),
    StoresScreen.routeName: (_) => const StoresScreen(),
  };
}
