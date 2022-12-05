import 'package:flutter/foundation.dart';

import '../dummy_products.dart';
import '../models/Product.dart';

class ProductProvider with ChangeNotifier {
  final List<Product> _items = dummyProducts;

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favorite {
    return [..._items.where((product) => product.isFavorite)];
  }

  Product findById(String id) {
    return items.firstWhere((element) => element.id == id);
  }

  void addProduct(Product product) {
    final newProduct = Product(
      id: DateTime.now().toString(),
      title: product.title,
      amount: product.amount,
      image: product.image,
      desc: product.desc,
    );
    _items.add(newProduct);
    notifyListeners();
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
