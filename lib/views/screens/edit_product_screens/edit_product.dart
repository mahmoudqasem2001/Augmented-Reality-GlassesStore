import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product_provider.dart';
import 'package:shop_app/providers/products_provider.dart';

class EditProduct extends StatefulWidget {
  static const routeName = '/edit-product';
  const EditProduct({Key? key}) : super(key: key);

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
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

    Map<String, dynamic> _editedProduct = {
      'id': productId,
      'model': initialProduct.model,
      'quantity': initialProduct.quantity,
      'price': initialProduct.price,
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
        onSaved: (newValue) {
          _editedProduct['price'] = double.parse(newValue!);
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
        onSaved: (newValue) {
          _editedProduct['quantity'] = int.parse(newValue!);
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
        onSaved: (newValue) {
          _editedProduct['model'] = newValue;
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
                _editedProduct['color'] = newValue;
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
                _editedProduct['type'] = newValue;
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
                _editedProduct['gender'] = newValue;
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
                _editedProduct['border'] = newValue;
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
                _editedProduct['shape'] = newValue;
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

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        title: Text('Edit Product Screen'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              try {
                if (_editedProduct['id'] != null) {
                  await Provider.of<Products>(context, listen: false)
                      .updateProduct(
                    _editedProduct['id'],
                    Product(
                      id: _editedProduct['id'],
                      border: _editedProduct['border'],
                      color: _editedProduct['color'],
                      gender: _editedProduct['gender'],
                      model: _editedProduct['model'],
                      price: _editedProduct['price'],
                      shape: _editedProduct['shape'],
                      type: _editedProduct['type'],
                      quantity: _editedProduct['quantity'],
                      brand: initialProduct.brand,
                      imageUrls: initialProduct.imageUrls,
                      rating: initialProduct.rating,
                      store: initialProduct.store,
                    ),
                  );
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
          editItemPrice(),
          const SizedBox(
            height: 20,
          ),
          editItemQuantity(),
          const SizedBox(
            height: 20,
          ),
          editItemModel(),
          const SizedBox(
            height: 20,
          ),
          editItemColor(),
          const SizedBox(
            height: 20,
          ),
          editItemType(),
          const SizedBox(
            height: 20,
          ),
          editItemGender(),
          const SizedBox(
            height: 20,
          ),
          editItemBorder(),
          const SizedBox(
            height: 20,
          ),
          editItemShape(),
        ]),
      ),
    );
  }
}
