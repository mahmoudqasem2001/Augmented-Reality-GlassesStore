import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/orders_provider.dart';
import 'package:shop_app/providers/stores_provider.dart';
import 'package:shop_app/views/screens/orders_screens/orders_screen.dart';
import 'package:shop_app/views/screens/stores_screens/stores_screen.dart';


class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<Orders>(context, listen: false);
    final storesProvider = Provider.of<Stores>(context, listen: false);
    return Drawer(
      child: Column(
        children: [
          const Divider(
            height: 60,
          ),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text('Shop'),
            onTap: () => Navigator.of(context).pushReplacementNamed('/'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.store_mall_directory),
            title: const Text('Stores'),
            onTap: () {
              storesProvider.getAllStores();
              Navigator.of(context)
                  .pushReplacementNamed(StoresScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Orders'),
            onTap: () {
              ordersProvider.setLoadingIndicator(true);
              ordersProvider.getOrders();
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.routeName);
            },
          ),
          const Divider(),
         
        ],
      ),
    );
  }
}
