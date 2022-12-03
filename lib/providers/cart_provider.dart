import 'package:flutter/foundation.dart';

import '../models/cart_item.dart';

class CartProvider extends ChangeNotifier {
  final Map<String, CartItem> _items = {};

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
            quatity: existingItem.quatity! + 1),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
            id: DateTime.now().toString(),
            title: title,
            amount: amount,
            quatity: 1),
      );
    }
    notifyListeners();
  }

  void removeFromCart(String productId) {
    _items.remove(productId);
    notifyListeners();
  }
}
