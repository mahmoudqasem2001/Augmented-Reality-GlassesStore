import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/brand.dart';
import 'package:shop_app/providers/products_provider.dart';

import '../../../models/product.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  const EditProductScreen({Key? key}) : super(key: key);

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _brandFocusNode = FocusNode();
  final _modelFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();

  final _imageUrlsController = TextEditingController();

  final _imageUrl1FocusNode = FocusNode();
  final _imageUrl2FocusNode = FocusNode();
  final _imageUrl3FocusNode = FocusNode();
  final _imageUrl4FocusNode = FocusNode();

  final _colorFocusNode = FocusNode();
  final _typeFocusNode = FocusNode();
  final _genderFocusNode = FocusNode();
  final _storeFocusNode = FocusNode();
  final _borderFocusNode = FocusNode();
  final _shapeFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();
  var _editedProduct = Product(
    id: '',
    brand: null,
    model: '',
    price: 0,
    imageUrls: [''],
    color: '',
    type: '',
    gender: '',
    store: '',
    border: '',
    shape: '',
  );
  final _initialValues = {
    'brand': '',
    'model': '',
    'price': '',
    'imageUrls': [''],
    'color': '',
    'type': '',
    'gender': '',
    'store': '',
    'border': '',
    'shape': '',
  };

  final _isInit = true;
  var _isLoading = false;

  // @override
  // void initState() {
  //   super.initState();
  //   _imageUrlsFocusNode.addListener(_updateimageUrls);
  // }

  // @override
  // didChangeDependencies() {
  //   super.didChangeDependencies();
  //   if (_isInit) {
  //     final productId = ModalRoute.of(context)?.settings.arguments;
  //     if (productId != null) {
  //       _editedProduct = Provider.of<Products>(context, listen: false)
  //           .findById(productId as String);

  //       _initialValues = {
  //         'brand': _editedProduct.brand!,
  //         'model': _editedProduct.model!,
  //         'price': _editedProduct.price.toString(),
  //         'imageUrls': ''
  //       };

  //       _imageUrlsController.text = _editedProduct.imageUrls![0];
  //     }
  //     _isInit = false;
  //   }
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _imageUrlsFocusNode.removeListener(_updateimageUrls);
  //   _priceFocusNode.dispose();
  //   _imageUrlsController.dispose();
  //   _imageUrlsFocusNode.dispose();
  //   _modelFocusNode.dispose();
  // }

  // void _updateimageUrls() {
  //   if (!_imageUrlsFocusNode.hasFocus) {
  //     if ((!_imageUrlsController.text.startsWith('http') &&
  //             !_imageUrlsController.text.startsWith('https')) ||
  //         (!_imageUrlsController.text.endsWith('.png') &&
  //             !_imageUrlsController.text.endsWith('.jpg') &&
  //             !_imageUrlsController.text.endsWith('.jpeg'))) {
  //       return;
  //     }

  //     setState(() {});
  //   }
  // }

  Future<void> _saveForm() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    if (_editedProduct.id != null) {
      await Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct.id!, _editedProduct);
    } else {
      try {
        await Provider.of<Products>(context, listen: false)
            .addProduct(_editedProduct);
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
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        title: const Text("Edit Product"),
        actions: [
          IconButton(
            onPressed: _saveForm,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: ListView(children: [
                  TextFormField(
                    initialValue: _initialValues['brand'] as String?,
                    decoration: const InputDecoration(labelText: 'brand'),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_priceFocusNode);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter a brand.";
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _editedProduct = Product(
                          id: _editedProduct.id,
                          brand: Brand(name: newValue),
                          model: _editedProduct.model,
                          price: _editedProduct.price,
                          imageUrls: _editedProduct.imageUrls);
                    },
                  ),
                  TextFormField(
                    initialValue: _initialValues['price'] as String?,
                    decoration: const InputDecoration(labelText: 'Price'),
                    textInputAction: TextInputAction.next,
                    focusNode: _priceFocusNode,
                    keyboardType: TextInputType.number,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_modelFocusNode);
                    },
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
                      _editedProduct = Product(
                          id: _editedProduct.id,
                          brand: _editedProduct.brand,
                          model: _editedProduct.model,
                          price: double.parse(newValue!),
                          imageUrls: _editedProduct.imageUrls);
                    },
                  ),
                  TextFormField(
                    initialValue: _initialValues['model'] as String?,
                    decoration: const InputDecoration(labelText: 'model'),
                    keyboardType: TextInputType.text,
                    focusNode: _modelFocusNode,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter a model";
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _editedProduct = Product(
                          id: _editedProduct.id,
                          brand: _editedProduct.brand,
                          model: newValue,
                          price: _editedProduct.price,
                          imageUrls: _editedProduct.imageUrls);
                    },
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        margin: const EdgeInsets.only(top: 8, right: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                        child: _imageUrlsController.text.isEmpty
                            ? const Text('Enter a URL')
                            : FittedBox(
                                child: Image.network(
                                  _imageUrlsController.text,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: _imageUrlsController,
                          decoration:
                              const InputDecoration(labelText: 'Image URL 1'),
                          keyboardType: TextInputType.url,
                          focusNode: _imageUrl1FocusNode,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return " Please enter an image URL ";
                            }
                            if (!value.startsWith('http') &&
                                !value.startsWith('https')) {
                              return 'Please enter a valid URL.';
                            }
                            if (!value.endsWith('png') &&
                                !value.endsWith('jpg') &&
                                !value.endsWith('jpeg')) {
                              return 'Please enter a valid URL.';
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            // _editedProduct = Product(
                            //     id: _editedProduct.id,
                            //     brand: _editedProduct.brand,
                            //     model: _editedProduct.model,
                            //     price: _editedProduct.price,
                            //     imageUrls: newValue);
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        margin: const EdgeInsets.only(top: 8, right: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                        child: _imageUrlsController.text.isEmpty
                            ? const Text('Enter a URL')
                            : FittedBox(
                                child: Image.network(
                                  _imageUrlsController.text,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: _imageUrlsController,
                          decoration:
                              const InputDecoration(labelText: 'Image URL 2'),
                          keyboardType: TextInputType.url,
                          focusNode: _imageUrl2FocusNode,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return " Please enter an image URL ";
                            }
                            if (!value.startsWith('http') &&
                                !value.startsWith('https')) {
                              return 'Please enter a valid URL.';
                            }
                            if (!value.endsWith('png') &&
                                !value.endsWith('jpg') &&
                                !value.endsWith('jpeg')) {
                              return 'Please enter a valid URL.';
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            // _editedProduct = Product(
                            //     id: _editedProduct.id,
                            //     brand: _editedProduct.brand,
                            //     model: _editedProduct.model,
                            //     price: _editedProduct.price,
                            //     imageUrls: newValue);
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        margin: const EdgeInsets.only(top: 8, right: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                        child: _imageUrlsController.text.isEmpty
                            ? const Text('Enter a URL')
                            : FittedBox(
                                child: Image.network(
                                  _imageUrlsController.text,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: _imageUrlsController,
                          decoration:
                              const InputDecoration(labelText: 'Image URL 3'),
                          keyboardType: TextInputType.url,
                          focusNode: _imageUrl3FocusNode,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return " Please enter an image URL ";
                            }
                            if (!value.startsWith('http') &&
                                !value.startsWith('https')) {
                              return 'Please enter a valid URL.';
                            }
                            if (!value.endsWith('png') &&
                                !value.endsWith('jpg') &&
                                !value.endsWith('jpeg')) {
                              return 'Please enter a valid URL.';
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            // _editedProduct = Product(
                            //     id: _editedProduct.id,
                            //     brand: _editedProduct.brand,
                            //     model: _editedProduct.model,
                            //     price: _editedProduct.price,
                            //     imageUrls: newValue);
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        margin: const EdgeInsets.only(top: 8, right: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                        child: _imageUrlsController.text.isEmpty
                            ? const Text('Enter a URL')
                            : FittedBox(
                                child: Image.network(
                                  _imageUrlsController.text,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: _imageUrlsController,
                          decoration:
                              const InputDecoration(labelText: 'Image URL 4'),
                          keyboardType: TextInputType.url,
                          focusNode: _imageUrl4FocusNode,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return " Please enter an image URL ";
                            }
                            if (!value.startsWith('http') &&
                                !value.startsWith('https')) {
                              return 'Please enter a valid URL.';
                            }
                            if (!value.endsWith('png') &&
                                !value.endsWith('jpg') &&
                                !value.endsWith('jpeg')) {
                              return 'Please enter a valid URL.';
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            // _editedProduct = Product(
                            //     id: _editedProduct.id,
                            //     brand: _editedProduct.brand,
                            //     model: _editedProduct.model,
                            //     price: _editedProduct.price,
                            //     imageUrls: newValue);
                          },
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    initialValue: _initialValues['color'] as String?,
                    decoration: const InputDecoration(labelText: 'color'),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    focusNode: _colorFocusNode,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter a color";
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _editedProduct = Product(
                          id: _editedProduct.id,
                          brand: _editedProduct.brand,
                          model: newValue,
                          price: _editedProduct.price,
                          imageUrls: _editedProduct.imageUrls);
                    },
                  ),
                  TextFormField(
                    initialValue: _initialValues['type'] as String?,
                    decoration: const InputDecoration(labelText: 'type'),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    focusNode: _typeFocusNode,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter a type";
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _editedProduct = Product(
                          id: _editedProduct.id,
                          brand: _editedProduct.brand,
                          model: newValue,
                          price: _editedProduct.price,
                          imageUrls: _editedProduct.imageUrls);
                    },
                  ),
                  TextFormField(
                    initialValue: _initialValues['gender'] as String?,
                    decoration: const InputDecoration(labelText: 'gender'),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    focusNode: _genderFocusNode,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter a gender";
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _editedProduct = Product(
                          id: _editedProduct.id,
                          brand: _editedProduct.brand,
                          model: newValue,
                          price: _editedProduct.price,
                          imageUrls: _editedProduct.imageUrls);
                    },
                  ),
                  TextFormField(
                    initialValue: _initialValues['store'] as String?,
                    decoration: const InputDecoration(labelText: 'store'),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    focusNode: _storeFocusNode,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter a store name";
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _editedProduct = Product(
                          id: _editedProduct.id,
                          brand: _editedProduct.brand,
                          model: newValue,
                          price: _editedProduct.price,
                          imageUrls: _editedProduct.imageUrls);
                    },
                  ),
                  TextFormField(
                    initialValue: _initialValues['border'] as String?,
                    decoration: const InputDecoration(labelText: 'border'),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    focusNode: _borderFocusNode,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter a border type";
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _editedProduct = Product(
                          id: _editedProduct.id,
                          brand: _editedProduct.brand,
                          model: newValue,
                          price: _editedProduct.price,
                          imageUrls: _editedProduct.imageUrls);
                    },
                  ),
                  TextFormField(
                    initialValue: _initialValues['shape'] as String?,
                    decoration: const InputDecoration(labelText: 'shape'),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    focusNode: _shapeFocusNode,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter a shape";
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _editedProduct = Product(
                          id: _editedProduct.id,
                          brand: _editedProduct.brand,
                          model: newValue,
                          price: _editedProduct.price,
                          imageUrls: _editedProduct.imageUrls);
                    },
                  ),
                ]),
              ),
            ),
    );
  }
}
