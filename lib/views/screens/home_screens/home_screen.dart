// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/home_provider.dart';
import 'package:shop_app/views/widgets/drawer/end_drawer/end_drawer.dart';
import '../../widgets/drawer/app_drawer/app_drawer.dart';
import '../../widgets/cart_widgets/badge.dart' as my_badge;
import '../../../providers/cart_provider.dart';
import '../../../providers/products_provider.dart';
import '../../widgets/home_widgets/home_bottom_bar.dart';
import '../cart_screens/cart_screen.dart';
import '../profile_screens/profile_screen.dart';
import 'product_overview_screen.dart';

enum FilterOption { favorites, all }

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //var _isInit= false;

  @override
  Widget build(BuildContext context) {
       // final storeName = ModalRoute.of(context)!.settings.arguments! as String;

    List screens =  [
      const ProductOverViewScreen(),
      const CartScreen(),
      const ProfileScreen(),
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
        title: const Text('EYEWEAR'),
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
        actions: const [
          Icon(Icons.add_home,color: Colors.white )
        ],
        
      ),
      body: Consumer<Home>(
        builder: (context, value, child) {
          return screens[value.bottomBarSelectedIndex];
        },
      ),
      drawer: const AppDrawer(),
      endDrawerEnableOpenDragGesture: false,
      endDrawer: EndDrawer(),
      bottomNavigationBar: const HomeBottomBar(),
    );
  }
}
