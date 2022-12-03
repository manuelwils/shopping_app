import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/order_item.dart' as Order;

class OrderItem extends StatelessWidget {
  final Order.OrderItem orders;
  const OrderItem(this.orders);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        title: Text(
          '\$${orders.amount}',
          style: const TextStyle(fontSize: 18),
        ),
        subtitle: Text(
          DateFormat('yy-MM-dd H:m:s').format(orders.orderTime!).toString(),
        ),
        trailing: IconButton(
          icon: const Icon(
            Icons.arrow_downward,
            size: 30,
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
