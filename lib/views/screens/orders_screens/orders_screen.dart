import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/orders_provider.dart' show Orders;
import 'package:shop_app/views/widgets/drawer/app_drawer/app_drawer.dart';
import '../../widgets/orders_widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/order';
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        title: const Text("Your Order"),
      ),
      drawer: const AppDrawer(),
      body:
          // FutureBuilder(
          //   builder: (ctx, AsyncSnapshot snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return const CircularProgressIndicator();
          //     } else {
          //       if (snapshot.error != null) {
          //         return const Center(
          //           child: Text('An error occured!'),
          //         );
          //       } else {
          //         return
          Consumer<Orders>(
        builder: (ctx, orderData, child) => ListView.builder(
          itemBuilder: (BuildContext context, int index) =>
              OrderItem(orderData.orders[index]),
          itemCount: orderData.orders.length,
        ),
      ),
      //         );
      //       }
      //     }
      //   },
      //   future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
      // ),
    );
  }
}
