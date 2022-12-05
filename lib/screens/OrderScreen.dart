import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/components/AppDrawer.dart';
import '../providers/OrderProvider.dart';
import '../widgets/OrderItem.dart';

class OrderScreen extends StatelessWidget {
  static const String routeName = '/orders';
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<OrderProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      drawer: const AppDrawer(),
      body: ListView.builder(
        itemBuilder: (ctx, index) => OrderItem(orderData.orders[index]),
        itemCount: orderData.orders.length,
      ),
    );
  }
}
