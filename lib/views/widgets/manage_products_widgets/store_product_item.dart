import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/products_provider.dart';
import '../../screens/edit_product_screens/edit_product_screens.dart';

class StoreProductItem extends StatelessWidget {
  final int id;
  final String title;
  final String imageUrl;

  const StoreProductItem(this.id, this.title, this.imageUrl, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<Products>(context, listen: false);
    final scaffold = ScaffoldMessenger.of(context);
    return ListTile(
      tileColor: Colors.grey[200],
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  EditProductScreen.routeName,
                  arguments: id,
                );
              },
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () async {
                try {
                  await productsProvider
                      .deleteProduct(id);
                  await productsProvider
                      .fetchStoreProducts();
                } catch (e) {
                  scaffold.showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Deleting failed',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
              },
              color: Theme.of(context).colorScheme.error,
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
