import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../Exceptions/HttpException.dart';
import '../Config/Url.dart';
import '../Models/CartItem.dart';
import '../Models/OrderItem.dart';

class OrderProvider with ChangeNotifier {
  final List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrders(List<CartItem> cart, double amount) async {
    if (cart.isEmpty) {
      return;
    }
    final _addOrdersUrl = Uri.parse(Url.to['orders']!['store']!);

    final _data = {
      'amount': amount.toString(),
      'products': cart.map((item) {
        return {
          'title': item.title,
          'quantity': item.quatity,
        };
      }).toList(),
    };

    final _response = await http.post(
      _addOrdersUrl,
      body: jsonEncode(_data),
      headers: Url.headers['json_headers'],
    );

    if (_response.statusCode >= 400) {
      throw const HttpException('Couldn\'t add item to orders');
    } else {
      _orders.insert(
        0,
        OrderItem(
          id: DateTime.now().toString(),
          amount: amount,
          products: cart,
          orderTime: DateTime.now(),
        ),
      );
      notifyListeners();
    }
  }
}
