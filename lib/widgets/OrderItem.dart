import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Models/OrderItem.dart' as Order;

class OrderItem extends StatefulWidget {
  final Order.OrderItem orders;
  const OrderItem(this.orders);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _showMore = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              ListTile(
                title: Text(
                  '\$${widget.orders.amount}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                subtitle: Text(
                  DateFormat('yy-MM-dd H:m:s')
                      .format(widget.orders.orderTime!)
                      .toString(),
                ),
                trailing: IconButton(
                  icon: Icon(
                    _showMore ? Icons.expand_less : Icons.expand_more,
                    size: 30,
                  ),
                  onPressed: () {
                    setState(() {
                      _showMore = !_showMore;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        if (_showMore)
          Container(
            height: min(widget.orders.products!.length * 20.0 + 100.0, 100),
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.grey.shade300,
              ),
            ),
            child: ListView(
              children: widget.orders.products!
                  .map(
                    (product) => Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${product.title}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '${product.quatity} x ${product.amount}',
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            '\$${product.amount! * product.quatity!}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
      ],
    );
  }
}
