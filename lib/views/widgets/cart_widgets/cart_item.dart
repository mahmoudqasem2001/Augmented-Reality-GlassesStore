import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth.dart';
import '../../../providers/cart_provider.dart';
import '../../../providers/products_provider.dart';

class CartItem extends StatelessWidget {
  final String? id;
  final int? productId;
  final double? price;
  final int? quantity;
  final String? title;

  const CartItem(this.id, this.productId, this.price, this.quantity, this.title,
      {Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<Auth>(context, listen: false);
    final cartProvider = Provider.of<Cart>(context, listen: false);
    final imageIrl = Provider.of<Products>(context, listen: false)
        .findById(productId!)
        .imageUrls![0];
    return Dismissible(
      background: Container(
        color: Theme.of(context).colorScheme.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(
          right: 20,
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.secondary,
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
        authProvider
            .fetchAccountInfo()
            .then((value) => authProvider.setAuthentucated(value));
        if (authProvider.authenticated == true) {
          cartProvider.removeFromCart(productId!);
        } else {
          cartProvider.removeItem(productId!);
        }
      },
      key: ValueKey(id),
      child: Consumer<Cart>(
        builder: (ctx, cartItem, _) {
          return Card(
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
                title: Text(title!),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Price \$$price',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('Total \$${(price! * quantity!)}'),
                  ],
                ),
                trailing: Text('$quantity x'),
              ),
            ),
          );
        },
      ),
    );
  }
}
