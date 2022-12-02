import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final String? id;
  final String? title;
  final double? amount;
  final int? quantity;

  const CartItem({this.id, this.title, this.amount, this.quantity});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: FittedBox(
              child: Text(
                '\$$amount',
              ),
            ),
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        title: Text(title!),
        subtitle: Text('\$${(amount! * quantity!)}'),
        trailing: Text('$quantity x'),
      ),
    );
  }
}
