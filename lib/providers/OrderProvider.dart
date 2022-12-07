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

    final _response = await http.post(
      _addOrdersUrl,
      body: {
        'amount': amount,
        'products': cart.map((item) {
          return [
            {
              'id': item.id,
              'title': item.title,
              'amount': item.amount,
              'quantity': item.quatity,
            }
          ];
        }).toList(),
      },
      headers: Url.headers['json_hearders'],
    );

    if (_response.statusCode >= 400) {
      throw const HttpException('Couldn\'t add item to orders');
    }

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
