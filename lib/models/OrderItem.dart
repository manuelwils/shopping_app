import 'package:flutter/foundation.dart';

import 'CartItem.dart';

class OrderItem {
  final String? id;
  final double? amount;
  final List<CartItem>? products;
  final DateTime? orderTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.orderTime,
  });
}
