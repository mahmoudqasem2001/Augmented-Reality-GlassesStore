import 'package:flutter/material.dart';
import 'package:shop_app/screens/auth/auth_screen.dart';
import 'package:shop_app/screens/auth/login_screen.dart';
import 'package:shop_app/screens/auth/login_success_screen.dart';
import 'package:shop_app/screens/auth/signUp_screen.dart';
import 'package:shop_app/screens/cart/cart_screen.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/home/product_overview_screen.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/screens/product_details/product_detail_screen.dart';
import 'package:shop_app/screens/profile/profile_screen.dart';
import 'package:shop_app/screens/stores/stores_screen.dart';
import 'package:shop_app/screens/user_products_screen.dart';

Map<String, WidgetBuilder> routes() {
  return {
    ProductOverViewScreen.routeName: (_) => const ProductOverViewScreen(),
    ProductDetailScreen.routeName: (_) => ProductDetailScreen(),
    CartScreen.routeName: (_) => const CartScreen(),
    OrdersScreen.routeName: (_) => const OrdersScreen(),
    UserProductsScreen.routeName: (_) => const UserProductsScreen(),
    EditProductScreen.routeName: (_) => const EditProductScreen(),
    AuthScreen.routeName: (_) => const AuthScreen(),
    ProfileScreen.routeName: (_) => const ProfileScreen(),
    HomeScreen.routeName: (_) => const HomeScreen(),
    LoginScreen.routeName: (_) => const LoginScreen(),
    SignUpScreen.routeName: (_) => const SignUpScreen(),
    LoginSuccessScreen.routeName: (_) => const LoginSuccessScreen(),
    StoresScreen.routeName: (_) => const StoresScreen(),
  };
}
