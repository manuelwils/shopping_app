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
    _items.add(product);
    notifyListeners();
  }

  void deleteProduct(String productId) {
    _items.removeWhere((product) => product.id == productId);
    notifyListeners();
  }
}
