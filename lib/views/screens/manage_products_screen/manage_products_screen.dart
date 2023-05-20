import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/views/screens/edit_product_screens/edit_product_screen.dart';
import 'package:shop_app/views/widgets/drawer/app_drawer/app_drawer.dart';

import '../../widgets/manage_products_widgets/user_product_item.dart';

class ManageProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  const ManageProductsScreen({Key? key}) : super(key: key);

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        title: const Text("Your Products"),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(EditProductScreen.routeName),
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (ctx, AsyncSnapshot snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    child: Consumer<Products>(
                      builder: (ctx, productsData, _) => Padding(
                        padding: const EdgeInsets.all(8),
                        child: ListView.builder(
                          itemBuilder: (_, int index) => Column(
                            children: [
                              UserProductItem(
                                productsData.items[index].id!,
                                productsData.items[index].brand!.name!,
                                productsData.items[index].imageUrls![0],
                              ),
                              const Divider()
                            ],
                          ),
                          itemCount: productsData.items.length,
                        ),
                      ),
                    ),
                    onRefresh: () => _refreshProducts(context)),
      ),
    );
  }
}
