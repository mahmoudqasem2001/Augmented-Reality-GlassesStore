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
        title: const Text("Your Orders"),
      ),
      drawer: const AppDrawer(),
      body:Consumer<Orders>(
              builder: (ctx, ordersProvider, child) => ordersProvider.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          :  ListView.builder(
                itemBuilder: (BuildContext context, int index) =>
                    OrderItem(ordersProvider.orders[index]),
                itemCount: ordersProvider.orders.length,
              ),
            ),
    );
  }
}
