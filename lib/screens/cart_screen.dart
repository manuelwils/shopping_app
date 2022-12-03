import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../providers/order_provider.dart';
import '../widgets/cart_item.dart';
import './order_screen.dart';

class CartScreen extends StatelessWidget {
  static const String routeName = '/cart';
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.totalSum}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    padding: const EdgeInsets.all(5),
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  // ElevatedButton(
                  //   onPressed: () {},
                  //   child: Text(
                  //     'ORDER NOW',
                  //     style: TextStyle(color: Theme.of(context).primaryColor),
                  //   ),
                  //   style: ButtonStyle(
                  //     backgroundColor: MaterialStateProperty.all(Colors.white),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                final productId = cart.items.keys.toList()[index];
                final item = cart.items.values.toList()[index];
                return CartItem(
                  productId: productId,
                  id: item.id,
                  title: item.title,
                  amount: item.amount,
                  quantity: item.quatity,
                );
              },
              itemCount: cart.itemCount,
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        height: 40,
        width: 100,
        child: Consumer<OrderProvider>(
          builder: (context, orders, ch) => FloatingActionButton(
            onPressed: () {
              orders.addOrders(cart, cart.totalSum);
              cart.clear();
              Navigator.of(context).pushNamed(OrderScreen.routeName);
            },
            child: const Text('ORDER NOW'),
            backgroundColor: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
