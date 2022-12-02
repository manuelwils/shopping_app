import 'package:flutter/foundation.dart';

class CartItem {
  final String? id;
  final String? title;
  final double? amount;
  final int? quatity;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.amount,
    @required this.quatity,
  });
}
