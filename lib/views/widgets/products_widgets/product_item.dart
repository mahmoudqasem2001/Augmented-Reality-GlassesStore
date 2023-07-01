// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app/shared/assets_images/assets_images.dart';
import 'package:shop_app/views/screens/product_details_screens/product_detail_screen.dart';

import '../../../providers/products_provider.dart';

class ProductItem extends StatelessWidget {
  final int index;
  ProductItem(
    this.index,
    {Key? key}
  );

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context, listen: false);
    final currentProduct = products.items[index];
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
              width: 1.2,
            ),
            color: Colors.white),
        child: GridTile(
          footer: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  currentProduct.brand?.name ?? '',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '\$ ${currentProduct.price.toString()}',
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
                  arguments: currentProduct.id);
            },
            child: Hero(
                tag: currentProduct.id ?? '',
                child: FadeInImage(
                  placeholder: AssetImage(AssetsImages.glassesPlaceHolder),
                  image: NetworkImage(
                    currentProduct.imageUrls?.first ?? '',
                  ),
                  fit: BoxFit.contain,
                )),
          ),
        ),
      ),
    );
  }
}
