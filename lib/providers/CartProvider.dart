import 'package:flutter/foundation.dart';

import '../models/CartItem.dart';

class CartProvider extends ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return items.length;
  }

  double get totalSum {
    double total = 0.0;
    _items.forEach((key, item) {
      total += item.amount! * item.quatity!;
    });
    return total;
  }

  void addToCart(String productId, String title, double amount) {
    if (items.containsKey(productId)) {
      _items.update(
        productId,
        (existingItem) => CartItem(
          id: existingItem.id,
          title: existingItem.title,
          amount: existingItem.amount,
          quatity: existingItem.quatity! + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          amount: amount,
          quatity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void removeFromCart(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }

  void removeSingleProduct(String productId) {
    if (!_items.containsKey(productId)) return;
    if (_items[productId]!.quatity! > 1) {
      _items.update(
        productId,
        (existingItem) => CartItem(
          id: existingItem.id,
          title: existingItem.title,
          amount: existingItem.amount,
          quatity: existingItem.quatity! - 1,
        ),
      );
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }
}
