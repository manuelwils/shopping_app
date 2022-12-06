import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/Product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _items = [];
  final String _baseUrl = 'https://ebce-160-152-56-245.ngrok.io/api';

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favorite {
    return [..._items.where((product) => product.favorite)];
  }

  Product findById(String id) {
    return items.firstWhere((element) => element.id == id);
  }

  Future<void> loadAllProducts() async {
    final productGetUrl = Uri.parse(_baseUrl + '/product/all');
    final List<Product> loadedProducts = [];

    try {
      final http.Response fetchedData = await http.get(productGetUrl);
      List<dynamic> products = jsonDecode(fetchedData.body);

      for (var product in products) {
        loadedProducts.add(
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
      _items = loadedProducts;
      notifyListeners();
    } catch (exception) {
      rethrow;
    }
  }

  Future<void> addProduct(Product product) async {
    final productPostUrl = Uri.parse(_baseUrl + '/product/store');

    final productBody = {
      'title': product.title,
      'amount': product.amount.toString(),
      'description': product.description,
      'image': product.image,
    };

    try {
      final response = await http.post(
        productPostUrl,
        body: jsonEncode(productBody),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
      );
      final Map<String, dynamic> result = jsonDecode(response.body);
      final newProduct = Product(
        id: result['id'].toString(),
        title: product.title,
        amount: product.amount,
        image: product.image,
        description: product.description,
      );

      _items.add(newProduct);
      notifyListeners();
    } catch (exception) {
      throw exception;
    }
  }

  void editProduct(String productId, Product product) {
    final prodIndex = _items.indexWhere((product) => product.id == productId);
    if (prodIndex != -1) {
      _items[prodIndex] = product;
    }
    notifyListeners();
  }

  void deleteProduct(String productId) {
    _items.removeWhere((product) => product.id == productId);
    notifyListeners();
  }
}
