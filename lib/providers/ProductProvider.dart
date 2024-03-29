import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../Models/Product.dart';
import '../Config/Url.dart';
import '../Exceptions/HttpException.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favorite {
    return [..._items.where((product) => product.favorite)];
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> loadAllProducts([bool userProducts = false]) async {
    final _route = Uri.parse(Url.to['product']!['fetch']!);
    final headers = Url().headers;
    headers['user'] = userProducts.toString();

    final List<Product> _loadedProducts = [];

    try {
      final _reponse = await http.get(_route, headers: headers);
      List<dynamic> products = jsonDecode(_reponse.body);

      for (var product in products) {
        _loadedProducts.add(
          Product(
            id: product['id'].toString(),
            title: product['title'],
            amount: double.parse(product['amount'].toString()),
            image: product['image'],
            description: product['description'],
            favorite: product['favorite'] == '0' ? false : true,
          ),
        );
      }
      _items = _loadedProducts;
      notifyListeners();
    } catch (exception) {
      rethrow;
    }
  }

  Future<void> addProduct(Product product) async {
    final _route = Uri.parse(Url.to['product']!['store']!);

    final _payload = {
      'title': product.title,
      'amount': product.amount.toString(),
      'description': product.description,
      'image': product.image,
    };

    try {
      final _response = await http.post(
        _route,
        body: jsonEncode(_payload),
        headers: Url().headers,
      );
      final Map<String, dynamic> result = jsonDecode(_response.body);

      final _newProduct = Product(
        id: result['id'].toString(),
        title: product.title,
        amount: product.amount,
        image: product.image,
        description: product.description,
      );

      _items.add(_newProduct);
      notifyListeners();
    } catch (exception) {
      throw const HttpException('Coudn\'t add product');
    }
  }

  Future<void> editProduct(String productId, Product product) async {
    final _route = Uri.parse(Url.to['product']!['edit']! + '/$productId');
    final _prodIndex = _items.indexWhere((product) => product.id == productId);

    if (_prodIndex == -1) {
      return;
    }

    final _payload = {
      'id': productId,
      'title': product.title,
      'amount': product.amount.toString(),
      'description': product.description,
      'image': product.image,
    };
    final _response = await http.put(
      _route,
      body: jsonEncode(_payload),
      headers: Url().headers,
    );

    if (_response.statusCode >= 400) {
      throw const HttpException('Coudn\' update product');
    } else {
      _items[_prodIndex] = product;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String productId) async {
    final _route = Uri.parse(Url.to['product']!['delete']! + '/$productId');

    final _prodIndex = _items.indexWhere((product) => product.id == productId);
    Product? oldProduct = _items[_prodIndex];

    _items.removeAt(_prodIndex);
    notifyListeners();

    final response = await http.delete(
      _route,
      headers: Url().headers,
    );

    if (response.statusCode >= 400) {
      _items.insert(_prodIndex, oldProduct);
      oldProduct = null;
      notifyListeners();
      throw const HttpException('Couldn\'t delete item');
    } else {
      oldProduct = null;
    }
  }
}
