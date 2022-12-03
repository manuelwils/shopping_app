import 'package:flutter/foundation.dart';
import 'package:shopping_app/models/cart_item.dart';

import '../models/order_item.dart';

class OrderProvider with ChangeNotifier {
  final List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrders(List<CartItem> cart, double amount) {
    if (cart.isNotEmpty) {
      _orders.insert(
        0,
        OrderItem(
          id: DateTime.now().toString(),
          amount: amount,
          products: cart,
          orderTime: DateTime.now(),
        ),
      );
    }
    notifyListeners();
  }
}
