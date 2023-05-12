import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';

import '../../providers/cart.dart';
import '../../providers/products.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;

  final int quantity;
  final String title;

  const CartItem(this.id, this.productId, this.price, this.quantity, this.title,
      {Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final imageIrl = Provider.of<Products>(context, listen: false)
        .findById(productId)
        .imageUrls![0];
    return Dismissible(
      background: Container(
        color: Theme.of(context).colorScheme.error,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(
          right: 20,
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you to remove  item from the cart?'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('No')),
              TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Yes')),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      key: ValueKey(id),
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(25.0),
              child: Image.network(imageIrl),
            ),
            title: Text(title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10,),
                Text(
                  'Price \$$price',
                ),
                SizedBox(height: 10,),
                Text('Total \$${(price * quantity)}'),
              ],
            ),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}
