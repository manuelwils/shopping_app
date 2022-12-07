import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/Product.dart';
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
    return items.firstWhere((element) => element.id == id);
  }

  Future<void> loadAllProducts() async {
    final productGetUrl = Uri.parse(Url.to['product']!['fetch']!);
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
    final productPostUrl = Uri.parse(Url.to['product']!['store']!);

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
        headers: Url.headers['json_headers'],
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

  Future<void> deleteProduct(String productId) async {
    final productPostUrl =
        Uri.parse(Url.to['product']!['delete']! + '/$productId');

    final prodIndex = _items.indexWhere((product) => product.id == productId);
    Product? oldProduct = _items[prodIndex];

    _items.removeAt(prodIndex);
    notifyListeners();

    final response = await http.delete(
      productPostUrl,
      headers: Url.headers['json_headers'],
    );

    if (response.statusCode >= 400) {
      _items.insert(prodIndex, oldProduct);
      oldProduct = null;
      notifyListeners();
      throw const HttpException('Couldn\'t delete item');
    }
  }
}
