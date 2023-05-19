import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/brand.dart';
import '../models/product.dart';
import '../models/glasses_filter.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      brand:Brand(id:1,name: 'ALESSIO SUNGLASSES',countryOfOrigin: 'jenin') ,
      model: 'Fx-193',
      price: 29.99,
      imageUrls: [
        'https://images.ray-ban.com/is/image/RayBan/8056597061421__STD__shad__qt.png?impolicy=RB_Product&width=1024&bgc=%23f2f2f2',
        'https://images.ray-ban.com/is/image/RayBan/8056597061421__STD__shad__fr.png?impolicy=RB_Product&width=1024&bgc=%23f2f2f2',
        'https://images.ray-ban.com/is/image/RayBan/8056597061421__STD__shad__al2.png?impolicy=RB_Product&width=1024&bgc=%23f2f2f2',
        'https://images.ray-ban.com/is/image/RayBan/8056597061421__STD__shad__lt.png?impolicy=RB_Product&width=1024&bgc=%23f2f2f2',
      ],
      colors: ['Black'],
      type: 'SunGlasses',
      gender: 'Male',
      store: 'ALKHALDY',
      border: 'thin',
      shape: 'circle',
    ),
    Product(
      id: 'p2',
      brand:Brand(id: 2,name: 'ALESSIO SUNGLASSES',countryOfOrigin: 'jenin') ,
      model: 'Fx-193',
      price: 22.99,
      imageUrls: [
        'https://images.ray-ban.com/is/image/RayBan/8056597469036__STD__shad__qt.png?impolicy=RB_Product&width=1024&bgc=%23f2f2f2',
        'https://images.ray-ban.com/is/image/RayBan/8056597469036__STD__shad__fr.png?impolicy=RB_Product&width=1024&bgc=%23f2f2f2',
        'https://images.ray-ban.com/is/image/RayBan/8056597469036__STD__shad__al2.png?impolicy=RB_Product&width=1024&bgc=%23f2f2f2',
        'https://images.ray-ban.com/is/image/RayBan/8056597469036__STD__shad__lt.png?impolicy=RB_Product&width=1024&bgc=%23f2f2f2',
      ],
      colors: ['Brown'],
      type: 'SunGlasses',
      gender: 'Male',
      store: 'ALKHALDY',
      border: 'thin',
      shape: 'circle',
    ),
    Product(
      id: 'p3',
      brand:Brand(id: 3,name: 'ALESSIO SUNGLASSES',countryOfOrigin: 'jenin') ,
      model: 'Fx-193',
      price: 34.99,
      imageUrls: [
        'https://images.ray-ban.com/is/image/RayBan/8056597755320__STD__shad__qt.png?impolicy=RB_Product&width=1024&bgc=%23f2f2f2',
        'https://images.ray-ban.com/is/image/RayBan/8056597755320__STD__shad__fr.png?impolicy=RB_Product&width=1024&bgc=%23f2f2f2',
        'https://images.ray-ban.com/is/image/RayBan/8056597755320__STD__shad__al2.png?impolicy=RB_Product&width=1024&bgc=%23f2f2f2',
        'https://images.ray-ban.com/is/image/RayBan/8056597755320__STD__shad__lt.png?impolicy=RB_Product&width=1024&bgc=%23f2f2f2',
      ],
      colors: ['Black'],
      type: 'SunGlasses',
      gender: 'Female',
      store: 'SHAMS',
      border: 'thin',
      shape: 'circle',
    ),
    Product(
      id: 'p4',
      brand:Brand(id: 4,name: 'ALESSIO SUNGLASSES',countryOfOrigin: 'jenin') ,
      model: 'Fx-193',
      price: 20.99,
      imageUrls: [
        'https://images.ray-ban.com/is/image/RayBan/8056597469036__STD__shad__qt.png?impolicy=RB_Product&width=1024&bgc=%23f2f2f2',
        'https://images.ray-ban.com/is/image/RayBan/8056597469036__STD__shad__fr.png?impolicy=RB_Product&width=1024&bgc=%23f2f2f2',
        'https://images.ray-ban.com/is/image/RayBan/8056597469036__STD__shad__al2.png?impolicy=RB_Product&width=1024&bgc=%23f2f2f2',
        'https://images.ray-ban.com/is/image/RayBan/8056597469036__STD__shad__lt.png?impolicy=RB_Product&width=1024&bgc=%23f2f2f2',
      ],
      colors: ['Black'],
      type: 'SunGlasses',
      gender: 'Male',
      store: 'TWEEN',
      border: 'thin',
      shape: 'circle',
    ),
    Product(
      id: 'p6',
      brand:Brand(id: 5,name: 'ALESSIO SUNGLASSES',countryOfOrigin: 'jenin') ,
      model: 'Fx-193',
      price: 41.99,
      imageUrls: [
        'https://images.ray-ban.com/is/image/RayBan/8056597469036__STD__shad__qt.png?impolicy=RB_Product&width=1024&bgc=%23f2f2f2',
        'https://images.ray-ban.com/is/image/RayBan/8056597469036__STD__shad__fr.png?impolicy=RB_Product&width=1024&bgc=%23f2f2f2',
        'https://images.ray-ban.com/is/image/RayBan/8056597469036__STD__shad__al2.png?impolicy=RB_Product&width=1024&bgc=%23f2f2f2',
        'https://images.ray-ban.com/is/image/RayBan/8056597469036__STD__shad__lt.png?impolicy=RB_Product&width=1024&bgc=%23f2f2f2',
      ],
      colors: ['Black'],
      type: 'SunGlasses',
      gender: 'Female',
      store: 'TWEEN',
      border: 'thin',
      shape: 'circle',
    ),
    Product(
      id: 'p5',
      brand:Brand(id: 6,name: 'ALESSIO SUNGLASSES',countryOfOrigin: 'jenin') ,
      model: 'Fx-193',
      price: 39.99,
      imageUrls: [
        'https://images.ray-ban.com/is/image/RayBan/8056597755320__STD__shad__qt.png?impolicy=RB_Product&width=1024&bgc=%23f2f2f2',
        'https://images.ray-ban.com/is/image/RayBan/8056597755320__STD__shad__fr.png?impolicy=RB_Product&width=1024&bgc=%23f2f2f2',
        'https://images.ray-ban.com/is/image/RayBan/8056597755320__STD__shad__al2.png?impolicy=RB_Product&width=1024&bgc=%23f2f2f2',
        'https://images.ray-ban.com/is/image/RayBan/8056597755320__STD__shad__lt.png?impolicy=RB_Product&width=1024&bgc=%23f2f2f2',
      ],
      colors: ['Black'],
      type: 'SunGlasses',
      gender: 'Male',
      store: 'QUEEN',
      border: 'thin',
      shape: 'circle',
    ),
    Product(
      id: 'p7',
      brand:Brand(id: 7,name: 'ALESSIO SUNGLASSES',countryOfOrigin: 'jenin') ,
      model: 'Fx-193',
      price: 16.99,
      imageUrls: [
        'https://images.ray-ban.com/is/image/RayBan/8056597755320__STD__shad__qt.png?impolicy=RB_Product&width=1024&bgc=%23f2f2f2',
        'https://images.ray-ban.com/is/image/RayBan/8056597755320__STD__shad__fr.png?impolicy=RB_Product&width=1024&bgc=%23f2f2f2',
        'https://images.ray-ban.com/is/image/RayBan/8056597755320__STD__shad__al2.png?impolicy=RB_Product&width=1024&bgc=%23f2f2f2',
        'https://images.ray-ban.com/is/image/RayBan/8056597755320__STD__shad__lt.png?impolicy=RB_Product&width=1024&bgc=%23f2f2f2',
      ],
      colors: ['Black'],
      type: 'SunGlasses',
      gender: 'Female',
      store: 'QUEEN',
      border: 'thin',
      shape: 'circle',
    ),
  ];
