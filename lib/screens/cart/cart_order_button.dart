import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/cart.dart';
import '../../providers/orders.dart';

class OrderButton extends StatefulWidget {
  final Cart cart;
  const OrderButton({Key? key, required this.cart}) : super(key: key);

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  bool _isloading = false;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: (widget.cart.totalAmount <= 0 || _isloading == true)
          ? null
          : () async {
              setState(() {
                _isloading = true;
              });
              await Provider.of<Orders>(context, listen: false).addOrder(
                  widget.cart.items.values.toList(), widget.cart.totalAmount);
              setState(() {
                _isloading = false;
              });
              widget.cart.clear();
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
