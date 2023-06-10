import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product_provider.dart';
import 'package:shop_app/views/widgets/home_widgets/product_item.dart';
import '../../../providers/products_provider.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Product> prods = [];
    return Consumer<Products>(builder: (ctx, products, ch) {
      prods = products.items;
      // print('sort');
      // for (var i = 0; i < prods.length; i++) {
      //   print(prods[i].price);
      // }
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
