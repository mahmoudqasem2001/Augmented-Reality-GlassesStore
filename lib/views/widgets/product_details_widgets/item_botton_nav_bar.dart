import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/cart_provider.dart';
import '../../../providers/products_provider.dart';

class ItemBottomNavBar extends StatelessWidget {
  const ItemBottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments!;
    final loadedProduct = Provider.of<Products>(context, listen: false)
        .findById(productId as String);
    final cart = Provider.of<Cart>(context, listen: false);
    var quantity = Provider.of<Products>(context, listen: false);
    return BottomAppBar(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                width: 5,
                color: Theme.of(context).colorScheme.secondary,
                child: TextButton(
                  onPressed: () {},
                  child: Column(
                    children: [
                      Text(
                        'TRY WITH AR',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      // const SizedBox(
                      //   height: 0,
                      // ),
                      // const Icon(Icons.camera_alt)
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                width: 5,
                color: Theme.of(context).colorScheme.primary,
                child: TextButton(
                  onPressed: () {
                    if (quantity.productQuantity == 0) {
                      return;
                    }
                    cart.addItem(loadedProduct.id!, loadedProduct.price!,
                        loadedProduct.brand!.name!, quantity.productQuantity);
                    quantity.setProductQuantity(0);
                  },
                  child: Column(
                    children: [
                      Text(
                        'Add To Cart',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
