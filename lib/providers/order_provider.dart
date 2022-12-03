import 'package:flutter/foundation.dart';
import 'package:shopping_app/providers/cart_provider.dart';

class OrderProvider with ChangeNotifier {
  final List<CartProvider> _orders = [];

  List<CartProvider> get orders {
    return [..._orders];
  }

  void addOrders(CartProvider cart, double amount) {
    _orders.insert(0, cart);
    notifyListeners();
  }
}
