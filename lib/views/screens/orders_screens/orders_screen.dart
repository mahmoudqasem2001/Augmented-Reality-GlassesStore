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
    final ordersProvider = Provider.of<Orders>(context, listen: false);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        title: const Text("Your Order"),
      ),
      drawer: const AppDrawer(),
      body: ordersProvider.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Consumer<Orders>(
              builder: (ctx, ordersProvider, child) => ListView.builder(
                itemBuilder: (BuildContext context, int index) =>
                    OrderItem(ordersProvider.orders[index]),
                itemCount: ordersProvider.orders.length,
              ),
            ),
    );
  }
}
