import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/general.dart';
import 'package:shop_app/screens/home/product_overview_screen.dart';
import 'package:shop_app/widgets/drawer/end_drawer.dart';
import '../../widgets/drawer/app_drawer.dart';
import '../../widgets/home/badge.dart' as my_badge;
import '../../providers/cart.dart';
import '../../providers/products.dart';
import '../../widgets/home/home_bottom_bar.dart';
import '../cart/cart_screen.dart';
import '../profile/profile_screen.dart';

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
    var generalProvider = Provider.of<General>(context, listen: false);
       // final storeName = ModalRoute.of(context)!.settings.arguments! as String;

    List _screens =  [
      ProductOverViewScreen(),
      CartScreen(),
      ProfileScreen(),
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
        title: Text('EYEWEAR'),
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
        actions: [
          // PopupMenuButton(
          //   onSelected: (FilterOption selectedVal) {
          //     setState(() {
          //       if (selectedVal == FilterOption.favorites) {
          //         _showOnlyFavorites = true;
          //       } else {
          //         _showOnlyFavorites = false;
          //       }
          //     });
          //   },
          //   icon: const Icon(Icons.more_vert),
          //   itemBuilder: (_) {
          //     return [
          //       const PopupMenuItem(
          //         child: Text("Only Favorites"),
          //         value: FilterOption.favorites,
          //       ),
          //       const PopupMenuItem(
          //         child: Text("Show All"),
          //         value: FilterOption.all,
          //       ),
          //     ];
          //   },
          // ),
          Icon(Icons.add_home,color: Colors.white )
        ],
        
      ),
      body: Consumer<General>(
        builder: (context, value, child) {
          return _screens[value.selectedIndex];
        },
      ),
      drawer: const AppDrawer(),
      endDrawerEnableOpenDragGesture: false,
      endDrawer: EndDrawer(),
      bottomNavigationBar: HomeBottomBar(),
    );
  }
}
