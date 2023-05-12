import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth.dart';
import '../../providers/product.dart';

enum Fav { fav, notFav }

class ItemAppBar extends StatelessWidget {
  const ItemAppBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<Auth>(context, listen: false);

    return Container(
      color: Theme.of(context).colorScheme.secondary,
      padding: EdgeInsets.all(25),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              size: 30,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'Product',
              style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary),
            ),
          ),
          Spacer(),
          IconButton(
            onPressed: () {
              //product.toggleFavoriteStatus(authData.token!, authData.userId!);
            },
            icon: Icon(
              Icons.favorite,
              color: Colors.red,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
