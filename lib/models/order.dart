import 'package:flutter/foundation.dart';

import '../providers/cart_provider.dart';

class Order {
  final String? id;
  final double? amount;
  final List<CartProvider>? products;
  final String? orderTime;

  Order({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.orderTime,
  });
}
