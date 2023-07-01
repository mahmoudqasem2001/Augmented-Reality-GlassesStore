// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app/providers/products_provider.dart';

class IncreaseDecreaseItem extends StatelessWidget {
  const IncreaseDecreaseItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 10,
                offset: const Offset(0, 3),
              )
            ],
          ),
          child: IconButton(
            onPressed: () {
              var productQuantity =
                  Provider.of<Products>(context, listen: false).productQuantity;
              if (productQuantity == 0) {
                return;
              }
              productQuantity--;
              Provider.of<Products>(context, listen: false)
                  .incInventoryQuantity();
              Provider.of<Products>(context, listen: false)
                  .setProductQuantity(productQuantity);
            },
            icon: const Icon(Icons.remove),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Consumer<Products>(
            builder: (_, val, ch) => Text(
              val.productQuantity.toString(),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 10,
                offset: const Offset(0, 3),
              )
            ],
          ),
          child: Consumer<Products>(
            builder: (ctx, prods, _) {
              return IconButton(
                onPressed: () {
                  if (prods.inventoryQuantity <= 0) {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        backgroundColor: Colors.blueGrey,
                        content: Text("There is no Items in inventory"),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.of(ctx).pop(),
                              child: const Text('okey!')),
                        ],
                      ),
                    );

                    return;
                  }
                  var productQuantity =
                      Provider.of<Products>(context, listen: false)
                          .productQuantity;
                  productQuantity++;
                  Provider.of<Products>(context, listen: false)
                      .decInventoryQuantity();
                  Provider.of<Products>(context, listen: false)
                      .setProductQuantity(productQuantity);
                },
                icon: const Icon(Icons.add),
              );
            },
          ),
        ),
      ],
    );
  }
}
