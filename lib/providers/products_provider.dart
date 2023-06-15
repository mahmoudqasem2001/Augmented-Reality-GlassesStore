import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/core/api/status_code.dart';
import 'package:shop_app/models/store.dart';
import '../models/brand.dart';
import '../models/glasses_filter.dart';
import '../shared/constants/constants.dart';
import 'product_provider.dart';

class Products with ChangeNotifier {
  List<Product> _items = [];
  List<Brand?> _brands = [];
  List<Product> temp = [];
  bool _itemsFetched = false;
  bool _isLoadingIndicator = true;
  GlassesFilter _currentFilter = GlassesFilter();
  String _dropdownValue = 'Lowest Price';
  int _productQuantity = 0;
  bool _showAttributes = false;

  int _bottomBarSelectedIndex = 0;

  int get bottomBarSelectedIndex {
    return _bottomBarSelectedIndex;
  }

  bool get showAttributes {
    return _showAttributes;
  }

  GlassesFilter get currentFilter => _currentFilter;

  get isLoadingIndicator => _isLoadingIndicator;

  get itemsFetched => _itemsFetched;

  get productQuantity {
    return _productQuantity;
  }

  get dropdownValue {
    return _dropdownValue;
  }

  List<Product> get items {
    return _items;
  }

  List<Brand?> get brands {
    for (var product in _items) {
      _brands.add(product.brand);
    }
    return _brands;
  }

  void setBottomBarSelectedIndex(index) {
    _bottomBarSelectedIndex = index;
    notifyListeners();
  }

  void setIsLoadingIndicator(bool isLoading) {
    _isLoadingIndicator = isLoading;
    notifyListeners();
  }

  void setProductQuantity(var count) {
    _productQuantity = count;
    notifyListeners();
  }

  void setItems(List<Product> items) {
    _items = items;
    notifyListeners();
  }

////////////////
  void updateFilter(String? genderFilter, String? brandNameFilter,
      String? typeFilter, String? borderFilter, String? shapeFilter) {
    GlassesFilter newFilter = GlassesFilter(
      gender: genderFilter,
      brand: Brand(name: brandNameFilter),
      type: typeFilter,
      border: borderFilter,
      shape: shapeFilter,
    );

    List<Product> filteredList;
    filteredList = _items
        .where((product) =>
            (newFilter.border == product.border || newFilter.border == null) &&
            (newFilter.gender == product.gender || newFilter.gender == null) &&
            (newFilter.type == product.type || newFilter.type == null) &&
            (newFilter.shape == product.shape || newFilter.shape == null) &&
            (newFilter.brand?.name == product.brand?.name ||
                newFilter.brand?.name == null))
        .toList();

    _items = filteredList;

    notifyListeners();
  }

  Future<void> clearFilters() async {
    fetchAndSetProducts();
    notifyListeners();
  }

  void sortByPrice(String? newValue) {
    List<Product> sortedProd = _items;
    _dropdownValue = newValue!;
    if (dropdownValue == 'Lowest Price') {
      sortedProd.sort((a, b) => a.price!.compareTo(b.price as num));
    } else {
      sortedProd.sort((a, b) => b.price!.compareTo(a.price as num));
    }
    _items = sortedProd;
    notifyListeners();
  }

  Product findById(int id) {
    Product foundedProduct = _items.firstWhere((prod) => prod.id == id);
    return foundedProduct;
  }

  Future<void> fetchAndSetProducts() async {
    try {
      final response = await http.get(
          Uri.parse('https://ar-store-production.up.railway.app/api/glasses'));
      // print(response.statusCode);
      if (response.statusCode == StatusCode.ok) {
        final jsonData = jsonDecode(response.body) as List<dynamic>;
        List<Product> loadedProducts = [];
        for (dynamic map in jsonData) {
          loadedProducts.add(
            Product(
              id: map['id'],
              price: map['price'] as double,
              rating: map['rating'] as double,
              quantity: map['quantity'] as int,
              store: Store(
                id: map['store']['id'],
                name: map['store']['name'],
                phoneNumber: map['store']['phoneNumber'],
              ),
              brand: Brand(
                id: map['brand']['id'],
                name: map['brand']['name'],
                countryOfOrigin: map['brand']['countryOfOrigin'],
              ),
              model: map['model'],
              color: map['color'],
              type: map['type'],
              gender: map['gender'],
              border: map['border'],
              shape: map['shape'],
              imageUrls: [
                'https://images.ray-ban.com/is/image/RayBan/8056597061421__STD__shad__qt.png?impolicy=RB_Product&width=1024&bgc=%23f2f2f2'
              ],
            ),
          );
        }
        _items = loadedProducts;
        _itemsFetched = true;
        _isLoadingIndicator = false;
      } else {
        throw Exception('Failed to fetch items');
      }
    } catch (error) {
      throw Exception('Failed to fetch items: $error');
    }
    notifyListeners();
  }

  Future<void> updateRating(int rating, int productId) async {
    const url = "https://ar-store-production.up.railway.app/api/glasses/rate";

    Map<String, dynamic> requestRegistrationBody = {
      'itemId': productId,
      'rating': rating,
    };

    Map<String, String> requestHeaders = {
      'accept': '*/*',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: requestHeaders,
        body: jsonEncode(requestRegistrationBody),
      );
      print(response.statusCode);
      if (response.statusCode == StatusCode.ok) {
        print('---------------rating updated');
      } else {
        print('not updated rating');
      }
    } catch (e) {}
  }

  void getProductsByStoreId(int storeId) {
    List<Product> filteredProductsByStore = [];
    filteredProductsByStore =
        _items.where((product) => product.store!.id == storeId).toList();
    _items = filteredProductsByStore;
    notifyListeners();
  }

  Future<void> fetchStoreProducts() async {
    const url =
        "https://ar-store-production.up.railway.app/api/auth/register/stores";

    Map<String, String> requestHeaders = {
      'accept': '*/*',
      'Authorization': 'Bearer $token',
    };

    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: requestHeaders,
      );

      if (response.statusCode == StatusCode.ok) {
        final responseData = json.decode(response.body) as Map<String, dynamic>;
        await fetchAndSetProducts();
        getProductsByStoreId(responseData['id']);
      }
    } catch (e) {}
  }

 
  //////////////////
  ///
  ///
  ///

  Future<void> deleteProduct(int id) async {
    final url = 'https://ar-store-production.up.railway.app/api/glasses/$id';
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);

    Product? existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();

    Map<String, String> requestHeaders = {
      'accept': '*/*',
      'Authorization': 'Bearer $token',
    };

    final res = await http.delete(Uri.parse(url), headers: requestHeaders);
    if (res.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw const HttpException('Could not delete Product.');
    } else if (res.statusCode == StatusCode.ok) {
      print('item deleted with id' + id.toString());
    }
    existingProduct = null;
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

  Future<void> updateProduct(int id, Product newProduct) async {

    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url =
          'https://ar-store-production.up.railway.app/api/glasses/$id';
      await http.put(Uri.parse(url),
          body: json.encode({
            'id':newProduct.id, 
            'price': newProduct.price,
            'brandId':newProduct.brand!.id,
            'model': newProduct.model,
            'color':newProduct.color, 
            'type':newProduct.type, 
            'gender':newProduct.gender, 
            'boder':newProduct.border, 
            'shape':newProduct.shape,
          }));

      _items[prodIndex] = newProduct;
      notifyListeners();
    }
  }

  String authToken = '';
  String userId = '';

  getData(String authToken, String uId, List<Product> products) {
    this.authToken = authToken;
    userId = uId;
    _items = products;
    notifyListeners();
  }
}
