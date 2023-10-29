import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Widgets/components/AppDrawer.dart';
import '../../Providers/OrderProvider.dart';
import '../../Widgets/Orders/OrderItem.dart';
import '../Components/SplashScreen.dart';

class OrderScreen extends StatefulWidget {
  static const String routeName = '/orders';
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    final fetchOrders =
        Provider.of<OrderProvider>(context, listen: false).loadAllOrders();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: fetchOrders,
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? SplashScreen()
                : Consumer<OrderProvider>(
                    builder: (context, orderData, child) => ListView.builder(
                      itemBuilder: (ctx, index) {
                        return OrderItem(orderData.orders[index]);
                      },
                      itemCount: orderData.orders.length,
                    ),
                  ),
      ),
    );
  }
}