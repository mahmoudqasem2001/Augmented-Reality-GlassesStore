import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/store.dart';
import 'package:shop_app/providers/stores.dart';
import 'package:shop_app/widgets/stores/store_item.dart';

import '../../providers/products.dart';

class StoresGrid extends StatelessWidget {
  const StoresGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final storesList = Provider.of<Stores>(context, listen: false);

    return storesList.stores.isEmpty
        ? const Center(
            child: Text("There is no product!"),
          )
        : GridView.builder(
            padding: const EdgeInsets.all(20.0),
            itemCount: storesList.stores.length,
            //use change notifier to make ProductItem wedget listen
            // to any change in products[i] , every product on this screen
            // wil listen to every change on his data
            itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
              value: storesList.stores[i],
              child: const StoreItem(),
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.55 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
          );
  }
}
