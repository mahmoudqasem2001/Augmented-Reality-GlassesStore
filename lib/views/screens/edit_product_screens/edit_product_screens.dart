import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/providers/stores_provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';
  const EditProductScreen({Key? key}) : super(key: key);

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  var editedProduct = Product();

  List<String> colors = [
    "Red",
    "Black",
    "Grey",
    "Brown",
    "Blue",
  ];

  List<String> types = ["Modern", "Old"];

  List<String> borders = [
    "Bold",
    "Thin",
  ];

  List<String> shapes = [
    "Rounded",
    "Square",
  ];

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments;
    final initialProduct = Provider.of<Products>(context, listen: false)
        .findById(productId as int);
    final storesProvider = Provider.of<Stores>(context, listen: false);
    final productsProvider = Provider.of<Products>(context, listen: false);
    Map<int, String> brands = {};

    for (var brand in storesProvider.brands) {
      brands.putIfAbsent(brand.id!, () => brand.name!);
    }

    Map<String, dynamic> editedProduct = {
      'id': productId,
      'model': initialProduct.model,
      'description': initialProduct.description,
      'quantity': initialProduct.quantity,
      'price': initialProduct.price,
      'brandId': initialProduct.brand!.id,
      'color': initialProduct.color,
      'type': initialProduct.type,
      'gender': initialProduct.gender,
      'border': initialProduct.border,
      'shape': initialProduct.shape,
    };

    Widget editItemPrice() {
      return TextFormField(
        initialValue: initialProduct.price.toString(),
        decoration: const InputDecoration(labelText: 'Price'),
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value!.isEmpty) {
            return "Please enter a price.";
          }
          if (double.tryParse(value) == null) {
            return "Please enter a valid price.";
          }
          if (double.parse(value) <= 0) {
            return "Please enter a number greater than zero";
          }
          return null;
        },
        onChanged: (newValue) {
          editedProduct['price'] = double.parse(newValue);
        },
      );
    }

    Widget editItemQuantity() {
      return TextFormField(
        initialValue: initialProduct.quantity.toString(),
        decoration: const InputDecoration(labelText: 'Quantity'),
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value!.isEmpty) {
            return "Please enter a quantity.";
          }
          if (int.tryParse(value) == null) {
            return "Please enter a valid quantity.";
          }
          if (int.parse(value) <= 0) {
            return "Please enter a number greater than zero";
          }
          return null;
        },
        onChanged: (newValue) {
          editedProduct['quantity'] = int.parse(newValue);
        },
      );
    }

    Widget editItemModel() {
      return TextFormField(
        initialValue: initialProduct.model,
        decoration: const InputDecoration(labelText: 'Model'),
        keyboardType: TextInputType.text,
        validator: (value) {
          if (value!.isEmpty) {
            return "Please enter a model";
          }
          return null;
        },
        onChanged: (newValue) {
          editedProduct['model'] = newValue;
        },
      );
    }

    Widget editItemColor() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            width: 130,
            child: DropdownSearch<String>(
              popupProps: PopupProps.menu(
                fit: FlexFit.loose,
                menuProps: MenuProps(
                  borderRadius: BorderRadius.circular(10),
                ),
                showSelectedItems: true,
              ),
              items: colors,
              dropdownDecoratorProps: const DropDownDecoratorProps(
                baseStyle: TextStyle(fontSize: 11),
                dropdownSearchDecoration: InputDecoration(
                  labelText: "Color",
                ),
              ),
              onChanged: (String? newValue) {
                editedProduct['color'] = newValue;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return "You must select Color";
                }
                return null;
              },
              selectedItem: initialProduct.color,
            ),
          ),
        ],
      );
    }

    Widget editItemType() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            width: 130,
            child: DropdownSearch<String>(
              popupProps: PopupProps.menu(
                fit: FlexFit.loose,
                menuProps: MenuProps(
                  borderRadius: BorderRadius.circular(10),
                ),
                showSelectedItems: true,
              ),
              items: types,
              dropdownDecoratorProps: const DropDownDecoratorProps(
                baseStyle: TextStyle(fontSize: 11),
                dropdownSearchDecoration: InputDecoration(
                  labelText: "Type",
                ),
              ),
              onChanged: (String? newValue) {
                editedProduct['type'] = newValue;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return "You must select Type";
                }
                return null;
              },
              selectedItem: initialProduct.type,
            ),
          ),
        ],
      );
    }

    Widget editItemGender() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            width: 130,
            child: DropdownSearch<String>(
              popupProps: PopupProps.menu(
                fit: FlexFit.loose,
                menuProps: MenuProps(
                  borderRadius: BorderRadius.circular(10),
                ),
                showSelectedItems: true,
              ),
              items: const ['MALE', 'FEMALE'],
              dropdownDecoratorProps: const DropDownDecoratorProps(
                baseStyle: TextStyle(fontSize: 11),
                dropdownSearchDecoration: InputDecoration(
                  labelText: "Gender",
                ),
              ),
              onChanged: (String? newValue) {
                editedProduct['gender'] = newValue;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return "You must select gender";
                }
                return null;
              },
              selectedItem: initialProduct.gender,
            ),
          ),
        ],
      );
    }

    Widget editItemBorder() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            width: 130,
            child: DropdownSearch<String>(
              popupProps: PopupProps.menu(
                fit: FlexFit.loose,
                menuProps: MenuProps(
                  borderRadius: BorderRadius.circular(10),
                ),
                showSelectedItems: true,
              ),
              items: borders,
              dropdownDecoratorProps: const DropDownDecoratorProps(
                baseStyle: TextStyle(fontSize: 11),
                dropdownSearchDecoration: InputDecoration(
                  labelText: "Border",
                ),
              ),
              onChanged: (String? newValue) {
                editedProduct['border'] = newValue;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return "You must select Border";
                }
                return null;
              },
              selectedItem: initialProduct.border,
            ),
          ),
        ],
      );
    }

    Widget editItemShape() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            width: 130,
            child: DropdownSearch<String>(
              popupProps: PopupProps.menu(
                fit: FlexFit.loose,
                menuProps: MenuProps(
                  borderRadius: BorderRadius.circular(10),
                ),
                showSelectedItems: true,
              ),
              items: shapes,
              dropdownDecoratorProps: const DropDownDecoratorProps(
                baseStyle: TextStyle(fontSize: 11),
                dropdownSearchDecoration: InputDecoration(
                  labelText: "Shape",
                ),
              ),
              onChanged: (String? newValue) {
                editedProduct['shape'] = newValue;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return "You must select Shape";
                }
                return null;
              },
              selectedItem: initialProduct.shape,
            ),
          ),
        ],
      );
    }

    Widget editItemBrand() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            width: 130,
            child: DropdownSearch<String>(
              popupProps: PopupProps.menu(
                fit: FlexFit.loose,
                menuProps: MenuProps(
                  borderRadius: BorderRadius.circular(10),
                ),
                showSelectedItems: true,
              ),
              items: brands.values.toList(),
              dropdownDecoratorProps: const DropDownDecoratorProps(
                baseStyle: TextStyle(fontSize: 11),
                dropdownSearchDecoration: InputDecoration(
                  labelText: "Brand",
                ),
              ),
              onChanged: (String? newValue) {
                int? id;
                brands.forEach((key, value) {
                  if (value == newValue) {
                    id = key;
                  }
                });
                editedProduct['brandId'] = id;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return "You must select Color";
                }
                return null;
              },
              selectedItem: initialProduct.brand!.name,
            ),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        title: Text('Edit Product Screen'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              try {
                if (editedProduct['id'] != null) {
                  await productsProvider.updateProduct(editedProduct);
                }
              } catch (e) {
                await showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('An error occured!'),
                    content: const Text('Something went wrong.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(),
                        child: const Text('Okey!'),
                      ),
                    ],
                  ),
                );
              }
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: editItemPrice(),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: editItemQuantity(),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: editItemBrand(),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: editItemModel(),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: editItemColor(),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: editItemType(),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: editItemGender(),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: editItemBorder(),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: editItemShape(),
          ),
        ]),
      ),
    );
  }
}
