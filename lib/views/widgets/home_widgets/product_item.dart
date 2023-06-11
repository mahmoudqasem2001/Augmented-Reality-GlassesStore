import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/views/screens/product_details_screens/product_detail_screen.dart';
import '../../../providers/product_provider.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        color: Theme.of(context).colorScheme.secondary,
        child: GridTile(
          footer: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  product.brand!.name!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold),
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
            onTap: () {
              Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                  arguments: product.id);
            },
            child: Hero(
                tag: product.id!,
                child: FadeInImage(
                  placeholder:
                      const AssetImage('assets/images/product-placeholder.jpg'),
                  image: NetworkImage(
                    'https://images.ray-ban.com/is/image/RayBan/8056597061421__STD__shad__qt.png?impolicy=RB_Product&width=1024&bgc=%23f2f2f2',
                  ),
                  fit: BoxFit.contain,
                )),
          ),
        ),
      ),
    );
  }
}
