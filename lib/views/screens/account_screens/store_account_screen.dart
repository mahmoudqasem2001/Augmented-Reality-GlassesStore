import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/providers/stores_provider.dart';
import 'package:shop_app/views/screens/edit_product_screens/create_product_screen.dart';
import 'package:shop_app/views/widgets/drawer/app_drawer/app_drawer.dart';
import '../../widgets/manage_products_widgets/store_product_item.dart';

class StoreAccountScreen extends StatefulWidget {
  static const routeName = '/store-account';

  const StoreAccountScreen({Key? key}) : super(key: key);

  @override
  State<StoreAccountScreen> createState() => _StoreAccountScreenState();
}

class _StoreAccountScreenState extends State<StoreAccountScreen> {
  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchStoreProducts();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<Auth>(context, listen: false);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        title: Text("${authProvider.store.name!} account"),
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const Text(
              'Profile',
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(
              height: 115,
              width: 115,
              child: CircleAvatar(
                backgroundImage: AssetImage(
                  'assets/images/profile.png',
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            _buildAccountInfo('Store Name:', authProvider.store.name),
            _buildAccountInfo('Phone Number:', authProvider.store.phoneNumber),
            Stack(
              children: [
                Center(
                  child: Text(
                    "Your Products",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        Provider.of<Stores>(context, listen: false)
                            .getAllBrands();
                        Navigator.of(context)
                            .pushNamed(CreateProductScreen.routeName);
                      },
                      icon: const Icon(
                        Icons.add,
                        size: 30,
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: FutureBuilder(
                  future: _refreshProducts(context),
                  builder: (ctx, AsyncSnapshot snapshot) => snapshot
                              .connectionState ==
                          ConnectionState.waiting
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
                                    StoreProductItem(
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountInfo(String label, String? value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          width: double.infinity,
          padding: EdgeInsets.all(16.0),
          margin: EdgeInsets.only(bottom: 8.0),
          child: value == null
              ? Text('none')
              : Text(
                  value,
                  style: TextStyle(fontSize: 16),
                ),
        ),
      ],
    );
  }
}
