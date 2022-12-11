import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../Exceptions/HttpException.dart';
import '../Config/Url.dart';
import '../Models/CartItem.dart';
import '../Models/OrderItem.dart';

class OrderProvider with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrders(List<CartItem> cart, double amount) async {
    if (cart.isEmpty) {
      return;
    }
    final _route = Uri.parse(Url.to['orders']!['store']!);

    final _payload = {
      'amount': amount.toString(),
      'products': cart.map((item) {
        return {
          'id': item.id,
          'title': item.title,
          'amount': item.amount,
          'quantity': item.quantity,
        };
      }).toList(),
    };

    final _response = await http.post(
      _route,
      body: jsonEncode(_payload),
      headers: Url().headers,
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

  Future<void> loadAllOrders() async {
    final _route = Uri.parse(Url.to['orders']!['fetch']!);

    final http.Response _response =
        await http.get(_route, headers: Url().headers);
    final result = jsonDecode(_response.body);

    if (_response.statusCode >= 400) {
      throw const HttpException('Couldn\'t load orders');
    } else {
      final List<OrderItem> _loadedOrders = [];

      for (var order in result) {
        _loadedOrders.insert(
          0,
          OrderItem(
            id: order['id'].toString(),
            amount: double.parse(order['amount']),
            products: order['products'].forEach(
              (item) {
                CartItem(
                  id: item['id'],
                  title: item['title'],
                  amount: item['amount'],
                  quantity: item['quantity'],
                );
              },
            ),
            orderTime: DateTime.parse(order['created_at']),
          ),
        );
        _orders = _loadedOrders;
        notifyListeners();
      }
    }
  }
}
