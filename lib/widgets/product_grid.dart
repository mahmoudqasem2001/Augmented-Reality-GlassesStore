import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/product_item.dart';

import '../providers/products.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavs;

  const ProductsGrid(this.showFavs, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = showFavs ? productsData.favoriteItems : productsData.items;
    return products.isEmpty
        ? const Center(
            child: Text("There is no product!"),
          )
        : GridView.builder(
            padding:const EdgeInsets.all(10.0),
            itemCount: products.length,
            //use change notifier to make ProductItem wedget listen
            // to any change in products[i] , every product on this screen
            // wil listen to every change on his data
            itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
              value: products[i],
              child:const ProductItem(),
            ),
            gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
          );
  }
}
