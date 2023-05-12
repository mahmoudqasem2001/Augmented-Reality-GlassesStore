import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/general.dart';
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/product_filter.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/providers/store.dart';
import 'package:shop_app/providers/stores.dart';
import 'package:shop_app/routes.dart';
import 'package:shop_app/screens/auth/auth_screen.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/splash_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Stores()),
        ChangeNotifierProvider.value(value: Store()),
        ChangeNotifierProvider.value(value: General()),
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProvider.value(value: ProductFilter()),
        ChangeNotifierProvider.value(
          value: Product(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
            create: (_) => Products(),
            update: (ctx, authValue, previousProducts) => Products()
            // previousProducts!
            //   ..getData(
            //     authValue.token!,
            //     authValue.userId!,
            //     previousProducts.items,
            //  ),
            ),
        ChangeNotifierProvider.value(value: Cart()),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (_) => Orders(),
          update: (ctx, authValue, previousOrders) => previousOrders!
            ..getData(
              authValue.token!,
              authValue.userId!,
              previousOrders.orders,
            ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Lato',
            primaryColor: const Color.fromRGBO(13, 12, 13, 1),
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: const Color.fromRGBO(13, 12, 13, 1),
              secondary: const Color.fromRGBO(245, 245, 245, 1),
            ),
            appBarTheme: AppBarTheme(
              color: Colors.white,
              elevation: 0,
              systemOverlayStyle: SystemUiOverlayStyle.light,
              iconTheme: IconThemeData(color: Colors.black),
            ),
          ),
          home: auth.isAuth
              ? const HomeScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (context, auhtSnapshot) =>
                      auhtSnapshot.connectionState == ConnectionState.waiting
                          ? const SplashScreen()
                          : const AuthScreen()),
          routes: routes(),
        ),
      ),
    );
  }
}
