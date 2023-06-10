import 'package:flutter/material.dart';



class ItemAppBar extends StatelessWidget {
  const ItemAppBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Container(
      color: Theme.of(context).colorScheme.secondary,
      padding: const EdgeInsets.all(25),
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
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              'Product',
              style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
