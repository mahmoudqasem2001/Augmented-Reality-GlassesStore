import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/providers/stores_provider.dart';

class CreateProductScreen extends StatefulWidget {
  static const routeName = '/create-product';
  const CreateProductScreen({Key? key}) : super(key: key);

  @override
  State<CreateProductScreen> createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  var editedProduct = Product();
  final ImagePicker _picker = ImagePicker();
  List<XFile>? _imageFileList = [];
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
    // final productId = ModalRoute.of(context)!.settings.arguments;
    // final initialProduct = Provider.of<Products>(context, listen: false)
    //     .findById(productId as int);
    final storesProvider = Provider.of<Stores>(context, listen: false);
    final productsProvider = Provider.of<Products>(context, listen: false);
    Map<int, String> brands = {};

    for (var brand in storesProvider.brands) {
      brands.putIfAbsent(brand.id!, () => brand.name!);
    }

    Map<String, dynamic> _editedProduct = {
      'model': " ",
      'description': " ",
      'price': " ",
      'brandId': 0,
      'color': " ",
      'type': " ",
      'gender': " ",
      'border': " ",
      'shape': " ",
    };

    Widget editItemPrice() {
      return TextFormField(
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
              selectedItem: " ",
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
              selectedItem: " ",
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
              selectedItem: " ",
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
              selectedItem: " ",
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
              selectedItem: " ",
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
                _editedProduct['brandId'] = id;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return "You must select Color";
                }
                return null;
              },
              selectedItem: " ",
            ),
          ),
        ],
      );
    }

    Widget imagePicker() {
      return ElevatedButton(
          onPressed: () {
            selectImages();
          },
          child: Text('Select Images'));
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        title: Text('Create Product Screen'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              try {
                if (_editedProduct['id'] != null) {
                  await productsProvider.createProduct(_editedProduct, _imageFileList!);
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
          editItemBrand(),
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
          const SizedBox(
            height: 20,
          ),
          imagePicker(),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 400,
            child: GridView.builder(
                itemCount: _imageFileList!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.file(
                      File(_imageFileList![index].path),
                      fit: BoxFit.cover,
                    ),
                  );
                }),
          )
        ]),
      ),
    );
  }

  void selectImages() async {
    final List<XFile> selecedImages = await _picker.pickMultiImage();
    if (selecedImages.isNotEmpty) {
      _imageFileList!.addAll(selecedImages);
    }
  }
}
