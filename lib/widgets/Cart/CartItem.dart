import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/CartProvider.dart';
import '../Components/DeleteDialog.dart';

class CartItem extends StatelessWidget {
  final String? productId;
  final String? id;
  final String? title;
  final double? amount;
  final int? quantity;

  const CartItem(
      {this.productId, this.id, this.title, this.amount, this.quantity});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(productId),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDeleteDialog(context);
      },
      onDismissed: (direction) {
        Provider.of<CartProvider>(context, listen: false)
            .removeFromCart(productId!);
      },
      background: Container(
        padding: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(5),
        ),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            Icons.delete,
            size: 40,
            color: Colors.white,
          ),
        ),
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.only(right: 20, top: 5, bottom: 5),
      ),
      child: Card(
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
      ),
    );
  }
}
