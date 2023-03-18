import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);

    return ClipRRect(
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder: (ctx, product, _) => IconButton(
              onPressed: () {
                product.toggleFavoriteStatus(authData.token !, authData.userId !);
              },
              icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          title: Text(
            product.title !,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon:const Icon(Icons.shopping_cart),
            onPressed: () {
              cart.addItem(product.id !, product.price as double, product.title !);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content:const Text("Add to cart!"),
                duration:const Duration(seconds: 3),
                action: SnackBarAction(
                  label: 'UNDO!',
                  onPressed: () {
                    cart.removeSingleItem(product.id !);
                  },
                ),
              ));
            },
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        child: GestureDetector(
          onTap: () =>
              Navigator.of(context).pushNamed(ProductDetailScreen.routeName, arguments: product.id),
          child: Hero(
              tag: product.id !,
              child: FadeInImage(
                placeholder:
                 const AssetImage('assets/images/product-placeholder.png'),
                image: NetworkImage(product.imageUrl !),
                fit: BoxFit.cover,
              )),
        ),
      ),
      borderRadius: BorderRadius.circular(10),
    );
  }
}
