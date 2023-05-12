import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/store.dart';
import 'package:shop_app/screens/home/home_screen.dart';

class StoreItem extends StatelessWidget {
  const StoreItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<Store>(context, listen: false);

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
                  store.name!,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          child: GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .pushNamed(HomeScreen.routeName, arguments: store.name);
              },
              child: Hero(
                tag: store.id!,
                child: Text(store.name!),
              )),
        ),
      ),
    );
  }
}
