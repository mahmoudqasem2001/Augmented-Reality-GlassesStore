import 'package:flutter/material.dart';
import 'package:shop_app/views/screens/login_screens/login_screen.dart';
import 'package:shop_app/views/screens/login_screens/login_success_screen.dart';
import 'package:shop_app/views/screens/profile_screens/my_account_screen.dart';
import 'package:shop_app/views/screens/signup_screens/customer_signup_screen.dart';
import 'package:shop_app/views/screens/cart_screens/cart_screen.dart';
import 'package:shop_app/views/screens/edit_product_screens/edit_product_screen.dart';
import 'package:shop_app/views/screens/home_screens/home_screen.dart';
import 'package:shop_app/views/screens/orders_screens/orders_screen.dart';
import 'package:shop_app/views/screens/product_details_screens/product_detail_screen.dart';
import 'package:shop_app/views/screens/profile_screens/profile_screen.dart';
import 'package:shop_app/views/screens/stores_screens/stores_screen.dart';
import 'package:shop_app/views/screens/manage_products_screen/manage_products_screen.dart';
import 'views/screens/home_screens/product_overview_screen.dart';
import 'views/screens/signup_screens/store_signup_screen.dart';

Map<String, WidgetBuilder> routes() {
  return {
    ProductOverViewScreen.routeName: (_) => const ProductOverViewScreen(),
    ProductDetailScreen.routeName: (_) => const ProductDetailScreen(),
    CartScreen.routeName: (_) => const CartScreen(),
    OrdersScreen.routeName: (_) => const OrdersScreen(),
    ManageProductsScreen.routeName: (_) => const ManageProductsScreen(),
    EditProductScreen.routeName: (_) => const EditProductScreen(),
    ProfileScreen.routeName: (_) => const ProfileScreen(),
    HomeScreen.routeName: (_) => const HomeScreen(),
    LoginScreen.routeName: (_) => LoginScreen(),
    CustomerSignUpScreen.routeName: (_) => CustomerSignUpScreen(),
    StoreSignUpScreen.routeName: (_) => StoreSignUpScreen(),
    LoginSuccessScreen.routeName: (_) => const LoginSuccessScreen(),
    StoresScreen.routeName: (_) => const StoresScreen(),
    MyAccountScreen.routeName:(_)=>  MyAccountScreen(),
  };
}
