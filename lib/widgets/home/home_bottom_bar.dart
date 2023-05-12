import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import '../../providers/general.dart';
import 'badge.dart' as my_badge;

class HomeBottomBar extends StatelessWidget {
  const HomeBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var generalProvider = Provider.of<General>(context, listen: false);

    return CurvedNavigationBar(
      backgroundColor: Colors.transparent,
      index: generalProvider.selectedIndex,
      color: Theme.of(context).colorScheme.primary,
      height: 70,
      animationDuration: const Duration(milliseconds: 700),
      items: [
        const Icon(
          Icons.home,
          size: 30,
          color: Colors.white,
        ),
        Consumer<Cart>(
          child: const Icon(
            Icons.shopping_cart,
            size: 30,
            color: Colors.white,
          ),
          builder: (_, cart, ch) {
            return my_badge.Badge(
              child: ch!,
              value: cart.itemCount.toString(),
              color: Theme.of(context).colorScheme.primary,
            );
          },
        ),
        const Icon(
          Icons.person,
          size: 30,
          color: Colors.white,
        ),
      ],
      onTap: (index) {
        generalProvider.setSelectedIndex(index);
      },
    );
  }
}
