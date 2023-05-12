import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/home/image_slider.dart';
import '../../providers/products.dart';
import '../../widgets/home/product_overview/product_grid.dart';

enum FilterOption { favorites, all }

class ProductOverViewScreen extends StatefulWidget {
  static const routeName = '/product-overview';

  const ProductOverViewScreen({Key? key}) : super(key: key);

  @override
  State<ProductOverViewScreen> createState() => _ProductOverViewScreenState();
}

class _ProductOverViewScreenState extends State<ProductOverViewScreen> {
  var _isLoading = false;
  var _showOnlyFavorites = false;
  var selectedItem = null;
  //var _isInit= false;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts()
        .then(
          (_) => setState(() => _isLoading = false),
        )
        .catchError((_) => setState(
              () => _isLoading = false,
            ));
  }

  @override
  Widget build(BuildContext context) {
    var products = Provider.of<Products>(context, listen: false);

    return Column(
      children: [
        ImageSlider(),
        //ProductsFilters(),
        Padding(
          padding: const EdgeInsets.only(
            top: 8.0,
            right: 16,
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            // Container(
            //   padding: const EdgeInsets.symmetric(horizontal: 30),
            //   child: Consumer<Products>(
            //     builder: (_, prds, ch) => DropdownButton<String>(
            //       value: products.dropdownValue,
            //       onChanged: (String? newValue) {
            //         prds.sortByPrice(newValue);
            //        setState(() {

            //        });
            //       },
            //       items: <String>['Lowest Price', 'Highest Price']
            //           .map<DropdownMenuItem<String>>((String value) {
            //         return DropdownMenuItem<String>(
            //           value: value,
            //           child: Text(value),
            //         );
            //       }).toList(),
            //       style:
            //           TextStyle(color: Theme.of(context).colorScheme.primary),
            //       borderRadius: BorderRadius.circular(12),
            //     ),
            //   ),
            // ),

            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: SizedBox(
                width: 130,
                child: DropdownSearch<String>(
                  popupProps: PopupProps.menu(
                    fit: FlexFit.loose,
                    menuProps: MenuProps(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    showSelectedItems: true,
                  ),
                  items: ['Lowest Price', 'Highest Price'],
                  dropdownDecoratorProps: DropDownDecoratorProps(
                    baseStyle: TextStyle(fontSize: 11),
                    dropdownSearchDecoration: InputDecoration(
                      labelText: "Sort By",
                    ),
                  ),
                  onChanged: (String? newValue) {
                    products.sortByPrice(newValue);
                  },
                  selectedItem: selectedItem,
                ),
              ),
            ),
            Spacer(),
            TextButton(
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
                child: Row(
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
              : ProductsGrid(),
        ),

        const SizedBox(
          height: 50,
        ),
      ],
    );
  }
}
