// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/providers/stores_provider.dart';
import 'package:shop_app/views/screens/home_screens/home_screen.dart';

class StoreItem extends StatelessWidget {
  final int storeId;
  final String storeName;
  const StoreItem({
    Key? key,
    required this.storeId,
    required this.storeName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final storesProvider = Provider.of<Stores>(context, listen: false);
    final productsProvider = Provider.of<Products>(context, listen: false);
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
                const SizedBox(
                  height: 10,
                ),
                Text(
                  storeName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          child: GestureDetector(
            onTap: () {
              productsProvider.getProductsByStoreId(storeId);
              Navigator.of(context).pushNamed(HomeScreen.routeName);
            },
            child: Hero(
                tag: storeId,
                child: const FadeInImage(
                  placeholder: AssetImage("assets/images/storePlaceholder.PNG"),
                  image: NetworkImage(
                    'https://www.definicionabc.com/wp-content/uploads/tecnologia/App-Store.jpg',
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
