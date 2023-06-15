import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/stores_provider.dart';
import 'package:shop_app/views/widgets/stores_widgets/store_item.dart';

class StoresGrid extends StatelessWidget {
  const StoresGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Stores>(builder: (ctx, storesProvider, _) {
      return storesProvider.isLoadingIndicator
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : storesProvider.stores.isEmpty
              ? const Center(
                  child: Text("There is no Stores!"),
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(20.0),
                  itemCount: storesProvider.stores.length,
                  itemBuilder: (ctx, i) {
                    return StoreItem(
                      storeId: storesProvider.stores[i].id!,
                      storeName: storesProvider.stores[i].name!,
                    );
                  },

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
