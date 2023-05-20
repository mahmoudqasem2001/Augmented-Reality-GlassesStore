import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/views/screens/home_screens/home_screen.dart';
import 'package:shop_app/views/widgets/home_widgets/image_slider.dart';

import '../../../providers/products_provider.dart';
import '../../widgets/home_widgets/product_grid.dart';

enum FilterOption { favorites, all }

class ProductOverViewScreen extends StatefulWidget {
  static const routeName = '/product-overview';

  const ProductOverViewScreen({Key? key}) : super(key: key);

  @override
  State<ProductOverViewScreen> createState() => _ProductOverViewScreenState();
}

class _ProductOverViewScreenState extends State<ProductOverViewScreen> {
  var _isLoading = false;
  var selectedItem;
  //var _isInit= false;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    Provider.of<Products>(context, listen: false)
        .fetchProducts()
        .then(
          (_) => setState(() => _isLoading = false),
        )
        .catchError((_) => setState(
              () => _isLoading = true,
            ));
  }

  @override
  Widget build(BuildContext context) {
    var products = Provider.of<Products>(context, listen: false);

    return Column(
      children: [
        const ImageSlider(),
        //ProductsFilters(),
        Padding(
          padding: const EdgeInsets.only(
            top: 8.0,
            right: 16,
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: SizedBox(
                width: 130,
                //must separete as a widget
                child: DropdownSearch<String>(
                  popupProps: PopupProps.menu(
                    fit: FlexFit.loose,
                    menuProps: MenuProps(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    showSelectedItems: true,
                  ),
                  items: const ['Lowest Price', 'Highest Price'],
                  dropdownDecoratorProps: const DropDownDecoratorProps(
                    baseStyle: TextStyle(fontSize: 11),
                    dropdownSearchDecoration: InputDecoration(
                      labelText: "Sort By",
                    ),
                  ),
                  onChanged: (String? newValue) {
                    products.sortByPrice(newValue);
                    Navigator.pushNamed(
                        context, HomeScreen.routeName);
                  },
                  selectedItem: selectedItem,
                ),
              ),
            ),
            const Spacer(),
            TextButton(
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
                child: const Row(
                  children: [
                    Text('Filters'),
                    Icon(Icons.filter_list_rounded),
                  ],
                ))
          ]),
        ),
        Expanded(
          child: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : const ProductsGrid(),
        ),

        const SizedBox(
          height: 50,
        ),
      ],
    );
  }
}