GlassesFilter _currentFilter = GlassesFilter();

  GlassesFilter get currentFilter => _currentFilter;
 final Product _product = Product();

  get product {
    return _product;
  }

  String _dropdownValue = 'Lowest Price';

  var _productQuantity = 0;

  get productQuantity {
    return _productQuantity;
  }

  

  void setProductQuantity(var count) {
    _productQuantity = count;
    notifyListeners();
  }

  

  get dropdownValue {
    return _dropdownValue;
  }

  void setItems(List<Product> items) {
    _items = items;
    notifyListeners();
  }

  bool _showAttributes = false;

  bool get showAttributes {
    return _showAttributes;
  }

  


void updateFilter(GlassesFilter newFilter) {
    
    notifyListeners();
  }
  // void _setFavValue(bool newValue) {
  //   isFavorite = newValue;
  //   notifyListeners();
  // }

  // Future<void> toggleFavoriteStatus(String token, String userId) async {
  //   final oldStatus = isFavorite;
  //   isFavorite = !isFavorite;
  //   notifyListeners();

  //   final url =
  //       'https://shop-43d63-default-rtdb.firebaseio.com/userFavorites/$userId/$id.json?auth=$token';

  //   try {
  //     final res = await http.put(Uri.parse(url), body: json.encode(isFavorite));
  //     if (res.statusCode >= 400) {
  //       _setFavValue(oldStatus);
  //     }
  //   } catch (e) {
  //     _setFavValue(oldStatus);
  //   }
  // }

  void sortByPrice(String? newValue) {
    List<Product> sortedProd = _items;
    _dropdownValue = newValue!;
    if (dropdownValue == 'Lowest Price') {
      sortedProd.sort((a, b) => a.price!.compareTo(b.price as num));
      // for (var i = 0; i < sortedProd.length; i++) {
      //   print(sortedProd[i].price);
      // }
    } else {
      sortedProd.sort((a, b) => b.price!.compareTo(a.price as num));
      // for (var i = 0; i < sortedProd.length; i++) {
      //   print(sortedProd[i].price);
      // }
    }
    _items = sortedProd;
    notifyListeners();
  }

  String authToken = '';
  String userId = '';

  getData(String authToken, String uId, List<Product> products) {
    this.authToken = authToken;
    userId = uId;
    _items = products;
    notifyListeners();
  }

  List<Product> get items {
    return _items;
  }

  

  Product findById(String? id) {
    return _items.firstWhere((prod) => prod.id == id!);
  }

  Future<void> fetchAndSetProducts([bool filterByUser = false]) async {
    final filteredString =
        filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';

    var url =
        'https://shop-43d63-default-rtdb.firebaseio.com/products.json?auth=$authToken&$filteredString';

    try {
      final res = await http.get(Uri.parse(url));
      final extractedData = json.decode(res.body) as Map<String, dynamic>;
      if (extractedData != true) {
        return;
      }
      url =
          'https://shop-43d63-default-rtdb.firebaseio.com/userFavorites/$userId.json?auth=$authToken';

      final favRes = await http.get(Uri.parse(url));
      final favData = json.decode(favRes.body);

      final List<Product> loadedProducts = [];

      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
          id: prodId,
          brand: prodData['brand'],
          model: prodData['model'],
          price: prodData['price'],
          imageUrls: prodData['imageUrls'],
          border: '',
          colors: [''],
          gender: '',
          shape: '',
          store: '',
          type: '',
        ));
      });

      _items = loadedProducts;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addProduct(Product product) async {
    final url =
        'https://shop-43d63-default-rtdb.firebaseio.com/products.json?auth=$authToken';

    try {
      final res = await http.post(Uri.parse(url),
          body: json.encode({
            'brand': product.brand,
            'model': product.model,
            'imageUrls': product.imageUrls,
            'price': product.price,
            'creatorId': userId,
          }));

      final newProduct = Product(
        id: json.decode(res.body)['name'],
        brand: product.brand,
        model: product.model,
        imageUrls: product.imageUrls,
        price: product.price,
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url =
          'https://shop-43d63-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken';
      await http.patch(Uri.parse(url),
          body: json.encode({
            'brand': newProduct.brand,
            'model': newProduct.model,
            'imageUrls': newProduct.imageUrls,
            'price': newProduct.price,
          }));

      _items[prodIndex] = newProduct;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String id) async {
    final url =
        'https://shop-43d63-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken';
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    Product? existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();

    final res = await http.delete(Uri.parse(url));
    if (res.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw const HttpException('Could not delete Product.');
    }
    existingProduct = null;
  }
}
