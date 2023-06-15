import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/cart_provider.dart';
import '../../widgets/cart_widgets/cart_item.dart';
import '../../widgets/cart_widgets/cart_order_button.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/cart';

  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<Cart>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<Cart>(builder: (ctx, cart, _) {
        return cart.isLoadingIndicator
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Card(
                    margin: const EdgeInsets.all(15),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Total',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          const Spacer(),
                          Chip(
                            label: Text(
                              '\$ ${cartProvider.totalAmount.toStringAsFixed(2)}',
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .primaryTextTheme
                                      .titleLarge
                                      ?.color),
                            ),
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                          ),
                          OrderButton(),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (ctx, int index) {
                        return CartItem(
                          cart.items.values.toList()[index].id,
                          cart.items.keys.toList()[index],
                          cart.items.values.toList()[index].price,
                          cart.items.values.toList()[index].quantity,
                          cart.items.values.toList()[index].title,
                        );
                      },
                      itemCount: cart.items.length,
                    ),
                  ),
                ],
              );
      }),
    );
  }
}
