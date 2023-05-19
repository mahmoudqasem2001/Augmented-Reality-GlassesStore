import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/views/widgets/home_widgets/product_item.dart';
import '../../../models/product.dart';
import '../../../providers/products_provider.dart';

class ProductsGrid extends StatefulWidget {
  const ProductsGrid({Key? key}) : super(key: key);

  @override
  State<ProductsGrid> createState() => _ProductsGridState();
}

class _ProductsGridState extends State<ProductsGrid> {
  List<Product> prods = [];

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context, listen: false);
    // final products = showFavs ? productsData.favoriteItems : productsData.items;
    return Consumer<Products>(builder: (_, products, ch) {
      prods = products.items;
      for (var i = 0; i < prods.length; i++) {
        print(prods[i].price);
      }
      return prods.isEmpty
          ? const Center(
              child: Text("There is no product!"),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(20.0),
              itemCount: prods.length,
              //use change notifier to make ProductItem wedget listen
              // to any change in products[i] , every product on this screen
              // wil listen to every change on his data
              itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                value: prods[i],
                child: const ProductItem(),
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.55 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
            );
    });
  }
}
