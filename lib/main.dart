import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/providers/cart_provider.dart';
import 'package:shop_app/providers/orders_provider.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/providers/stores_provider.dart';
import 'package:shop_app/routes.dart';
import 'package:shop_app/shared/constants/constants.dart';
import 'package:shop_app/views/screens/home_screens/home_screen.dart';
import 'cache/cacheHelper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheData.cacheInitialization();
  token = await CacheData.getData(key: 'token');
  userType = await CacheData.getData(key: 'userType');
  print("token is " + token!);
  print("user type is " + userType);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Stores()),
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProvider.value(value: Products()),
        ChangeNotifierProvider.value(value: Orders()),
        ChangeNotifierProvider.value(value: Cart()),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            fontFamily: 'Lato',
            primaryColor: const Color.fromRGBO(13, 12, 13, 1),
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: const Color.fromRGBO(13, 12, 13, 1),
              secondary: const Color.fromRGBO(245, 245, 245, 1),
            ),
            appBarTheme: const AppBarTheme(
              color: Colors.white,
              elevation: 0,
              systemOverlayStyle: SystemUiOverlayStyle.light,
              iconTheme: IconThemeData(color: Colors.black),
            ),
          ),
          home: const HomeScreen(),
          routes: routes(),
        ),
      ),
    );
  }
}
