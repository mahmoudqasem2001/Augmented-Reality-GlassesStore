import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/cart_provider.dart';
import '../../../providers/orders_provider.dart';

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key? key,
  }) : super(key: key);

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  bool _isloading = false;
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<Cart>(context, listen: false);
    return TextButton(
      onPressed: (cartProvider.totalAmount <= 0 || _isloading == true)
          ? null
          : () async {
              setState(() {
                _isloading = true;
              });
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  title: const Text('Are you sure?'),
                  content: const Text('Do you to make this order?'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          setState(() {
                            _isloading = false;
                          });
                          Navigator.of(context).pop();
                        },
                        child: const Text('No')),
                    TextButton(
                        onPressed: () {
                          Provider.of<Orders>(context, listen: false).postOrder(
                            cartProvider.items.values.toList(),
                          );
                          //print(widget.cart.items.values.toList().first.price);
                          setState(() {
                            _isloading = false;
                          });
                          cartProvider.clear();
                          Navigator.of(context).pop(true);
                        },
                        child: const Text('Yes')),
                  ],
                ),
              );
            },
      child: _isloading
          ? const CircularProgressIndicator()
          : Text(
              'ORDER NOW',
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
    );
  }
}
