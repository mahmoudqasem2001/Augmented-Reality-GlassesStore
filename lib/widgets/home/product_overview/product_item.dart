import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/screens/product_details/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);

    return ClipRRect(
      child: Container(
        color: Theme.of(context).colorScheme.secondary,
        child: GridTile(
          footer: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  product.brand!,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '\$ ${product.price.toString()}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          child: GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(
                ProductDetailScreen.routeName,
                arguments: product.id),
            child: Hero(
                tag: product.id!,
                child: FadeInImage(
                  placeholder:
                      const AssetImage('assets/images/product-placeholder.jpg'),
                  image: NetworkImage(product.imageUrls![1]),
                  fit: BoxFit.contain,
                )),
          ),
        ),
      ),
      borderRadius: BorderRadius.circular(10),
    );
  }
}
